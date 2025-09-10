import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/daos/categories_dao.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesDao categoriesDao;

  CategoriesRepositoryImpl(this.categoriesDao);

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    final data = await categoriesDao.getAllCategories();
    return data.map((c) => CategoryEntity(id: c.id, title: c.title)).toList();
  }
}
