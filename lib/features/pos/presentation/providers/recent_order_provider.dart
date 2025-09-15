// lib/features/pos/presentation/recent_orders/providers/recent_orders_provider.dart
import 'package:barista_notes/features/pos/presentation/composition_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';

final recentOrdersProvider = FutureProvider<List<OrderEntity>>((ref) async {
  final repo = ref.watch(ordersRepositoryProvider);

  final allOrders = await repo.getAllOrders();

  allOrders.sort((a, b) => b.date.compareTo(a.date));
  return allOrders.take(10).toList();
});
