class ProductEntity {
  final int? id;
  final String name;
  final double price;
  final int categoryId;

  ProductEntity({
    this.id,
    required this.name,
    required this.price,
    required this.categoryId,
  });
}
