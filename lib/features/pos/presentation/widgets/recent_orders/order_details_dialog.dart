import 'package:flutter/material.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';

void showOrderDetailsDialog(BuildContext context, OrderEntity order) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text('جزئیات سفارش #${order.id ?? '-'}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...order.items.map(
              (item) => Text('${item.product.name} × ${item.quantity}'),
            ),
            if (order.note.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('یادداشت: ${order.note}'),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('بستن'),
          ),
        ],
      );
    },
  );
}
