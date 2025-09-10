// get_items_by_order_id_usecase.dart
import '../../entities/order_item.dart';
import '../../repositories/orders_repository.dart';

class GetItemsByOrderIdUseCase {
  final OrdersRepository repository;
  GetItemsByOrderIdUseCase(this.repository);

  Future<List<OrderItemEntity>> call(int orderId) {
    return repository.getItemsByOrderId(orderId);
  }
}
