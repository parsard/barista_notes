import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PDFInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        InfoCard(
          color: Colors.blue,
          title: '',
          content: 'فایل PDF ایجاد شده و آماده چاپ یا ذخیره خواهد بود',
        ),
      ],
    );
  }
}
