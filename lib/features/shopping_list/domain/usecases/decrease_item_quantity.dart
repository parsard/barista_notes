import 'package:barista_notes/features/shopping_list/domain/entities/shopping_list_item_entites.dart';

typedef ShoppingList = List<ShoppingListItemEntity>;

class DecreaseItemQuantityUseCase {
  ShoppingList call({
    required ShoppingList currentList,
    required int productId,
  }) {
    return currentList
        .map((item) {
          if (item.product.id == productId && item.quantity > 1) {
            return item.copyWith(quantity: item.quantity - 1);
          }
          return item;
        })
        .where((item) => item.quantity > 0)
        .toList();
  }
}
