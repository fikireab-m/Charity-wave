import 'package:cached_network_image/cached_network_image.dart';
import 'package:charitywave/models/models.dart';
import 'package:charitywave/screens/placedetail/placedetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'category_list_view.dart';

class RegionIntro extends StatelessWidget {
  final Region region;
  const RegionIntro({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
        bottom: 0,
        child: Container(
            height: 316.h,
            width: screenWidth,
            padding: EdgeInsets.only(bottom: 8.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE8E8E8),
                  blurRadius: 3.5.r,
                  spreadRadius: 1,
                  offset: const Offset(0, -3),
                )
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(children: [
              Container(
                width: screenWidth,
                margin: EdgeInsets.symmetric(
                  vertical: 24.sp,
                  horizontal: 16.sp,
                ),
                padding: EdgeInsets.all(4.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE8E8E8),
                      blurRadius: 3.5.r,
                      spreadRadius: 1.r,
                      offset: const Offset(0, 0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 90.w,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(region.images[1]),
                          ),
                        ),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: const Color(0x63000000),
                            child: Text(
                              region.images.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.sp),
                        child: SizedBox(
                          width: screenWidth - 228.w,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  region.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5.sp),
                                Text(
                                  region.subtitle,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: const Color(0xFF888787),
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaceDetails(place: region),
                            ),
                          ),
                          child: Icon(
                            Icons.info,
                            size: 40.sp,
                            color: const Color.fromRGBO(47, 103, 241, 1),
                          ),
                        ),
                      )
                    ]),
              ),
              CategoryListView(region: region),
            ])));
  }
}
