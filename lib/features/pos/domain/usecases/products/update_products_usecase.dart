// update_product_usecase.dart
import 'package:barista_notes/features/pos/domain/entities/product.dart';
import '../../repositories/products_repository.dart';

class UpdateProductUseCase {
  final ProductsRepository repository;
  UpdateProductUseCase(this.repository);

  Future<bool> call(ProductEntity product) {
    return repository.updateProduct(product);
  }
}
