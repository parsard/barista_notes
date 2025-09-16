import 'package:printing/printing.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'package:barista_notes/features/pos/application/services/order_pdf_builder.dart';

class OrderExportService {
  static Future<void> exportOrder(OrderEntity order) async {
    // ساخت PDF
    final pdf = await OrderPdfBuilder.build(order); // اینجا await لازم است

    // نمایش و چاپ PDF
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}
