import 'package:barista_notes/features/pos/domain/entities/category_entity.dart';
import 'package:barista_notes/features/pos/domain/repositories/categories_repository.dart';

class GetAllCategoriesUseCase {
  final CategoriesRepository repository;

  GetAllCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call() {
    return repository.getAllCategories();
  }
}
