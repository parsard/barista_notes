import 'package:barista_notes/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatefulWidget {
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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;
  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[600]!,
      highlightColor: Colors.grey[300]!,
      child: Container(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: _isHovered ? 1.03 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12.r),
            child: Card(
              color: AppColors.backGround.withOpacity(0.9),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.r),
                      ),
                      child:
                          widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                              ? (widget.imageUrl!.startsWith('http')
                                  ? Image.network(
                                    widget.imageUrl!,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) return child;
                                      return _buildShimmerPlaceholder();
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                      );
                                    },
                                  )
                                  : Image.asset(
                                    widget.imageUrl!,
                                    fit: BoxFit.cover,
                                    frameBuilder: (
                                      context,
                                      child,
                                      frame,
                                      wasSynchronouslyLoaded,
                                    ) {
                                      if (wasSynchronouslyLoaded) return child;
                                      return frame != null
                                          ? child
                                          : _buildShimmerPlaceholder();
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                      );
                                    },
                                  ))
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.h),
                    child: Text(
                      "${widget.price.toStringAsFixed(0)} تومان",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color.fromARGB(255, 92, 65, 55),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
