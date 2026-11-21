import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/main.dart';

void main() {
  testWidgets('MOSAIC app launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const ProductCatalogApp());

    expect(find.text('NOVA.'), findsNothing);
  });
}
