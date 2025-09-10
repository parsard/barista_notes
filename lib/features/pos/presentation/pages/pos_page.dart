import 'package:barista_notes/features/pos/presentation/providers/categories_provider.dart';

import 'package:barista_notes/features/pos/presentation/providers/products_filtered_provider.dart';
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
          // --- ستون دسته‌ها ---
          categoriesAsync.when(
            data: (categories) {
              final titles = categories.map((c) => c.title).toList();
              return CategoryBar(
                categories: titles,
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

          // --- ستون محصولات ---
          Expanded(
            child:
                filteredProducts.isEmpty
                    ? const Center(child: Text("هیچ محصولی یافت نشد"))
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.75,
                            ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final p = filteredProducts[index];
                          return ProductCard(
                            name: p.name,
                            price: p.price,
                            imageUrl: null, // TODO: اضافه کردن لینک تصویر
                            onTap: () {
                              // افزودن به لیست خرید
                            },
                          );
                        },
                      ),
                    ),
          ),

          // --- ستون لیست خرید ---
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
