import 'package:barista_notes/app/data/drift_database.dart';
import 'package:barista_notes/features/pos/data/datasources/daos/orders_dao.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'package:barista_notes/features/pos/domain/entities/order_item.dart';
import 'package:barista_notes/features/pos/domain/repositories/orders_repository.dart';
import 'package:drift/drift.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersDao ordersDao;

  OrdersRepositoryImpl(this.ordersDao);

  @override
  Future<int> createOrder(
    OrderEntity order,
    List<OrderItemEntity> items,
  ) async {
    return ordersDao.transaction(() async {
      final orderId = await ordersDao.insertOrder(
        OrdersCompanion.insert(
          createdAt: Value(order.date),
          totalAmount: Value(order.total),
          isPaid: Value(order.isPaid),
          note: Value(order.note),
        ),
      );

      for (var item in items) {
        await ordersDao.insertOrderItem(
          OrderItemsCompanion.insert(
            orderId: orderId,
            productId: item.productId,
            quantity: Value(item.quantity),
            price: item.price,
          ),
        );
      }

      return orderId;
    });
  }

  @override
  Future<List<OrderEntity>> getAllOrders() async {
    final orders = await ordersDao.getAllOrders();
    return orders
        .map(
          (o) => OrderEntity(
            id: o.id,
            date: o.createdAt,
            total: o.totalAmount,
            isPaid: false,
            note: '',
            items: [],
          ),
        )
        .toList();
  }

  @override
  Future<List<OrderItemEntity>> getItemsByOrderId(int orderId) async {
    final items = await ordersDao.getItemsByOrderId(orderId);
    return items
        .map(
          (i) => OrderItemEntity(
            id: i.id,
            orderId: i.orderId,
            productId: i.productId,
            quantity: i.quantity,
            price: i.price,
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteOrder(int id) async {
    await ordersDao.deleteOrder(id);
  }

  @override
  Future<void> addOrderItem(OrderItemEntity item) async {
    await ordersDao.insertOrderItem(
      OrderItemsCompanion.insert(
        orderId: item.orderId,
        productId: item.productId,
        quantity: Value(item.quantity),
        price: item.price,
      ),
    );
  }
}
