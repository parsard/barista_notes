import 'package:barista_notes/features/pos/domain/entities/product.dart';
import 'package:barista_notes/features/shopping_list/domain/entities/shopping_list_item_entites.dart';

typedef ShoppingList = List<ShoppingListItemEntity>;

class AddItemToCartUseCase {
  ShoppingList call({
    required ShoppingList currentList,
    required ProductEntity product,
  }) {
    final index = currentList.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (index >= 0) {
      final updatedItem = currentList[index].copyWith(
        quantity: currentList[index].quantity + 1,
      );
      return [...currentList..removeAt(index), updatedItem];
    } else {
      return [
        ...currentList,
        ShoppingListItemEntity(product: product, quantity: 1),
      ];
    }
  }
}
