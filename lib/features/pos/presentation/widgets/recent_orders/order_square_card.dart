import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'order_details_dialog.dart';
import 'order_export_service.dart';

class OrderSquareCard extends StatefulWidget {
  final OrderEntity order;
  const OrderSquareCard({super.key, required this.order});

  @override
  State<OrderSquareCard> createState() => _OrderSquareCardState();
}

class _OrderSquareCardState extends State<OrderSquareCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isPaid = widget.order.isPaid;
    final bgColor = isPaid ? Colors.green.shade50 : Colors.orange.shade50;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: _isHovered ? 1.03 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'سفارش #${widget.order.id ?? '-'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat('yyyy/MM/dd HH:mm').format(widget.order.date),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
              Text(
                '${widget.order.total.toStringAsFixed(0)} تومان',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:
                      isPaid ? Colors.green.shade700 : Colors.orange.shade700,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.visibility),
                    tooltip: 'جزئیات سفارش',
                    onPressed:
                        () => showOrderDetailsDialog(context, widget.order),
                  ),
                  IconButton(
                    icon: const Icon(Icons.print),
                    tooltip: 'چاپ / خروجی PDF',
                    onPressed:
                        () => OrderExportService.exportOrder(widget.order),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
