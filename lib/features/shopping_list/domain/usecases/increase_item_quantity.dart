import 'package:barista_notes/features/shopping_list/domain/entities/shopping_list_item_entites.dart';

typedef ShoppingList = List<ShoppingListItemEntity>;

class IncreaseItemQuantityUseCase {
  ShoppingList call({
    required ShoppingList currentList,
    required int productId,
  }) {
    return currentList.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
  }
}
