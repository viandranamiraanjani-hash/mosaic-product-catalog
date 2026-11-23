import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../cart/presentation/state/cart_provider.dart';
import '../../data/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildProductImage()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 25, 24, 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategory(textTheme),
                    const SizedBox(height: 12),
                    _buildTitle(textTheme),
                    const SizedBox(height: 18),
                    _buildRating(textTheme),
                    const SizedBox(height: 20),
                    Container(height: 1, color: AppTheme.borderColor),
                    const SizedBox(height: 20),
                    _buildPrice(textTheme),
                    const SizedBox(height: 28),
                    _buildSectionTitle('ABOUT THIS PIECE', textTheme),
                    const SizedBox(height: 10),
                    _buildDescription(textTheme),
                    const SizedBox(height: 30),
                    _buildProductInformation(textTheme),
                    const SizedBox(height: 25),
                    _buildAddToCartButton(context),
                    const SizedBox(height: 30),
                    _buildFooter(textTheme),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 22, 15),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 19,
              color: AppTheme.primaryColor,
            ),
          ),
          const Spacer(),
          const Text(
            'NOVA.',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 25,
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
              color: AppTheme.primaryColor,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: double.infinity,
      height: 350,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EAE1),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Image.network(
        product.image,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.accentColor,
              strokeWidth: 1.5,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 45,
              color: AppTheme.textMutedColor,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategory(TextTheme textTheme) {
    return Text(
      _formatCategory(product.category).toUpperCase(),
      style: textTheme.labelSmall?.copyWith(
        color: AppTheme.accentColor,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildTitle(TextTheme textTheme) {
    return Text(
      product.title,
      style: textTheme.headlineMedium?.copyWith(
        fontFamily: 'serif',
        color: AppTheme.primaryColor,
        fontSize: 27,
        height: 1.3,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildRating(TextTheme textTheme) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: AppTheme.accentColor, size: 19),
        const SizedBox(width: 5),
        Text(
          product.rating.toStringAsFixed(1),
          style: textTheme.bodyMedium?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          '(${product.ratingCount} reviews)',
          style: textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPrice(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PRICE',
          style: textTheme.labelSmall?.copyWith(
            color: AppTheme.textSecondaryColor,
            fontSize: 9,
            letterSpacing: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: textTheme.headlineMedium?.copyWith(
            color: AppTheme.primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, TextTheme textTheme) {
    return Text(
      title,
      style: textTheme.labelSmall?.copyWith(
        color: AppTheme.accentColor,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildDescription(TextTheme textTheme) {
    return Text(
      product.description.isNotEmpty
          ? product.description
          : 'No description is available for this product.',
      style: textTheme.bodyMedium?.copyWith(
        color: AppTheme.textSecondaryColor,
        fontSize: 13,
        height: 1.8,
      ),
    );
  }

  Widget _buildProductInformation(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          _buildInformationRow('Collection', 'NOVA Selection', textTheme),
          const SizedBox(height: 14),
          Container(height: 1, color: AppTheme.borderColor),
          const SizedBox(height: 14),
          _buildInformationRow(
            'Category',
            _formatCategory(product.category),
            textTheme,
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: AppTheme.borderColor),
          const SizedBox(height: 14),
          _buildInformationRow('Product ID', '#${product.id}', textTheme),
        ],
      ),
    );
  }

  Widget _buildInformationRow(String label, String value, TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: textTheme.bodySmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: () {
          context.read<CartProvider>().addProduct(product);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text('Product added to your bag.'),
                backgroundColor: AppTheme.primaryColor,
                behavior: SnackBarBehavior.floating,
                action: SnackBarAction(
                  label: 'VIEW BAG',
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    );
                  },
                ),
              ),
            );
        },
        icon: const Icon(Icons.shopping_bag_outlined, size: 19),
        label: const Text(
          'ADD TO BAG',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: AppTheme.surfaceColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  Widget _buildFooter(TextTheme textTheme) {
    return Column(
      children: [
        Container(height: 1, color: AppTheme.borderColor),
        const SizedBox(height: 15),
        Text(
          'DIFFERENT FINDS, ONE PLACE.',
          textAlign: TextAlign.center,
          style: textTheme.labelSmall?.copyWith(
            color: AppTheme.textSecondaryColor,
            fontSize: 9,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _formatCategory(String category) {
    switch (category.toLowerCase()) {
      case 'jewelery':
        return 'Jewelry';
      case "men's clothing":
        return "Men's Clothing";
      case "women's clothing":
        return "Women's Clothing";
      case 'electronics':
        return 'Electronics';
      default:
        return category
            .split(' ')
            .map((word) {
              if (word.isEmpty) return word;
              return '${word[0].toUpperCase()}${word.substring(1)}';
            })
            .join(' ');
    }
  }
}
