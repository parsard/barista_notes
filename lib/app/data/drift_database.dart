import 'dart:io';
import 'package:barista_notes/features/pos/data/datasources/daos/orders_dao.dart';
import 'package:barista_notes/features/pos/data/datasources/daos/products_dao.dart';
import 'package:barista_notes/features/pos/data/datasources/order_item_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:barista_notes/features/pos/data/datasources/categories_table.dart';

import 'package:barista_notes/features/pos/data/datasources/orders_table.dart';
import 'package:barista_notes/features/pos/data/datasources/products_table.dart';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [Products, Categories, Orders, OrderItems],
  daos: [ProductsDao, OrdersDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

extension AppDatabaseSeeder on AppDatabase {
  Future<void> seedDatabase() async {
    final existingCategories = await select(categories).get();
    if (existingCategories.isNotEmpty) return;

    final hotBarId = await into(
      categories,
    ).insert(CategoriesCompanion.insert(title: 'بار گرم'));
    final coldBarId = await into(
      categories,
    ).insert(CategoriesCompanion.insert(title: 'بار سرد'));
    final cakeId = await into(
      categories,
    ).insert(CategoriesCompanion.insert(title: 'کیک'));
    final breakfastId = await into(
      categories,
    ).insert(CategoriesCompanion.insert(title: 'صبحانه'));
    final shakeId = await into(
      categories,
    ).insert(CategoriesCompanion.insert(title: 'شیک'));

    await into(products).insert(
      ProductsCompanion.insert(
        name: ' اسپرسو',
        price: 30000,
        categoryId: (hotBarId),
      ),
    );
    await into(products).insert(
      ProductsCompanion.insert(
        name: 'چای ماسالا',
        price: 35000,
        categoryId: (hotBarId),
      ),
    );
    await into(products).insert(
      ProductsCompanion.insert(
        name: 'آیس لاته',
        price: 40000,
        categoryId: (coldBarId),
      ),
    );
    await into(products).insert(
      ProductsCompanion.insert(
        name: 'کیک شکلاتی',
        price: 25000,
        categoryId: (cakeId),
      ),
    );
    await into(products).insert(
      ProductsCompanion.insert(
        name: 'املت',
        price: 45000,
        categoryId: (breakfastId),
      ),
    );
    await into(products).insert(
      ProductsCompanion.insert(
        name: 'شیک وانیل',
        price: 55000,
        categoryId: (shakeId),
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();

    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    print('DB Path: ${file.path}');

    return NativeDatabase(file);
  });
}
