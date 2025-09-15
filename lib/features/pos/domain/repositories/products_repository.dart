import 'package:barista_notes/features/pos/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<List<ProductEntity>> getAllProducts();
  Stream<List<ProductEntity>> watchAllProducts();
  Future<int> addProduct(ProductEntity product);
  Future<bool> updateProduct(ProductEntity product);
  Future<int> deleteProduct(int id);
  Future<ProductEntity?> getProductById(int id);
}
