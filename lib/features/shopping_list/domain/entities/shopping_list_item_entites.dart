import 'package:barista_notes/features/pos/domain/entities/product.dart';

class ShoppingListItemEntity {
  final ProductEntity product;
  final int quantity;

  const ShoppingListItemEntity({required this.product, required this.quantity});

  double get totalPrice => product.price * quantity;

  ShoppingListItemEntity copyWith({ProductEntity? product, int? quantity}) {
    return ShoppingListItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
