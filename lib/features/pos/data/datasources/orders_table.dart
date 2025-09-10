import 'package:drift/drift.dart';

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  RealColumn get totalAmount => real().withDefault(const Constant(0.0))();
  BoolColumn get isPaid => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
}
