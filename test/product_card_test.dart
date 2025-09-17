import 'package:barista_notes/features/pos/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  Widget wrapWithMaterialApp(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder:
          (_, __) => MaterialApp(home: Scaffold(body: Material(child: child))),
    );
  }

  testWidgets('renders placeholder when imageUrl is null', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      wrapWithMaterialApp(
        const ProductCard(name: 'Test Product', price: 12345, imageUrl: null),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.textContaining('12345'), findsOneWidget);
    expect(find.byIcon(Icons.image), findsOneWidget);
  });

  testWidgets('calls onTap when tapped', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      wrapWithMaterialApp(
        ProductCard(
          name: 'Test Product',
          price: 5000,
          imageUrl: null,
          onTap: () {
            tapped = true;
          },
        ),
      ),
    );

    await tester.tap(find.byType(ProductCard));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });
}
