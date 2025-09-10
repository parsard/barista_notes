import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'package:barista_notes/features/pos/domain/entities/order_item.dart';

abstract class OrdersRepository {
  Future<int> createOrder(OrderEntity order, List<OrderItemEntity> items);
  Future<List<OrderEntity>> getAllOrders();
  Future<List<OrderItemEntity>> getItemsByOrderId(int orderId);
  Future<void> deleteOrder(int id);
}
