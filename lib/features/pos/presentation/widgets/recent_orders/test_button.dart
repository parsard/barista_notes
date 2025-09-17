import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/thermal_recipt_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestButton extends StatelessWidget {
  final String printType;
  final OrderEntity order;
  final TextEditingController ipController;

  const TestButton({
    required this.printType,
    required this.order,
    required this.ipController,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(Icons.preview, size: 16.sp),
      label: Text('تست', style: TextStyle(fontSize: 12.sp)),
      onPressed: () => _showTestOutput(context),
      style: TextButton.styleFrom(
        foregroundColor: Colors.orange,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      ),
    );
  }

  void _showTestOutput(BuildContext context) {
    if (printType == 'thermal') {
      _showThermalPreview(context);
    } else {
      _showPDFPreview(context);
    }
  }

  void _showThermalPreview(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => ThermalReceiptPreview(
            order: order,
            printerIP: ipController.text.trim(),
          ),
    );
  }

  void _showPDFPreview(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'PDF پیش‌نمایش: فایل با نام order_${order.id} ایجاد خواهد شد',
        ),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
