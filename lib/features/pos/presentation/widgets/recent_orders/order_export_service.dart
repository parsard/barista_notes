import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'package:barista_notes/features/pos/application/services/order_pdf_builder.dart';

class OrderExportService {
  static Future<void> exportOrder(
    OrderEntity order, {
    String? printerIP,
  }) async {
    try {
      if (printerIP != null && printerIP.isNotEmpty) {
        await _printThermalReceipt(order, printerIP);
      } else {
        await _fallbackToPDF(order);
      }
    } catch (e) {
      debugPrint('Error in export: $e');
      await _fallbackToPDF(order);
    }
  }

  static Future<void> _printThermalReceipt(
    OrderEntity order,
    String printerIP,
  ) async {
    try {
      final receiptData = _generateReceiptData(order);

      await _sendToNetworkPrinter(receiptData, printerIP, 9100);
      debugPrint('Receipt printed successfully to $printerIP');
    } catch (e) {
      debugPrint('Error printing thermal: $e');
      throw e;
    }
  }

  static List<int> _generateReceiptData(OrderEntity order) {
    List<int> bytes = [];

    const List<int> init = [27, 64];
    const List<int> center = [27, 97, 1];
    const List<int> left = [27, 97, 0];
    const List<int> bold = [27, 69, 1];
    const List<int> boldOff = [27, 69, 0];
    const List<int> cut = [27, 105];
    const List<int> feedLine = [10];

    bytes.addAll(init);
    bytes.addAll(center);
    bytes.addAll(bold);

    String header = 'کافه باریستا\n';
    bytes.addAll(utf8.encode(header));
    bytes.addAll(feedLine);

    bytes.addAll(utf8.encode('================================\n'));
    bytes.addAll(boldOff);

    bytes.addAll(bold);
    String orderHeader = 'سفارش #${order.id ?? '-'}\n';
    bytes.addAll(utf8.encode(orderHeader));
    bytes.addAll(boldOff);

    String date = '${DateFormat('yyyy/MM/dd HH:mm').format(order.date)}\n';
    bytes.addAll(utf8.encode(date));
    bytes.addAll(feedLine);

    bytes.addAll(left);

    bytes.addAll(utf8.encode('اقلام سفارش:\n'));
    bytes.addAll(utf8.encode('--------------------------------\n'));

    for (var item in order.items) {
      bytes.addAll(bold);
      bytes.addAll(utf8.encode('${item.product.name}\n'));
      bytes.addAll(boldOff);

      String itemLine =
          '${item.quantity} عدد x ${item.totalPrice.toStringAsFixed(0)} = ${item.totalPrice.toStringAsFixed(0)} تومان\n';
      bytes.addAll(utf8.encode(itemLine));
      bytes.addAll(feedLine);
    }

    bytes.addAll(utf8.encode('================================\n'));

    bytes.addAll(center);
    bytes.addAll(bold);
    String total = 'مجموع کل: ${order.total.toStringAsFixed(0)} تومان\n';
    bytes.addAll(utf8.encode(total));
    bytes.addAll(boldOff);
    bytes.addAll(feedLine);

    if (order.isPaid) {
      bytes.addAll(utf8.encode('✓ پرداخت شده\n'));
    } else {
      bytes.addAll(utf8.encode('⏳ در انتظار پرداخت\n'));
    }
    bytes.addAll(feedLine);

    if (order.note.isNotEmpty) {
      bytes.addAll(left);
      bytes.addAll(bold);
      bytes.addAll(utf8.encode('یادداشت:\n'));
      bytes.addAll(boldOff);
      bytes.addAll(utf8.encode('${order.note}\n'));
      bytes.addAll(feedLine);
    }

    bytes.addAll(center);
    bytes.addAll(utf8.encode('با تشکر از انتخاب شما\n'));
    bytes.addAll(utf8.encode('کافه باریستا\n'));
    bytes.addAll(utf8.encode('Tel: 021-12345678\n'));
    bytes.addAll(feedLine);
    bytes.addAll(feedLine);
    bytes.addAll(feedLine);

    bytes.addAll(cut);

    return bytes;
  }

  static Future<void> _sendToNetworkPrinter(
    List<int> data,
    String ip,
    int port,
  ) async {
    Socket? socket;
    try {
      socket = await Socket.connect(
        ip,
        port,
        timeout: const Duration(seconds: 5),
      );

      socket.add(data);
      await socket.flush();

      await Future.delayed(const Duration(milliseconds: 500));

      debugPrint('Data sent to printer successfully');
    } catch (e) {
      debugPrint('Network printer connection error: $e');
      throw Exception('خطا در اتصال به پرینتر: $e');
    } finally {
      try {
        await socket?.close();
      } catch (e) {
        debugPrint('Error closing socket: $e');
      }
    }
  }

  static Future<void> _fallbackToPDF(OrderEntity order) async {
    try {
      final pdf = await OrderPdfBuilder.build(order);
      await Printing.layoutPdf(
        onLayout: (format) async => pdf.save(),
        name:
            'order_${order.id}_${DateFormat('yyyyMMdd_HHmm').format(order.date)}',
      );
      debugPrint('PDF export completed');
    } catch (e) {
      debugPrint('PDF fallback error: $e');
      throw Exception('خطا در ایجاد PDF: $e');
    }
  }
}
