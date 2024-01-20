import 'package:charitywave/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CategoryListView extends StatelessWidget {
  final Region region;
  const CategoryListView({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final List<Category> categories = region.supportCategories;

    return SizedBox(
        width: screenWidth * 0.9,
        height: 148.h,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              Category category = categories[index];
              return SizedBox(
                child: Stack(children: [
                  Container(
                    height: 116.h,
                    width: screenWidth * .7,
                    margin: EdgeInsets.only(right: 20.sp),
                    decoration: BoxDecoration(
                      color:
                          (category.donationRaised != category.donationRequired)
                              ? const Color(0xFFEFF4F9)
                              : const Color(0xFFDAFFED),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: screenWidth * .9 - 148.w,
                              child: Text(
                                category.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text('${index + 1}/${categories.length}',
                                style: const TextStyle(color: Colors.grey))
                          ]),
                      subtitle: Column(children: [
                        LinearProgressIndicator(
                            value: category.donationRaised /
                                category.donationRequired,
                            minHeight: 2.h,
                            color: (category.donationRaised !=
                                    category.donationRequired)
                                ? const Color(0xFF2F67F1)
                                : const Color(0xFF00D06C),
                            backgroundColor: Colors.grey),
                        (category.donationRaised != category.donationRequired)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10.sp),
                                          child: Text(
                                            'Donation Raised',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                '\$${NumberFormat(null, 'en_US').format(category.donationRaised)}',
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFF071C75),
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(
                                                ' / \$${NumberFormat(null, 'en_US').format(category.donationRequired)}',
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.grey))
                                          ],
                                        )
                                      ]),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.sp, vertical: 1.sp),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFE8E8E8),
                                            blurRadius: 3.5.r,
                                            spreadRadius: 2.r,
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30.r)),
                                    child: Text(
                                        '${((category.donationRaised / category.donationRequired) * 100).toStringAsPrecision(2)}%'),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10.sp),
                                          Text('100% Funded!',
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                              width: 120.w,
                                              child: Text(
                                                  'Thanks to your incredible support',
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors
                                                          .grey.shade700)))
                                        ]),
                                    Text(
                                      '\$${NumberFormat(null, 'en_US').format(category.donationRequired)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF00AA58),
                                      ),
                                    ),
                                  ])
                      ]),
                    ),
                  ),
                  if (category.donationRaised != category.donationRequired)
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 16.sp, bottom: 16.sp),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.sp, vertical: 4.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: const Color(0xFF2F67F1),
                            ),
                            child: Text(
                              'Donate',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                ]),
              );
            }));
  }
}
