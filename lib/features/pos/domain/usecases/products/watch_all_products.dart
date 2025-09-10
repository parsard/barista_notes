// watch_all_products_usecase.dart
import 'package:barista_notes/features/pos/domain/entities/product.dart';
import '../../repositories/products_repository.dart';

class WatchAllProductsUseCase {
  final ProductsRepository repository;
  WatchAllProductsUseCase(this.repository);

  Stream<List<ProductEntity>> call() {
    return repository.watchAllProducts();
  }
}
