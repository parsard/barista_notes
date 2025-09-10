import 'package:drift/drift.dart';
import 'categories_table.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  RealColumn get price => real()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  IntColumn get stock => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
