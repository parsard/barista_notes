import 'package:barista_notes/core/constants/color.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThermalReceiptPreview extends StatelessWidget {
  final OrderEntity order;
  final String printerIP;

  const ThermalReceiptPreview({
    super.key,
    required this.order,
    required this.printerIP,
  });

  // تابع فرمت تاریخ
  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatPersianDate(DateTime date) {
    final persianMonths = [
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند',
    ];

    int persianYear = date.year - 621;
    int persianMonth = date.month;
    int persianDay = date.day;

    return '$persianYear/${persianMonth.toString().padLeft(2, '0')}/${persianDay.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 350.w,
        height: 600.h,
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.receipt, color: AppColors.brownFull),
                SizedBox(width: 8.w),
                Text(
                  'پیش‌نمایش رسید حرارتی',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brownFull,
                  ),
                ),
              ],
            ),
            if (printerIP.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.wifi, color: Colors.green, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'Target: $printerIP:9100',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.green[700],
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 16.h),
            Expanded(
              child: Container(
                width: 250.w,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: SingleChildScrollView(child: _buildReceiptContent()),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('بستن'),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.copy, size: 16.sp),
                    label: Text('کپی متن'),
                    onPressed: () => _copyToClipboard(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brownFull,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'کافه باریستا',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '================================',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12.sp),
        ),
        SizedBox(height: 4.h),
        Text(
          'سفارش #${order.id ?? '-'}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            fontSize: 14.sp,
          ),
        ),
        Text(
          '${_formatDate(order.date)}',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          'اقلام سفارش:',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12.sp),
        ),
        Text(
          '--------------------------------',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12.sp),
        ),

        // اقلام
        ...order.items.map(
          (item) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  '${item.quantity} عدد x ${_formatPrice(item.totalPrice)} = ${_formatPrice(item.totalPrice)} تومان',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11.sp),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 8.h),
        Text(
          '================================',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12.sp),
        ),
        Text(
          'مجموع کل: ${_formatPrice(order.total)} تومان',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            fontSize: 14.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Text(
          order.isPaid ? '✓ پرداخت شده' : '⏳ در انتظار پرداخت',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12.sp),
        ),

        if (order.note.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Text(
            'یادداشت:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              fontSize: 12.sp,
            ),
          ),
          Text(
            order.note,
            style: TextStyle(fontFamily: 'monospace', fontSize: 11.sp),
          ),
        ],

        SizedBox(height: 16.h),
        Text(
          'با تشکر از انتخاب شما',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12.sp),
          textAlign: TextAlign.center,
        ),
        Text(
          'کافه باریستا',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12.sp),
          textAlign: TextAlign.center,
        ),
        Text(
          'Tel: 021-12345678',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          '--- کاغذ بریده می‌شود ---',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.sp,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // تابع فرمت قیمت
  String _formatPrice(double price) {
    return price.toStringAsFixed(0);
  }

  void _copyToClipboard(BuildContext context) {
    final content = _generateReceiptText();
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('محتوای رسید کپی شد'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  String _generateReceiptText() {
    StringBuffer receipt = StringBuffer();

    receipt.writeln('           کافه باریستا');
    receipt.writeln('================================');
    receipt.writeln('سفارش #${order.id ?? '-'}');
    receipt.writeln('${_formatDate(order.date)}');
    receipt.writeln('');
    receipt.writeln('اقلام سفارش:');
    receipt.writeln('--------------------------------');

    for (var item in order.items) {
      receipt.writeln('${item.product.name}');
      receipt.writeln(
        '${item.quantity} عدد  ${_formatPrice(item.totalPrice)} = ${_formatPrice(item.totalPrice)} تومان',
      );
      receipt.writeln('');
    }

    receipt.writeln('================================');
    receipt.writeln('    مجموع کل: ${_formatPrice(order.total)} تومان');
    receipt.writeln('');
    receipt.writeln(order.isPaid ? '✓ پرداخت شده' : '⏳ در انتظار پرداخت');

    if (order.note.isNotEmpty) {
      receipt.writeln('');
      receipt.writeln('یادداشت:');
      receipt.writeln(order.note);
    }

    receipt.writeln('');
    receipt.writeln('      با تشکر از انتخاب شما');
    receipt.writeln('           کافه باریستا');
    receipt.writeln('        Tel: 021-12345678');

    if (printerIP.isNotEmpty) {
      receipt.writeln('');
      receipt.writeln('--- Printer Info ---');
      receipt.writeln('Target: $printerIP:9100');
      receipt.writeln('Protocol: Raw TCP Socket');
    }

    return receipt.toString();
  }
}
