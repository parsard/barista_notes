import 'package:barista_notes/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrintTypeOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const PrintTypeOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      title: Row(
        children: [
          Icon(icon, size: 20.sp, color: AppColors.brownFull),
          SizedBox(width: 8.w),
          Text(title, style: TextStyle(fontSize: 14.sp)),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12.sp, color: AppColors.cancel),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: (value) => onChanged(value!),
      activeColor: AppColors.brownFull,
    );
  }
}
