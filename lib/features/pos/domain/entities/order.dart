import 'package:barista_notes/features/shopping_list/domain/entities/shopping_list_item_entites.dart';

class OrderEntity {
  final int? id;
  final DateTime date;
  final double total;
  final bool isPaid;
  final String note;
  final List<ShoppingListItemEntity> items;
  OrderEntity({
    this.id,
    required this.date,
    required this.total,
    required this.isPaid,
    required this.note,
    required this.items,
  });

  OrderEntity copyWith({
    int? id,
    DateTime? date,
    double? total,
    bool? isPaid,
    String? note,
    List<ShoppingListItemEntity>? items,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      total: total ?? this.total,
      isPaid: isPaid ?? this.isPaid,
      note: note ?? this.note,
      items: items ?? this.items,
    );
  }
}
