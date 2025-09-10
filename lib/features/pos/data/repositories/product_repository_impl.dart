import 'package:barista_notes/app/data/drift_database.dart';
import 'package:barista_notes/features/pos/data/datasources/daos/products_dao.dart';
import 'package:barista_notes/features/pos/data/datasources/products_table.dart';
import 'package:barista_notes/features/pos/domain/entities/product.dart';
import 'package:barista_notes/features/pos/domain/repositories/products_repository.dart';
import 'package:drift/drift.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDao productsDao;

  ProductsRepositoryImpl(this.productsDao);

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    final products = await productsDao.getAllProducts();
    return products
        .map(
          (p) => ProductEntity(
            id: p.id,
            name: p.name,
            price: p.price,
            categoryId: p.categoryId,
          ),
        )
        .toList();
  }

  @override
  Stream<List<ProductEntity>> watchAllProducts() {
    return productsDao.watchAllProducts().map(
      (products) =>
          products
              .map(
                (p) => ProductEntity(
                  id: p.id,
                  name: p.name,
                  price: p.price,
                  categoryId: p.categoryId,
                ),
              )
              .toList(),
    );
  }

  @override
  Future<int> addProduct(ProductEntity product) {
    return productsDao.insertProduct(
      ProductsCompanion.insert(
        name: product.name,
        price: product.price,
        categoryId: product.categoryId,
      ),
    );
  }

  @override
  Future<bool> updateProduct(ProductEntity product) {
    if (product.id == null) {
      throw ArgumentError('Product ID is required for update');
    }
    return productsDao.updateProduct(
      ProductsCompanion(
        id: Value(product.id!),
        name: Value(product.name),
        price: Value(product.price),
        categoryId: Value(product.categoryId),
      ),
    );
  }

  @override
  Future<int> deleteProduct(int id) {
    return productsDao.deleteProduct(id);
  }
}
