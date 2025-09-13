import 'package:barista_notes/features/pos/presentation/providers/categories_provider.dart';
import 'package:barista_notes/features/pos/presentation/providers/orders_provider.dart';

import 'package:barista_notes/features/pos/presentation/providers/products_filtered_provider.dart';
import 'package:barista_notes/features/pos/presentation/widgets/add_to_order_dialog.dart';
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
  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(allCategoriesProvider);
    final filteredProducts = ref.watch(filteredProductsProvider);

    return Scaffold(
      body: Row(
        children: [
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

          Expanded(
            child:
                filteredProducts.isEmpty
                    ? const Center(child: Text("هیچ محصولی یافت نشد"))
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final p = filteredProducts[index];
                          print("Product: ${p.id} - ${p.name}");

                          return ProductCard(
                            key: ValueKey(p.id),

                            name: p.name,
                            price: p.price,
                            imageUrl: null,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (_) => AddToOrderDialog(
                                      product: p,
                                      onConfirm: (quantity) {
                                        ref
                                            .read(addItemToOrderProvider)
                                            .call(
                                              product: p,
                                              quantity: quantity,
                                            );
                                      },
                                    ),
                              );
                            },
                          );
                        },
                      ),
                    ),
          ),

          Container(
            width: 200,
            color: Colors.grey.shade200,
            child: const Center(child: Text("Shopping List")),
          ),
        ],
      ),
    );
  }
}
