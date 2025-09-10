import 'package:barista_notes/features/pos/data/datasources/order_item_table.dart';
import 'package:drift/drift.dart';
import 'package:barista_notes/app/data/drift_database.dart';
import 'package:barista_notes/features/pos/data/datasources/orders_table.dart';

part 'orders_dao.g.dart';

@DriftAccessor(tables: [Orders, OrderItems])
class OrdersDao extends DatabaseAccessor<AppDatabase> with _$OrdersDaoMixin {
  OrdersDao(AppDatabase db) : super(db);

  Future<int> insertOrder(OrdersCompanion order) => into(orders).insert(order);

  Future<int> insertOrderItem(OrderItemsCompanion item) =>
      into(orderItems).insert(item);

  Future<List<Order>> getAllOrders() => select(orders).get();

  Future<List<OrderItem>> getItemsByOrderId(int orderId) {
    return (select(orderItems)
      ..where((tbl) => tbl.orderId.equals(orderId))).get();
  }

  Future deleteOrder(int id) =>
      (delete(orders)..where((tbl) => tbl.id.equals(id))).go();
}
