import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/cancel_button.dart';
import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/dialo_title.dart';
import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/order_export_service.dart';
import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/pdf_info_card.dart';
import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/print_button.dart';
import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/print_type_selector.dart';
import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/test_button.dart';
import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/thermal_printer_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barista_notes/core/constants/color.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';

class PrinterSetupDialog extends StatefulWidget {
  final OrderEntity order;

  const PrinterSetupDialog({super.key, required this.order});

  @override
  State<PrinterSetupDialog> createState() => _PrinterSetupDialogState();
}

class _PrinterSetupDialogState extends State<PrinterSetupDialog> {
  final _ipController = TextEditingController(text: '192.168.1.100');
  bool _isProcessing = false;
  String _selectedPrintType = 'thermal';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backGround,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: DialogTitle(),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrintTypeSelector(
              selectedType: _selectedPrintType,
              onTypeChanged:
                  (value) => setState(() => _selectedPrintType = value),
            ),
            if (_selectedPrintType == 'thermal')
              ThermalPrinterConfig(controller: _ipController)
            else
              PDFInfoCard(),
          ],
        ),
      ),
      actions: [
        CancelButton(enabled: !_isProcessing),
        PrintButton(
          isProcessing: _isProcessing,
          printType: _selectedPrintType,
          onPressed: _handlePrint,
        ),
        // دکمه تست جدید
        TestButton(
          printType: _selectedPrintType,
          order: widget.order,
          ipController: _ipController,
        ),
      ],
    );
  }

  Future<void> _handlePrint() async {
    setState(() => _isProcessing = true);

    try {
      if (_selectedPrintType == 'thermal') {
        final ip = _ipController.text.trim();
        if (ip.isEmpty) {
          throw Exception('لطفاً IP پرینتر را وارد کنید');
        }
        await OrderExportService.exportOrder(widget.order, printerIP: ip);
        _showSuccessMessage('رسید با موفقیت در پرینتر چاپ شد');
      } else {
        await OrderExportService.exportOrder(widget.order);
        _showSuccessMessage('فایل PDF با موفقیت ایجاد شد');
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      _showErrorMessage('خطا: ${e.toString().replaceAll('Exception: ', '')}');
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _showSuccessMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }
}
