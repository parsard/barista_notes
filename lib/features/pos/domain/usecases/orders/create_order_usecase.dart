// create_order_usecase.dart
import '../../entities/order.dart';
import '../../entities/order_item.dart';
import '../../repositories/orders_repository.dart';

class CreateOrderUseCase {
  final OrdersRepository repository;
  CreateOrderUseCase(this.repository);

  Future<int> call(OrderEntity order, List<OrderItemEntity> items) {
    return repository.createOrder(order, items);
  }
}
