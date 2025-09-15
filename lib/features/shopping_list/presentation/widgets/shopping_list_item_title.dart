import 'package:barista_notes/features/shopping_list/domain/entities/shopping_list_item_entites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/shopping_list_provider.dart';

class ShoppingListItemTile extends ConsumerWidget {
  final ShoppingListItemEntity item;
  const ShoppingListItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(shoppingListProvider.notifier);

    return ListTile(
      title: Text(item.product.name),
      subtitle: Text('${item.quantity} × ${item.product.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => notifier.decreaseQuantity(item.product.id!),
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: () => notifier.increaseQuantity(item.product.id!),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
