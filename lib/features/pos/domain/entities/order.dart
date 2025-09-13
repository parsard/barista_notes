class OrderEntity {
  final int? id;
  final DateTime date;
  final double total;
  final bool isPaid;
  final String note;

  OrderEntity({
    this.id,
    required this.date,
    required this.total,
    required this.isPaid,
    required this.note,
  });

  OrderEntity copyWith({
    int? id,
    DateTime? date,
    double? total,
    bool? isPaid,
    String? note,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      total: total ?? this.total,
      isPaid: isPaid ?? this.isPaid,
      note: note ?? this.note,
    );
  }
}
