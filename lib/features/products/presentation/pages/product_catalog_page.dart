import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/product_model.dart';
import '../state/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';

class ProductCatalogPage extends StatefulWidget {
  const ProductCatalogPage({super.key});

  @override
  State<ProductCatalogPage> createState() => _ProductCatalogPageState();
}

class _ProductCatalogPageState extends State<ProductCatalogPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            return CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverToBoxAdapter(child: _buildHeader(context)),
                SliverToBoxAdapter(
                  child: _buildFeaturedBanner(context, provider),
                ),
                SliverToBoxAdapter(
                  child: _buildCategorySection(context, provider),
                ),
                SliverToBoxAdapter(child: _buildSearchBar(context, provider)),
                SliverToBoxAdapter(
                  child: _buildProductHeading(context, provider),
                ),
                _buildProductContent(provider),
                const SliverToBoxAdapter(child: SizedBox(height: 36)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'MOSAIC.',
                  style: textTheme.displayMedium?.copyWith(
                    fontFamily: 'serif',
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 35,
                    letterSpacing: 2.2,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'THE CURATED',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 8,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'BOUTIQUE',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppTheme.accentColor,
                      fontSize: 8,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'DIFFERENT FINDS, ONE PLACE.',
            style: textTheme.labelSmall?.copyWith(
              color: AppTheme.textSecondaryColor,
              fontSize: 9,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 19),
          Container(height: 1, color: AppTheme.borderColor),
        ],
      ),
    );
  }

  Widget _buildFeaturedBanner(BuildContext context, ProductProvider provider) {
    final textTheme = Theme.of(context).textTheme;
    final products = provider.products;
    final selectedCategory = provider.selectedCategory.toLowerCase();

    final isAll = selectedCategory == 'all';
    final isElectronics = selectedCategory.contains('electronic');
    final isJewelry = selectedCategory.contains('jewel');
    final isMensClothing = selectedCategory.contains('men');
    final isWomensClothing = selectedCategory.contains('women');
    final isClothing =
        selectedCategory.contains('clothing') ||
        isMensClothing ||
        isWomensClothing;

    final jewelryProduct = _findProduct(products, 'jewel');
    final electronicsProduct = _findProduct(products, 'electronic');
    final fashionProduct = _findProduct(products, 'clothing');

    final firstVisual = isAll
        ? jewelryProduct ?? electronicsProduct ?? fashionProduct
        : isElectronics
        ? electronicsProduct
        : isJewelry
        ? jewelryProduct
        : isClothing
        ? fashionProduct
        : products.isNotEmpty
        ? products.first
        : null;

    ProductModel? secondVisual;

    for (final product in products) {
      if (product.id != firstVisual?.id) {
        secondVisual = product;
        break;
      }
    }

    final firstLabel = isAll
        ? 'STYLE & ADORNMENT'
        : isElectronics
        ? 'TECH ESSENTIALS'
        : isJewelry
        ? 'TIMELESS DETAILS'
        : isMensClothing
        ? 'MODERN MENSWEAR'
        : isWomensClothing
        ? 'EFFORTLESS STYLE'
        : 'CURATED FINDS';

    final secondLabel = isAll
        ? 'MODERN ESSENTIALS'
        : isElectronics
        ? 'MODERN DEVICES'
        : isJewelry
        ? 'EVERYDAY ELEGANCE'
        : isMensClothing
        ? 'DAILY STYLE'
        : isWomensClothing
        ? 'CURATED LOOKS'
        : 'THOUGHTFULLY SELECTED';

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 5, 22, 30),
      child: Container(
        height: 260,
        decoration: BoxDecoration(
          color: const Color(0xFFECE4D9),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 10, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'THE MOSAIC EDIT / NO. 01',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 7,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'A WORLD OF',
                          style: textTheme.labelSmall?.copyWith(
                            color: AppTheme.accentColor,
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.6,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Text(
                          'Considered\nfinds.',
                          style: textTheme.headlineMedium?.copyWith(
                            fontFamily: 'serif',
                            color: AppTheme.primaryColor,
                            fontSize: 27,
                            height: 1.12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Style, adornment and modern essentials — thoughtfully brought together.',
                          style: textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondaryColor,
                            fontSize: 9,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'THOUGHTFULLY SELECTED',
                          style: textTheme.labelSmall?.copyWith(
                            color: AppTheme.primaryColor,
                            fontSize: 7,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward,
                          size: 11,
                          color: AppTheme.accentColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: Column(
                  children: [
                    Expanded(
                      child: _buildFeaturedImage(
                        firstVisual,
                        firstLabel,
                        const Color(0xFFE2D6C8),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Expanded(
                      child: _buildFeaturedImage(
                        secondVisual,
                        secondLabel,
                        const Color(0xFFDCD6CD),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedImage(
    ProductModel? product,
    String label,
    Color backgroundColor,
  ) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: backgroundColor),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (product != null)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return _buildImagePlaceholder();
                },
              ),
            )
          else
            _buildImagePlaceholder(),
          Positioned(
            left: 5,
            right: 5,
            bottom: 5,
            child: Container(
              color: AppTheme.backgroundColor.withValues(alpha: 0.92),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 6,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return const Center(
      child: Icon(
        Icons.auto_awesome_outlined,
        color: AppTheme.accentColor,
        size: 34,
      ),
    );
  }

  ProductModel? _findProduct(List<ProductModel> products, String keyword) {
    for (final product in products) {
      if (product.category.toLowerCase().contains(keyword)) {
        return product;
      }
    }

    return null;
  }

  Widget _buildCategorySection(BuildContext context, ProductProvider provider) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 13),
            child: Row(
              children: [
                Text(
                  'EXPLORE THE COLLECTION',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppTheme.textSecondaryColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(height: 1, color: AppTheme.borderColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 36,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              scrollDirection: Axis.horizontal,
              itemCount: provider.categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                final category = provider.categories[index];
                final isSelected = provider.selectedCategory == category;

                return GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    provider.selectCategory(category);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatCategory(category).toUpperCase(),
                        style: textTheme.labelSmall?.copyWith(
                          color: isSelected
                              ? AppTheme.primaryColor
                              : AppTheme.textSecondaryColor,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 7),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        height: 2,
                        width: isSelected ? 25 : 0,
                        color: AppTheme.accentColor,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, ProductProvider provider) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 27),
      child: TextField(
        controller: _searchController,
        onChanged: provider.searchProducts,
        textInputAction: TextInputAction.search,
        style: textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Discover something special...',
          hintStyle: textTheme.bodyMedium?.copyWith(
            color: AppTheme.textMutedColor,
            fontSize: 12,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppTheme.textSecondaryColor,
            size: 19,
          ),
          suffixIcon: provider.searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    provider.searchProducts('');
                  },
                  icon: const Icon(Icons.close_rounded, size: 18),
                )
              : null,
          filled: true,
          fillColor: AppTheme.surfaceColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: AppTheme.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: AppTheme.accentColor, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeading(BuildContext context, ProductProvider provider) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A MOSAIC SELECTION',
            style: textTheme.labelSmall?.copyWith(
              color: AppTheme.accentColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.7,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  provider.searchQuery.isNotEmpty
                      ? 'Search results'
                      : provider.selectedCategory == 'All'
                      ? 'Curated for you'
                      : _formatCategory(provider.selectedCategory),
                  style: textTheme.headlineMedium?.copyWith(
                    fontFamily: 'serif',
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              if (!provider.isLoading && provider.errorMessage == null)
                Text(
                  '${provider.products.length} PIECES',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 8,
                    letterSpacing: 0.8,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: AppTheme.borderColor),
        ],
      ),
    );
  }

  Widget _buildProductContent(ProductProvider provider) {
    if (provider.isLoading) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CircularProgressIndicator(color: AppTheme.accentColor),
        ),
      );
    }

    if (provider.errorMessage != null) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: _buildErrorState(provider),
      );
    }

    if (provider.products.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: _buildEmptyState(),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = provider.products[index];

          return ProductCard(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
          );
        }, childCount: provider.products.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 13,
          mainAxisSpacing: 15,
          childAspectRatio: 0.58,
        ),
      ),
    );
  }

  Widget _buildErrorState(ProductProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 46,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(height: 14),
            Text(
              provider.errorMessage ?? 'Something went wrong.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: AppTheme.textPrimaryColor),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: provider.retry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 46,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(height: 12),
            Text(
              'Nothing found just yet',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontFamily: 'serif', fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              'Try another keyword or explore a different collection.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: AppTheme.textSecondaryColor),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCategory(String category) {
    if (category == 'All') return category;

    return category
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;

          return '${word[0].toUpperCase()}${word.substring(1)}';
        })
        .join(' ');
  }
}
