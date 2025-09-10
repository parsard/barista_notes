import 'package:barista_notes/features/pos/domain/entities/product.dart';
import 'package:barista_notes/features/pos/domain/usecases/products/update_products_usecase.dart';
import 'package:barista_notes/features/pos/domain/usecases/products/watch_all_products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/products/get_all_products_usecase.dart';
import '../../domain/usecases/products/add_product_usecase.dart';

import '../../domain/usecases/products/delete_product_usecase.dart';
import '../../domain/repositories/products_repository.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  throw UnimplementedError('ProductsRepository not implemented');
});

final getAllProductsUseCaseProvider = Provider<GetAllProductsUseCase>((ref) {
  return GetAllProductsUseCase(ref.watch(productsRepositoryProvider));
});

final watchAllProductsUseCaseProvider = Provider<WatchAllProductsUseCase>((
  ref,
) {
  return WatchAllProductsUseCase(ref.watch(productsRepositoryProvider));
});

final addProductUseCaseProvider = Provider<AddProductUseCase>((ref) {
  return AddProductUseCase(ref.watch(productsRepositoryProvider));
});

final updateProductUseCaseProvider = Provider<UpdateProductUseCase>((ref) {
  return UpdateProductUseCase(ref.watch(productsRepositoryProvider));
});

final deleteProductUseCaseProvider = Provider<DeleteProductUseCase>((ref) {
  return DeleteProductUseCase(ref.watch(productsRepositoryProvider));
});

final allProductsProvider = FutureProvider<List<ProductEntity>>((ref) {
  return ref.watch(getAllProductsUseCaseProvider).call();
});

final watchAllProductsProvider = StreamProvider<List<ProductEntity>>((ref) {
  return ref.watch(watchAllProductsUseCaseProvider).call();
});
