// add_product_usecase.dart
import 'package:barista_notes/features/pos/domain/entities/product.dart';
import '../../repositories/products_repository.dart';

class AddProductUseCase {
  final ProductsRepository repository;
  AddProductUseCase(this.repository);

  Future<int> call(ProductEntity product) {
    return repository.addProduct(product);
  }
}
