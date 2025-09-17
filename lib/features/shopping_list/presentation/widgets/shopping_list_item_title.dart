import 'package:barista_notes/core/constants/color.dart';
import 'package:barista_notes/features/shopping_list/domain/entities/shopping_list_item_entites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/shopping_list_provider.dart';

class ShoppingListItemTile extends ConsumerWidget {
  final ShoppingListItemEntity item;
  const ShoppingListItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(shoppingListProvider.notifier);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.backGround,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        title: Text(
          item.product.name,
          style: TextStyle(
            color: AppColors.cancel,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Text(
          '${item.quantity} × ${item.product.price}',
          style: TextStyle(
            color: AppColors.cancel,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => notifier.decreaseQuantity(item.product.id!),
              icon: const Icon(Icons.remove, color: AppColors.cancel),
              tooltip: 'کاهش تعداد',
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => notifier.increaseQuantity(item.product.id!),
              icon: const Icon(Icons.add, color: AppColors.cancel),
              tooltip: 'افزایش تعداد',
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: () => notifier.removeItem(item.product.id!),
              icon: const Icon(
                Icons.delete,
                color: Color.fromARGB(255, 227, 98, 0),
              ),
              tooltip: 'حذف آیتم',
            ),
          ],
        ),
      ),
    );
  }
}
