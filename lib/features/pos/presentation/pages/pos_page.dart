import 'package:barista_notes/features/pos/presentation/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/category_bar.dart';

class PosPage extends ConsumerStatefulWidget {
  const PosPage({super.key});

  @override
  ConsumerState<PosPage> createState() => _PosPageState();
}

class _PosPageState extends ConsumerState<PosPage> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(allCategoriesProvider);

    return Scaffold(
      body: Row(
        children: [
          categoriesAsync.when(
            data: (categories) {
              final titles = categories.map((c) => c.title).toList();
              return CategoryBar(
                categories: titles,
                selectedCategory: selectedCategory,
                onCategorySelected: (cat) {
                  setState(() => selectedCategory = cat);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error: $err')),
          ),

          Expanded(child: Center(child: Text("Items for $selectedCategory"))),

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
