import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:barista_notes/features/pos/domain/entities/order.dart';

class OrderPdfBuilder {
  static Future<pw.Document> build(OrderEntity order) async {
    // 1. Load font
    final fontData = await rootBundle.load(
      'lib/assets/fonts/Vazirmatn-VariableFont_wght.ttf', // مسیر صحیح فایل
    );
    final ttf = pw.Font.ttf(fontData);

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl, // کل صفحه RTL
        theme: pw.ThemeData.withFont(
          base: ttf,
          bold: ttf,
          italic: ttf,
          boldItalic: ttf,
        ),
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'فاکتور سفارش #${order.id ?? '-'}',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'تاریخ: ${DateFormat("yyyy/MM/dd HH:mm").format(order.date)}',
              ),
              pw.SizedBox(height: 20),
              pw.Text('اقلام سفارش:', style: pw.TextStyle(fontSize: 16)),
              pw.SizedBox(height: 8),

              // جدول دستی با RTL کامل
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // هدر جدول
                  pw.TableRow(
                    children:
                        ['قیمت', 'تعداد', 'محصول'].map((header) {
                          return pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              header,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          );
                        }).toList(),
                  ),
                  // ردیف‌های داده
                  ...order.items.map((item) {
                    return pw.TableRow(
                      children:
                          [
                            '${item.totalPrice.toStringAsFixed(0)} تومان',
                            item.quantity.toString(),
                            item.product.name,
                          ].map((cell) {
                            return pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                cell,
                                textAlign: pw.TextAlign.center,
                              ),
                            );
                          }).toList(),
                    );
                  }),
                ],
              ),

              pw.SizedBox(height: 20),
              pw.Text(
                'مبلغ کل: ${order.total.toStringAsFixed(0)} تومان',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              if (order.note.isNotEmpty) ...[
                pw.SizedBox(height: 10),
                pw.Text('یادداشت: ${order.note}'),
              ],
            ],
          );
        },
      ),
    );

    return pdf;
  }
}
