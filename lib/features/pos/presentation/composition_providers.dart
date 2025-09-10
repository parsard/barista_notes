import 'package:barista_notes/app/data/drift_database.dart';
import 'package:barista_notes/features/pos/data/repositories/orders_repository_impl.dart';
import 'package:barista_notes/features/pos/data/repositories/product_repository_impl.dart';
import 'package:barista_notes/features/pos/domain/repositories/orders_repository.dart';
import 'package:barista_notes/features/pos/domain/repositories/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final productsDaoProvider = Provider((ref) {
  return ref.watch(appDatabaseProvider).productsDao;
});

final ordersDaoProvider = Provider((ref) {
  return ref.watch(appDatabaseProvider).ordersDao;
});

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return ProductsRepositoryImpl(ref.watch(productsDaoProvider));
});

final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  return OrdersRepositoryImpl(ref.watch(ordersDaoProvider));
});
