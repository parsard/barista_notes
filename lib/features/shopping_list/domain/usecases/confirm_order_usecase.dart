import 'package:barista_notes/features/shopping_list/domain/entities/shopping_list_item_entites.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'package:barista_notes/features/pos/domain/entities/order_item.dart';
import 'package:barista_notes/features/pos/domain/repositories/orders_repository.dart';

class ConfirmOrderUseCase {
  final OrdersRepository repository;

  ConfirmOrderUseCase(this.repository);

  Future<int> call(OrderEntity order) {
    final orderItems =
        order.items.map((ShoppingListItemEntity shoppingItem) {
          return OrderItemEntity(
            id: null,
            orderId: order.id!,
            productId: shoppingItem.product.id!,
            quantity: shoppingItem.quantity,
            price: shoppingItem.product.price,
          );
        }).toList();

    final updatedOrder = order.copyWith(note: order.note);

    return repository.createOrder(updatedOrder, orderItems);
  }
}
