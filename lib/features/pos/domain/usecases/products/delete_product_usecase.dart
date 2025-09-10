// delete_product_usecase.dart
import '../../repositories/products_repository.dart';

class DeleteProductUseCase {
  final ProductsRepository repository;
  DeleteProductUseCase(this.repository);

  Future<int> call(int id) {
    return repository.deleteProduct(id);
  }
}
