import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/cart/presentation/state/cart_provider.dart';
import 'features/products/data/repositories/product_repository.dart';
import 'features/products/data/sources/product_api_service.dart';
import 'features/products/presentation/pages/product_catalog_page.dart';
import 'features/products/presentation/state/product_provider.dart';

void main() {
  runApp(const ProductCatalogApp());
}

class ProductCatalogApp extends StatelessWidget {
  const ProductCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<ProductProvider>(
          create: (_) {
            final apiService = ProductApiService();
            final repository = ProductRepository(apiService);

            return ProductProvider(repository)..loadInitialData();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NOVA | Modern Curated Boutique',
        theme: AppTheme.lightTheme,
        home: const ProductCatalogPage(),
      ),
    );
  }
}
