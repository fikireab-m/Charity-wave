import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:charitywave/configs/configs.dart';
import 'package:charitywave/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceDetails extends StatefulWidget {
  final Region place;
  const PlaceDetails({super.key, required this.place});

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  late Region region;
  String _mapStyle = "";
  BitmapDescriptor? bigRedPin;
  BitmapDescriptor? redPin;
  BitmapDescriptor? greenPin;
  BitmapDescriptor? lightGreenPin;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  void initState() {
    region = widget.place;
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

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final ds = MediaQuery.of(context).size;
    CameraPosition kGooglePlex = CameraPosition(
      target: region.location,
      zoom: 10,
    );
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 360.h,
            width: ds.width,
            child: Column(
              children: [
                Container(
                  height: 240.h,
                  width: ds.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        region.images[activeIndex],
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                              EdgeInsets.fromLTRB(16.sp, 32.sp, 16.sp, 16.sp),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 32.sp,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                    Text(
                                      region.title,
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 56.w,
                          padding: EdgeInsets.symmetric(vertical: 4.sp),
                          margin: EdgeInsets.all(16.sp),
                          decoration: BoxDecoration(
                              color: const Color(0x63000000),
                              borderRadius: BorderRadius.circular(4.r)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 2.sp),
                                child: Icon(
                                  Icons.photo_outlined,
                                  color: const Color(0xFFFFFFFF),
                                  size: 24.sp,
                                ),
                              ),
                              Text(
                                "${region.images.length}",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFFFFFFF),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 120.h,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.sp, 16.sp, 0, 16.sp),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              activeIndex = i;
                            });
                          },
                          child: Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: activeIndex == i
                                  ? Border.all(
                                      color: Colors.blue.shade900,
                                      width: 2.sp,
                                    )
                                  : null,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    region.images[i]),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, i) {
                        return SizedBox(width: 8.sp);
                      },
                      itemCount: region.images.length,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.sp, 0, 16.sp, 4.sp),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.sp),
                    child: Text(
                      'Description',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Text(
                  region.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF00031B),
                        fontSize: 18.sp,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
            child: SizedBox(
                height: 150.h,
                child: GoogleMap(
                  mapType: MapType.terrain,
                  markers: [region]
                      .map(
                        (region) => Marker(
                          markerId: MarkerId(region.title),
                          position: region.location,
                          icon: region.status == Status.red
                              ? redPin!
                              : region.status == Status.green
                                  ? greenPin!
                                  : lightGreenPin!,
                        ),
                      )
                      .toSet(),
                  initialCameraPosition: kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    controller.setMapStyle(_mapStyle);

                    _controller.complete(controller);
                  },
                )),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text(
                'Support Category',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: const Color(0xFF2F67F1)),
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Text(
                    'Donate',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
