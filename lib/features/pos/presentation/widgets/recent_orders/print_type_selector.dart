import 'package:barista_notes/core/constants/color.dart';
import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/print_type_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrintTypeSelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeChanged;

  const PrintTypeSelector({
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.brownFull.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          PrintTypeOption(
            title: 'رسید حرارتی',
            subtitle: 'مناسب برای کافه و رستوران',
            icon: Icons.receipt,
            value: 'thermal',
            groupValue: selectedType,
            onChanged: onTypeChanged,
          ),
          Divider(height: 1, color: AppColors.brownFull.withOpacity(0.2)),
          PrintTypeOption(
            title: 'خروجی PDF',
            subtitle: 'برای ذخیره یا چاپ با پرینتر معمولی',
            icon: Icons.picture_as_pdf,
            value: 'pdf',
            groupValue: selectedType,
            onChanged: onTypeChanged,
          ),
        ],
      ),
    );
  }
}
