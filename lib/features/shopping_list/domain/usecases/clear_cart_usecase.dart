import 'package:barista_notes/features/shopping_list/domain/entities/shopping_list_item_entites.dart';

typedef ShoppingList = List<ShoppingListItemEntity>;

class ClearCartUseCase {
  ShoppingList call() => [];
}
