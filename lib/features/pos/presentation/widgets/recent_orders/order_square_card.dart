import 'package:barista_notes/features/pos/presentation/widgets/recent_orders/printer_setup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:barista_notes/core/constants/color.dart';
import 'package:barista_notes/features/pos/domain/entities/order.dart';
import 'order_details_dialog.dart';
import 'order_export_service.dart';

class OrderSquareCard extends StatefulWidget {
  final OrderEntity order;
  const OrderSquareCard({super.key, required this.order});

  @override
  State<OrderSquareCard> createState() => _OrderSquareCardState();
}

class _OrderSquareCardState extends State<OrderSquareCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isPaid = widget.order.isPaid;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: _isHovered ? 1.03 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: AppColors.backGround,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color:
                  isPaid
                      ? Colors.green.withOpacity(0.3)
                      : AppColors.brownFull.withOpacity(0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
              if (_isHovered)
                BoxShadow(
                  color: AppColors.brownFull.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'سفارش #${widget.order.id ?? '-'}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownFull,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isPaid
                              ? Colors.green.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: isPaid ? Colors.green : Colors.orange,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      isPaid ? 'پرداخت شده' : 'در انتظار',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color:
                            isPaid
                                ? Colors.green.shade700
                                : Colors.orange.shade700,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.brownFull.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16.sp,
                      color: AppColors.brownFull.withOpacity(0.7),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      DateFormat('yyyy/MM/dd HH:mm').format(widget.order.date),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.brownFull.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),

              // Items count
              Row(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 16.sp,
                    color: AppColors.cancel,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${widget.order.items.length} قلم',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.cancel,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              // Total price
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color:
                      isPaid
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${widget.order.total.toStringAsFixed(0)} تومان',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color:
                        isPaid ? Colors.green.shade700 : Colors.orange.shade700,
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.brownFull.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.brownFull.withOpacity(0.2),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.visibility_outlined,
                          color: AppColors.brownFull,
                          size: 20.sp,
                        ),
                        tooltip: 'جزئیات سفارش',
                        onPressed:
                            () => showOrderDetailsDialog(context, widget.order),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.cancel.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.cancel.withOpacity(0.2),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.print_outlined,
                          color: AppColors.cancel,
                          size: 20.sp,
                        ),
                        tooltip: 'چاپ / خروجی PDF',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) =>
                                    PrinterSetupDialog(order: widget.order),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
