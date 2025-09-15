import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'package:barista_notes/features/pos/domain/entities/product.dart';
import 'package:barista_notes/features/pos/presentation/providers/categories_provider.dart';
import 'package:barista_notes/features/pos/presentation/providers/products_filtered_provider.dart';
import 'package:barista_notes/features/shopping_list/presentation/providers/shopping_list_provider.dart';
import 'package:barista_notes/features/shopping_list/presentation/widgets/shopping_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/category_bar.dart';
import '../widgets/product_card.dart';

class PosPage extends ConsumerStatefulWidget {
  const PosPage({super.key});

  @override
  ConsumerState<PosPage> createState() => _PosPageState();
}

class _PosPageState extends ConsumerState<PosPage> {
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(allCategoriesProvider);
    final filteredProducts = ref.watch(filteredProductsProvider);

    return Scaffold(
      body: Row(
        children: [
          // ستون 1 - دسته‌بندی محصولات
          categoriesAsync.when(
            data: (categories) {
              final selectedCategoryId = ref.watch(selectedCategoryProvider);
              if (selectedCategoryId == null && categories.isNotEmpty) {
                Future.microtask(() {
                  ref.read(selectedCategoryProvider.notifier).state =
                      categories.first.id;
                });
              }
              return CategoryBar(
                categories: categories.map((c) => c.title).toList(),
                selectedCategory:
                    categories
                        .firstWhere(
                          (c) => c.id == ref.watch(selectedCategoryProvider),
                          orElse: () => categories.first,
                        )
                        .title,
                onCategorySelected: (catTitle) {
                  final catId =
                      categories.firstWhere((c) => c.title == catTitle).id;
                  ref.read(selectedCategoryProvider.notifier).state = catId;
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error: $err')),
          ),

          // ستون 2 - لیست محصولات
          Expanded(
            child:
                filteredProducts.isEmpty
                    ? const Center(child: Text("هیچ محصولی یافت نشد"))
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent:
                                  200, // قابل ریسایز بر اساس عرض
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final p = filteredProducts[index];
                          return ProductCard(
                            key: ValueKey(p.id),
                            name: p.name,
                            price: p.price,
                            imageUrl: null,
                            onTap: () {
                              ref
                                  .read(shoppingListProvider.notifier)
                                  .addItem(p);
                            },
                          );
                        },
                      ),
                    ),
          ),

          Container(
            width: 300,
            color: Colors.grey.shade100,
            padding: const EdgeInsets.all(8.0),
            child: ShoppingListView(
              noteController: noteController,
              onConfirm: () async {
                final shoppingList = ref.read(shoppingListProvider);
                if (shoppingList.isEmpty) return;

                final total = shoppingList.fold<double>(
                  0,
                  (sum, item) => sum + item.totalPrice,
                );

                final newOrder = OrderEntity(
                  id: null,
                  date: DateTime.now(),
                  total: total,
                  isPaid: false,
                  note: noteController.text,
                  items: shoppingList,
                );

                await ref.read(confirmOrderUseCaseProvider).call(newOrder);

                ref.read(shoppingListProvider.notifier).clear();
                noteController.clear();
              },
              onCancel: () {
                ref.read(shoppingListProvider.notifier).clear();
                noteController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
