import 'dart:async';
import 'package:charitywave/configs/configs.dart';
import 'package:charitywave/models/models.dart';
import 'package:charitywave/screens/mapview/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.1551705, 39.8724459),
    zoom: 5,
  );
  final TextEditingController placeController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String _mapStyle = "";
  Region? selectedRegion;
  BitmapDescriptor? bigRedPin;
  BitmapDescriptor? redPin;
  BitmapDescriptor? greenPin;
  BitmapDescriptor? lightGreenPin;

  late List<Region> regions;
  Future<List<Region>> getAllRegions() async {
    regions = [
      Region(
        title: 'Israel & Palestine',
        subtitle: 'Civil War',
        location: const LatLng(32.538081, 35.565805),
        images: [
          'https://www.washingtoninstitute.org/sites/default/files/imports/israel-palestinian-flagsAP08100306412.jpg',
          "https://www.brookings.edu/wp-content/uploads/2016/06/israel_palestine_flags001.jpg"
        ],
        supportCategories: [
          Category(
              title: 'Shelter 🏠',
              donationRaised: 1327680,
              donationRequired: 10200000),
          Category(
              title: 'Food & Water 🥗',
              donationRaised: 11024000,
              donationRequired: 11024000),
          Category(
              title: 'First Aid ⛑️',
              donationRaised: 2297640,
              donationRequired: 2802000),
        ],
        status: Status.red,
        id: 1,
        volunteerID: 1,
        suppID: 1,
        description: 'Help please',
        addedAt: 1700682461,
      ),
      Region(
        id: 2,
        title: 'Syria',
        subtitle: 'Refugee Camp',
        location: const LatLng(36.362433, 37.449789),
        images: [
          'https://i.natgeofe.com/k/51057134-22d3-4f29-85ab-9643d23cb829/Damascus_Syria_KIDS_0821_square.jpg',
          "https://www.hrw.org/sites/default/files/styles/opengraph/public/media_2021/12/202112mena_syria_wr.jpg?h=56be0d78&itok=77fQ8CHp"
        ],
        supportCategories: [
          Category(
            title: 'Shelter 🏠',
            donationRaised: 1327680,
            donationRequired: 10200000,
          ),
          Category(
            title: 'Food & Water 🥗',
            donationRaised: 11024000,
            donationRequired: 11024000,
          ),
          Category(
            title: 'First Aid 🍲',
            donationRaised: 2297640,
            donationRequired: 2802000,
          ),
        ],
        status: Status.red,
        volunteerID: 2,
        suppID: 2,
        description: 'Help',
        addedAt: 1700682461,
      ),
      Region(
        title: 'Iraq',
        subtitle: 'Warzone',
        location: const LatLng(32.510292, 42.091684),
        images: [
          'https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2017/09/09/989866-879079193.jpg?itok=f9KuAgOU'
        ],
        supportCategories: [
          Category(
              title: 'Shelter 🏠',
              donationRaised: 1327680,
              donationRequired: 10200000),
          Category(
              title: 'Food & Water 🥗',
              donationRaised: 11024000,
              donationRequired: 11024000),
          Category(
              title: 'First Aid 🍲',
              donationRaised: 2297640,
              donationRequired: 2802000),
        ],
        status: Status.lightGreen,
        id: 3,
        volunteerID: 3,
        suppID: 3,
        description: 'Help',
        addedAt: 1700682461,
      ),
      Region(
        title: 'Israel',
        subtitle: 'Seige',
        images: [
          'https://static.independent.co.uk/2023/11/09/05/Israel_Palestinians_58925.jpg?quality=75&width=640&crop=3%3A2%2Csmart&auto=webp'
        ],
        location: const LatLng(30.1551705, 39.8724459),
        supportCategories: [
          Category(
              title: 'Shelter 🏠',
              donationRaised: 1327680,
              donationRequired: 10200000),
          Category(
              title: 'Food & Water 🥗',
              donationRaised: 11024000,
              donationRequired: 11024000),
          Category(
              title: 'First Aid 🍲',
              donationRaised: 2297640,
              donationRequired: 2802000),
        ],
        status: Status.green,
        id: 4,
        volunteerID: 4,
        suppID: 4,
        description: 'Help',
        addedAt: 1700682461,
      ),
    ];
    await Future.delayed(const Duration(seconds: 2));
    return regions;
  }

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/styles/map_style.json').then((string) {
      _mapStyle = string;
    });
    rootBundle.load(AppIcons.bigRedPin).then((value) {
      setState(() {
        bigRedPin = BitmapDescriptor.fromBytes(value.buffer.asUint8List());
      });
    });
    rootBundle.load(AppIcons.redPin).then((value) {
      setState(() {
        redPin = BitmapDescriptor.fromBytes(value.buffer.asUint8List());
      });
    });
    rootBundle.load(AppIcons.greenPin).then((value) {
      setState(() {
        greenPin = BitmapDescriptor.fromBytes(value.buffer.asUint8List());
      });
    });
    rootBundle.load(AppIcons.lightGreenPin).then((value) {
      setState(() {
        lightGreenPin = BitmapDescriptor.fromBytes(value.buffer.asUint8List());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      onPopInvoked: (_) {
        if (selectedRegion != null) {
          setState(() {
            selectedRegion = null;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            forceMaterialTransparency: true,
            centerTitle: true,
            title: const Text(
              'Impact-Chain.org',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Gordita',
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0.sp,
                    horizontal: 16.0.sp,
                  ),
                  child: Container(
                    width: 48.sp,
                    height: 48.sp,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(Images.unknownPerson),
                        fit: BoxFit.contain,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromARGB(255, 199, 199, 199),
                        width: 1.sp,
                      ),
                    ),
                  ),
                ),
              )
            ]),
        body: FutureBuilder<List<Region>>(
            future: getAllRegions(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              } else {
                return Stack(alignment: Alignment.topCenter, children: [
                  (redPin != null && greenPin != null && lightGreenPin != null)
                      ? GoogleMap(
                          mapType: MapType.normal,
                          onTap: (LatLng value) {
                            setState(() {
                              selectedRegion = null;
                            });
                          },
                          markers: regions
                              .map(
                                (region) => Marker(
                                  onTap: () {
                                    setState(() {
                                      selectedRegion = region;
                                    });
                                  },
                                  markerId: MarkerId(region.title),
                                  position: region.location,
                                  icon: region.status == Status.red &&
                                          selectedRegion == region
                                      ? bigRedPin!
                                      : region.status == Status.red &&
                                              selectedRegion != region
                                          ? redPin!
                                          : region.status == Status.green
                                              ? greenPin!
                                              : lightGreenPin!,
                                ),
                              )
                              .toSet(),
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            controller.setMapStyle(_mapStyle);

                            _controller.complete(controller);
                          },
                        )
                      : const SizedBox(),
                  Container(
                    margin: EdgeInsets.only(top: 10.sp),
                    width: screenWidth * .9,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 5.r,
                              spreadRadius: 3.r,
                              offset: const Offset(0, 2))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: TextField(
                        controller: placeController,
                        readOnly: true,
                        onTap: () async {
                          const apiKey =
                              "AIzaSyDBHrTNaRSvRfHtcHXvRi42Hbr7znyH8sU";
                          GoogleMapsPlaces places =
                              GoogleMapsPlaces(apiKey: apiKey);
                          Prediction? prediction =
                              await PlacesAutocomplete.show(
                                  context: context,
                                  apiKey: apiKey,
                                  mode: Mode.overlay,
                                  components: [],
                                  types: [],
                                  strictbounds: false);

                          if (prediction != null) {
                            final place = await places
                                .getDetailsByPlaceId(prediction.placeId!);
                            final geometry = place.result.geometry;
                            if (geometry != null) {
                              final controller = await _controller.future;
                              final location = place.result.geometry!.location;

                              placeController.text = place.result.name;
                              controller.animateCamera(CameraUpdate.newLatLng(
                                  LatLng(location.lat, location.lng)));
                            }
                          }

                          placeController.text = "";
                        },
                        decoration: InputDecoration(
                          hintText: "Search by location...",
                          border: InputBorder.none,
                          prefixIconConstraints:
                              BoxConstraints(maxHeight: 25.sp),
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.sp),
                            child: Image.asset(AppIcons.locationPin),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (selectedRegion != null)
                    RegionIntro(region: selectedRegion!)
                ]);
              }
            }),
      ),
    );
  }
}
