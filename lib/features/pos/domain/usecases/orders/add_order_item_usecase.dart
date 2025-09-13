import '../../entities/order_item.dart';
import '../../repositories/orders_repository.dart';

class AddOrderItemUseCase {
  final OrdersRepository repository;
  AddOrderItemUseCase(this.repository);

  Future<void> call({
    required int orderId,
    required int productId,
    required int quantity,
    required double price,
  }) {
    final item = OrderItemEntity(
      id: null,
      orderId: orderId,
      productId: productId,
      quantity: quantity,
      price: price,
    );

    return repository.addOrderItem(item);
  }
}
