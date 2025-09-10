// get_all_orders_usecase.dart
import '../../entities/order.dart';
import '../../repositories/orders_repository.dart';

class GetAllOrdersUseCase {
  final OrdersRepository repository;
  GetAllOrdersUseCase(this.repository);

  Future<List<OrderEntity>> call() {
    return repository.getAllOrders();
  }
}
