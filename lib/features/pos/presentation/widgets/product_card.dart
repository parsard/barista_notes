import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String? imageUrl;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child:
                    imageUrl != null && imageUrl!.isNotEmpty
                        ? (imageUrl!.startsWith('http')
                            ? Image.network(imageUrl!, fit: BoxFit.cover)
                            : Image.asset(imageUrl!, fit: BoxFit.cover))
                        : Container(
                          color: Colors.grey.shade200,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image,
                            size: 48.sp,
                            color: Colors.grey,
                          ),
                        ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Text(
                name,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Text(
                "${price.toStringAsFixed(0)} تومان",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
