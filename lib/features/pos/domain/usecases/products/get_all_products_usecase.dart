import 'package:barista_notes/features/pos/domain/entities/product.dart';
import '../../repositories/products_repository.dart';

class GetAllProductsUseCase {
  final ProductsRepository repository;

  GetAllProductsUseCase(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getAllProducts();
  }
}
