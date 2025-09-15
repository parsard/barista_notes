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
          ),
        );
      },
    );
  }
}
