import 'package:barista_notes/features/pos/presentation/providers/products_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoryProvider = StateProvider<int?>((ref) => null);

final filteredProductsProvider = Provider((ref) {
  final allProducts = ref.watch(allProductsProvider).value ?? [];
  final selectedCategoryId = ref.watch(selectedCategoryProvider);
  if (selectedCategoryId == null) return allProducts;
  return allProducts.where((p) => p.categoryId == selectedCategoryId).toList();
});
