import 'package:barista_notes/core/constants/color.dart';
import 'package:barista_notes/features/shopping_list/presentation/widgets/shopping_list_item_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/shopping_list_provider.dart';

class ShoppingListView extends ConsumerWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final TextEditingController noteController;

  const ShoppingListView({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(shoppingListProvider);
    final total = ref.read(shoppingListProvider.notifier).totalPrice;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index) {
              final item = items[index];
              return ShoppingListItemTile(item: item);
            },
          ),
        ),
        TextField(
          controller: noteController,
          decoration: const InputDecoration(labelText: 'یادداشت سفارش'),
        ),
        Text('مجموع: $total تومان'),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8D6748),
                ),
                onPressed: onConfirm,
                child: Text(
                  'تأیید سفارش',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE3D6C9),
                  ),
                ),
              ),
            ),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFFFFF8E1),
                ),
                onPressed: onCancel,
                child: Text(
                  'منصرف شدن',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5C4137),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
