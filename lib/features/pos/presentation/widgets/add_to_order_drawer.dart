import 'package:barista_notes/features/pos/domain/entities/product.dart';
import 'package:flutter/material.dart';

class AddToOrderDrawer extends StatefulWidget {
  final ProductEntity product;
  final void Function(int quantity, String note) onConfirm;

  const AddToOrderDrawer({
    super.key,
    required this.product,
    required this.onConfirm,
  });

  @override
  State<AddToOrderDrawer> createState() => _AddToOrderDrawerState();
}

class _AddToOrderDrawerState extends State<AddToOrderDrawer> {
  int quantity = 1;
  final noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 320,
      child: Drawer(
        elevation: 8,
        child: Directionality(
          textDirection: TextDirection.rtl, // برای متن و ورودی‌ها
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                child: Text(
                  widget.product.name,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("قیمت واحد: ${widget.product.price} تومان"),
              ),
              const SizedBox(height: 16),

              // Quantity control
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed:
                        quantity > 1 ? () => setState(() => quantity--) : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () => setState(() => quantity++),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Note field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: noteController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "یادداشت",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const Spacer(),

              // Actions
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        child: const Text("انصراف"),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onConfirm(
                            quantity,
                            noteController.text.trim(),
                          );
                          Navigator.of(context).maybePop();
                        },
                        child: const Text("افزودن"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
