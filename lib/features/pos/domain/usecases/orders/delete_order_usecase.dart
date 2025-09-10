// delete_order_usecase.dart
import '../../repositories/orders_repository.dart';

class DeleteOrderUseCase {
  final OrdersRepository repository;
  DeleteOrderUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteOrder(id);
  }
}
