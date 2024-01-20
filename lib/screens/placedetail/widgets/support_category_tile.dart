import 'package:charitywave/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SupportCategoryListTile extends StatelessWidget {
  final Category category;
  const SupportCategoryListTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 4.sp),
      decoration: BoxDecoration(
          color: (category.donationRaised != category.donationRequired)
              ? const Color(0xFFEFF4F9)
              : const Color(0xFFDAFFED),
          borderRadius: BorderRadius.circular(20.r)),
      child: ListTile(
        title: Text(
          category.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        subtitle: Column(
          children: [
            LinearProgressIndicator(
                value: category.donationRaised / category.donationRequired,
                minHeight: 2,
                color: (category.donationRaised != category.donationRequired)
                    ? const Color(0xFF2F67F1)
                    : const Color(0xFF00D06C),
                backgroundColor: Colors.grey),
            (category.donationRaised != category.donationRequired)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 10.sp),
                                child: Text('Donation Raised',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600))),
                            Row(children: [
                              Text(
                                  '\$${NumberFormat(null, 'en_US').format(category.donationRaised)}',
                                  style: TextStyle(
                                      color: const Color(0xFF071C75),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                  ' / \$${NumberFormat(null, 'en_US').format(category.donationRequired)}',
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.grey))
                            ])
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
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                              '${((category.donationRaised / category.donationRequired) * 100).toStringAsPrecision(2)}%'))
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.sp),
                              Text('100% Funded!',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  width: 120.w,
                                  child: Text(
                                      'Thanks to your incredible support',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey[700]!)))
                            ]),
                        Text(
                            '\$${NumberFormat(null, 'en_US').format(category.donationRequired)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00AA58)))
                      ])
          ],
        ),
      ),
    );
  }
}
