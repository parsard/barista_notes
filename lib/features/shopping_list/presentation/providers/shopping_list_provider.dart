// features/shopping_list/presentation/providers/shopping_list_provider.dart
import 'package:barista_notes/features/pos/domain/repositories/orders_repository.dart';
import 'package:barista_notes/features/pos/presentation/composition_providers.dart';
import 'package:barista_notes/features/shopping_list/domain/entities/shopping_list_item_entites.dart';
import 'package:barista_notes/features/shopping_list/domain/usecases/add_item_to_cart_usecase.dart';
import 'package:barista_notes/features/shopping_list/domain/usecases/confirm_order_usecase.dart';
import 'package:barista_notes/features/shopping_list/domain/usecases/decrease_item_quantity.dart';
import 'package:barista_notes/features/shopping_list/domain/usecases/increase_item_quantity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barista_notes/features/pos/domain/entities/product.dart';

import '../../domain/usecases/clear_cart_usecase.dart';

class ShoppingListNotifier extends StateNotifier<List<ShoppingListItemEntity>> {
  ShoppingListNotifier() : super([]);
  final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
    throw UnimplementedError();
  });
  final _addItemUC = AddItemToCartUseCase();
  final _increaseUC = IncreaseItemQuantityUseCase();
  final _decreaseUC = DecreaseItemQuantityUseCase();
  final _clearUC = ClearCartUseCase();

  void addItem(ProductEntity product) {
    state = _addItemUC(currentList: state, product: product);
  }

  void increaseQuantity(int productId) {
    state = _increaseUC(currentList: state, productId: productId);
  }

  void decreaseQuantity(int productId) {
    state = _decreaseUC(currentList: state, productId: productId);
  }

  void clear() {
    state = _clearUC();
  }

  double get totalPrice => state.fold(0, (sum, item) => sum + item.totalPrice);
}

final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingListItemEntity>>(
      (ref) => ShoppingListNotifier(),
    );
final confirmOrderUseCaseProvider = Provider<ConfirmOrderUseCase>((ref) {
  final repo = ref.watch(ordersRepositoryProvider);
  return ConfirmOrderUseCase(repo);
});
