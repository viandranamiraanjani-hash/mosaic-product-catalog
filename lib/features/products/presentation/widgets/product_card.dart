import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final ProductModel product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppTheme.surfaceColor,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.borderColor, width: 0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategory(textTheme),
                      const SizedBox(height: 8),
                      _buildTitle(textTheme),
                      const Spacer(),
                      _buildRating(textTheme),
                      const SizedBox(height: 10),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: AppTheme.borderColor,
                      ),
                      const SizedBox(height: 10),
                      _buildPrice(textTheme),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 155,
      width: double.infinity,
      color: AppTheme.backgroundColor,
      padding: const EdgeInsets.all(19),
      child: Image.network(
        product.image,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 1.6,
                color: AppTheme.accentColor,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 32,
              color: AppTheme.textMutedColor,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategory(TextTheme textTheme) {
    final category = product.category.toLowerCase();

    final displayCategory = switch (category) {
      'jewelery' => 'JEWELRY',
      "men's clothing" => "MEN'S CLOTHING",
      "women's clothing" => "WOMEN'S CLOTHING",
      'electronics' => 'ELECTRONICS',
      _ => category.toUpperCase(),
    };

    return Text(
      displayCategory,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textTheme.labelSmall?.copyWith(
        color: AppTheme.steelBlueColor,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildTitle(TextTheme textTheme) {
    return Text(
      product.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: textTheme.bodyMedium?.copyWith(
        color: AppTheme.textPrimaryColor,
        fontSize: 13,
        height: 1.4,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildRating(TextTheme textTheme) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, size: 16, color: AppTheme.taupeColor),
        const SizedBox(width: 4),
        Text(
          product.rating.toStringAsFixed(1),
          style: textTheme.labelMedium?.copyWith(
            color: AppTheme.textPrimaryColor,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            '${product.ratingCount} reviews',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondaryColor,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrice(TextTheme textTheme) {
    return Text(
      '\$${product.price.toStringAsFixed(2)}',
      style: textTheme.titleLarge?.copyWith(
        color: AppTheme.primaryColor,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
      ),
    );
  }
}
