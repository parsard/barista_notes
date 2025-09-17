import 'package:barista_notes/core/constants/color.dart';
import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThermalPrinterConfig extends StatelessWidget {
  final TextEditingController controller;

  const ThermalPrinterConfig({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'IP Address پرینتر',
            hintText: 'مثال: 192.168.1.100',
            prefixIcon: Icon(Icons.wifi, color: AppColors.brownFull),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            helperText: 'IP پرینتر حرارتی شبکه را وارد کنید',
            helperStyle: TextStyle(fontSize: 11.sp),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        InfoCard(
          color: AppColors.brownFull,
          title: 'راهنمای اتصال:',
          content:
              '1. پرینتر حرارتی را به شبکه وصل کنید\n'
              '2. IP پرینتر را از تنظیمات آن پیدا کنید\n'
              '3. IP را در بالا وارد کرده و چاپ کنید\n'
              '4. معمولاً port 9100 استفاده می‌شود',
        ),
      ],
    );
  }
}
