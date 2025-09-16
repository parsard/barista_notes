import 'package:barista_notes/core/constants/color.dart';
import 'package:barista_notes/features/pos/domain/entities/category_entity.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'package:barista_notes/features/pos/presentation/providers/categories_provider.dart';
import 'package:barista_notes/features/pos/presentation/providers/products_filtered_provider.dart';
import 'package:barista_notes/features/pos/presentation/providers/recent_order_provider.dart';
import 'package:barista_notes/features/pos/presentation/widgets/recent_orders_list.dart';
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
    final selectedCategoryId = ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Row(
        children: [
          categoriesAsync.when(
            data: (categories) {
              final allCategories = [
                ...categories,
                CategoryEntity(id: -1, title: 'سفارش‌های اخیر'),
              ];

              if (selectedCategoryId == null && allCategories.isNotEmpty) {
                Future.microtask(() {
                  ref.read(selectedCategoryProvider.notifier).state =
                      allCategories.first.id;
                });
              }

              return CategoryBar(
                categories: allCategories.map((c) => c.title).toList(),
                selectedCategory:
                    allCategories
                        .firstWhere(
                          (c) => c.id == selectedCategoryId,
                          orElse: () => allCategories.first,
                        )
                        .title,
                onCategorySelected: (catTitle) {
                  final catId =
                      allCategories.firstWhere((c) => c.title == catTitle).id;
                  ref.read(selectedCategoryProvider.notifier).state = catId;
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error: $err')),
          ),

          Expanded(
            child:
                selectedCategoryId == -1
                    ? _buildRecentOrdersColumn(ref)
                    : filteredProducts.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
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
                            imageUrl: p.imageUrl,
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
            color: AppColors.brownLess,
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
                ref.invalidate(recentOrdersProvider);
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

Widget _buildRecentOrdersColumn(WidgetRef ref) {
  final recentOrdersAsync = ref.watch(recentOrdersProvider);

  return recentOrdersAsync.when(
    data: (orders) => RecentOrdersList(orders: orders),
    loading:
        () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    error: (err, _) => Center(child: Text('Error: $err')),
  );
}
