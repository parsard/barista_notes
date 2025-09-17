import 'package:barista_notes/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoCard extends StatelessWidget {
  final Color color;
  final String title;
  final String content;

  const InfoCard({
    required this.color,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.info_outline, color: color, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
          ] else ...[
            Row(
              children: [
                Icon(Icons.info_outline, color: color, size: 16.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(content, style: TextStyle(fontSize: 12.sp)),
                ),
              ],
            ),
          ],
          if (title.isNotEmpty)
            Text(
              content,
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColors.cancel,
                height: 1.3,
              ),
            ),
        ],
      ),
    );
  }
}
