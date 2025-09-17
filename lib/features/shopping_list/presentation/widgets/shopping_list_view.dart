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
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.backGround, // Use your shopping list bg color
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: SizedBox(
            height: 80.h,
            child: Scrollbar(
              thumbVisibility: true,
              child: TextField(
                controller: noteController,
                maxLines: null,
                expands: true,
                style: TextStyle(fontSize: 15.sp, color: AppColors.cancel),
                decoration: InputDecoration(
                  hintText: 'یادداشت سفارش',
                  hintStyle: TextStyle(
                    color: AppColors.cancel,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 24.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
          decoration: BoxDecoration(
            color: AppColors.backGround,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مجموع:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.cancel,
                ),
              ),
              Text(
                '$total تومان',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.cancel,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 28.h),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 8.w),
                height: 44.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8D6748),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: onConfirm,
                  child: Text(
                    'تأیید سفارش',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE3D6C9),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8.w),
                height: 44.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFFFFF8E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: onCancel,
                  child: Text(
                    'منصرف شدن',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5C4137),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}
