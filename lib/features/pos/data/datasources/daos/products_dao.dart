import 'package:drift/drift.dart';
import 'package:barista_notes/app/data/drift_database.dart';
import 'package:barista_notes/features/pos/data/datasources/products_table.dart';

part 'products_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductsDao extends DatabaseAccessor<AppDatabase>
    with _$ProductsDaoMixin {
  ProductsDao(AppDatabase db) : super(db);

  Future<List<Product>> getAllProducts() => select(products).get();

  Stream<List<Product>> watchAllProducts() => select(products).watch();

  Future<int> insertProduct(ProductsCompanion entry) =>
      into(products).insert(entry);

  Future<bool> updateProduct(ProductsCompanion entry) =>
      update(products).replace(entry);

  Future<int> deleteProduct(int id) =>
      (delete(products)
        ..where((tbl) => tbl.id.equals(id))).go(); // در ProductsDao
  Future<Product?> getProductById(int id) {
    return (select(products)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
