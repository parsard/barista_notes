import 'package:barista_notes/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrintButton extends StatelessWidget {
  final bool isProcessing;
  final String printType;
  final VoidCallback onPressed;

  const PrintButton({
    required this.isProcessing,
    required this.printType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isProcessing ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brownFull,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child:
          isProcessing
              ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text('در حال پردازش...', style: TextStyle(fontSize: 12.sp)),
                ],
              )
              : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    printType == 'thermal' ? Icons.print : Icons.picture_as_pdf,
                    size: 18.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    printType == 'thermal' ? 'چاپ رسید' : 'ایجاد PDF',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
    );
  }
}
