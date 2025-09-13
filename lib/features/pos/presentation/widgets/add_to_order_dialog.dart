import 'package:barista_notes/features/pos/domain/entities/product.dart';
import 'package:flutter/material.dart';

class AddToOrderDialog extends StatefulWidget {
  final ProductEntity product;
  final void Function(int quantity) onConfirm;

  const AddToOrderDialog({
    super.key,
    required this.product,
    required this.onConfirm,
  });

  @override
  State<AddToOrderDialog> createState() => _AddToOrderDialogState();
}

class _AddToOrderDialogState extends State<AddToOrderDialog> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("قیمت واحد: ${widget.product.price} تومان"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed:
                    quantity > 1 ? () => setState(() => quantity--) : null,
                icon: const Icon(Icons.remove),
              ),
              Text(quantity.toString(), style: const TextStyle(fontSize: 20)),
              IconButton(
                onPressed: () => setState(() => quantity++),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("انصراف"),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onConfirm(quantity);
            Navigator.pop(context);
          },
          child: const Text("افزودن به سفارش"),
        ),
      ],
    );
  }
}
