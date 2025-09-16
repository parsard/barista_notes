import 'package:barista_notes/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryBar extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String> onCategorySelected;
  final Map<String, IconData> categoryIcons; // این بخش اضافه شد

  const CategoryBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.categoryIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      color: AppColors.brownLess,
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final categoryTitle = categories[index];
          final isSelected = categoryTitle == selectedCategory;
          final icon = categoryIcons[categoryTitle] ?? Icons.label;

          return GestureDetector(
            onTap: () => onCategorySelected(categoryTitle),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isSelected ? Colors.brown.shade300 : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: isSelected ? AppColors.text : AppColors.backGround,
                    size: 18,
                  ),
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      categoryTitle,
                      style: TextStyle(
                        color:
                            isSelected ? AppColors.text : AppColors.backGround,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
