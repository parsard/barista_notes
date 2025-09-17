import 'package:barista_notes/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelButton extends StatelessWidget {
  final bool enabled;

  const CancelButton({required this.enabled});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? () => Navigator.pop(context) : null,
      child: Text(
        'لغو',
        style: TextStyle(color: AppColors.cancel, fontSize: 14.sp),
      ),
    );
  }
}
