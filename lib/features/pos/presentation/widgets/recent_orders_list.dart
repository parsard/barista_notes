import 'package:flutter/material.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'package:intl/intl.dart';

class RecentOrdersList extends StatelessWidget {
  final List<OrderEntity> orders;
  const RecentOrdersList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(child: Text('هیچ سفارش اخیر وجود ندارد'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const Divider(height: 8),
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          color: Colors.white,
          child: ListTile(
            title: Text(
              'سفارش #${order.id ?? '-'}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(DateFormat('yyyy/MM/dd HH:mm').format(order.date)),
            trailing: Text(
              '${order.total.toStringAsFixed(0)} تومان',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              _showOrderDetails(context, order);
            },
          ),
        );
      },
    );
  }

  void _showOrderDetails(BuildContext context, OrderEntity order) {
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
                (item) => Text(
                  '${item.product.name} × ${item.quantity}',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 8),
              if (order.note != null && order.note!.isNotEmpty)
                Text(
                  'یادداشت: ${order.note}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
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
}
