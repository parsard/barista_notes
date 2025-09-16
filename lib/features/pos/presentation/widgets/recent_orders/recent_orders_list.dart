import 'package:flutter/material.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'order_square_card.dart';

class RecentOrdersList extends StatelessWidget {
  final List<OrderEntity> orders;
  const RecentOrdersList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(child: Text('هیچ سفارش اخیر وجود ندارد'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderSquareCard(order: orders[index]);
      },
    );
  }
}
