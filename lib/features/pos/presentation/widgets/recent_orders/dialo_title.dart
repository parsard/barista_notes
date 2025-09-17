import 'package:barista_notes/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.print, color: AppColors.brownFull, size: 24.sp),
        SizedBox(width: 8.w),
        Text(
          'گزینه‌های چاپ',
          style: TextStyle(
            color: AppColors.brownFull,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }
}
