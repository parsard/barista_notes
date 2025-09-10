import 'package:barista_notes/features/pos/domain/entities/category_entity.dart';
import 'package:barista_notes/features/pos/domain/usecases/categories/get_all_categories_usecase..dart';
import 'package:barista_notes/features/pos/presentation/composition_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/categories_repository_impl.dart';
import '../../data/datasources/daos/categories_dao.dart';

final categoriesDaoProvider = Provider<CategoriesDao>((ref) {
  final db = ref.read(appDatabaseProvider);
  return CategoriesDao(db);
});

final categoriesRepositoryProvider = Provider((ref) {
  return CategoriesRepositoryImpl(ref.read(categoriesDaoProvider));
});

final getAllCategoriesUseCaseProvider = Provider((ref) {
  return GetAllCategoriesUseCase(ref.read(categoriesRepositoryProvider));
});

final allCategoriesProvider = FutureProvider<List<CategoryEntity>>((ref) {
  return ref.read(getAllCategoriesUseCaseProvider).call();
});
