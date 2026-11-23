import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../cart/presentation/state/cart_provider.dart';
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
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'NOVA',
                  style: textTheme.displayMedium?.copyWith(
                    fontFamily: 'serif',
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 38,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'MODERN',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 9,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'CURATED BOUTIQUE',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppTheme.steelBlueColor,
                      fontSize: 9,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartPage()),
                      );
                    },
                    tooltip: 'Shopping Bag',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                    icon: Badge(
                      isLabelVisible: cart.itemCount > 0,
                      label: Text(
                        cart.itemCount > 99 ? '99+' : '${cart.itemCount}',
                      ),
                      backgroundColor: AppTheme.accentColor,
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        size: 25,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            'EVERYTHING WORTH DISCOVERING.',
            style: textTheme.labelSmall?.copyWith(
              color: AppTheme.textSecondaryColor,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 17),
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
    final isMensClothing = selectedCategory.contains("men's");
    final isWomensClothing = selectedCategory.contains("women's");
    final isClothing = isMensClothing || isWomensClothing;

    final jewelryProduct = _findProduct(products, 'jewel');
    final electronicsProduct = _findProduct(products, 'electronic');
    final fashionProduct = _findProduct(products, 'clothing');

    final ProductModel? firstVisual;

    if (isAll) {
      firstVisual =
          jewelryProduct ??
          electronicsProduct ??
          fashionProduct ??
          (products.isNotEmpty ? products.first : null);
    } else if (isElectronics) {
      firstVisual = electronicsProduct;
    } else if (isJewelry) {
      firstVisual = jewelryProduct;
    } else if (isClothing) {
      firstVisual = fashionProduct;
    } else {
      firstVisual = products.isNotEmpty ? products.first : null;
    }

    ProductModel? secondVisual;

    for (final product in products) {
      if (product.id != firstVisual?.id) {
        secondVisual = product;
        break;
      }
    }

    final firstLabel = isAll
        ? 'STYLE & DETAILS'
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
      padding: const EdgeInsets.fromLTRB(22, 3, 22, 28),
      child: Container(
        height: 275,
        decoration: BoxDecoration(
          color: const Color(0xFFE9ECEC),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(17, 19, 8, 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'THE NOVA EDIT / NO. 01',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppTheme.steelBlueColor,
                        fontSize: 9,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DISCOVER MORE',
                          style: textTheme.labelSmall?.copyWith(
                            color: AppTheme.steelBlueColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Everything\nworth\nfinding.',
                          style: textTheme.headlineMedium?.copyWith(
                            fontFamily: 'serif',
                            color: AppTheme.primaryColor,
                            fontSize: 27,
                            height: 1.13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Modern finds for every lifestyle, thoughtfully brought together.',
                          style: textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondaryColor,
                            fontSize: 11,
                            height: 1.55,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'EXPLORE THE EDIT',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.labelSmall?.copyWith(
                              color: AppTheme.primaryColor,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 14,
                          color: AppTheme.steelBlueColor,
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
                padding: const EdgeInsets.fromLTRB(0, 12, 10, 12),
                child: Column(
                  children: [
                    Expanded(
                      child: _buildFeaturedImage(
                        firstVisual,
                        firstLabel,
                        const Color(0xFFD9DDE0),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Expanded(
                      child: _buildFeaturedImage(
                        secondVisual,
                        secondLabel,
                        const Color(0xFFDDE2E4),
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
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(3),
      ),
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
              color: AppTheme.backgroundColor.withValues(alpha: 0.94),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
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
        color: AppTheme.steelBlueColor,
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
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 14),
            child: Row(
              children: [
                Text(
                  'EXPLORE COLLECTIONS',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppTheme.textSecondaryColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
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
            height: 39,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              scrollDirection: Axis.horizontal,
              itemCount: provider.categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 9),
              itemBuilder: (context, index) {
                final category = provider.categories[index];
                final isSelected = provider.selectedCategory == category;

                return GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    provider.selectCategory(category);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryColor
                          : AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : AppTheme.borderColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _formatCategory(category).toUpperCase(),
                        style: textTheme.labelSmall?.copyWith(
                          color: isSelected
                              ? AppTheme.surfaceColor
                              : AppTheme.textSecondaryColor,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontSize: 10,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
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
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 28),
      child: TextField(
        controller: _searchController,
        onChanged: provider.searchProducts,
        textInputAction: TextInputAction.search,
        style: textTheme.bodyMedium?.copyWith(
          color: AppTheme.textPrimaryColor,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: 'Discover something special...',
          hintStyle: textTheme.bodyMedium?.copyWith(
            color: AppTheme.textMutedColor,
            fontSize: 13,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppTheme.steelBlueColor,
            size: 21,
          ),
          suffixIcon: provider.searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    provider.searchProducts('');
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 19,
                    color: AppTheme.textSecondaryColor,
                  ),
                )
              : null,
          filled: true,
          fillColor: AppTheme.surfaceColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppTheme.accentColor,
              width: 1.2,
            ),
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
            provider.searchQuery.isNotEmpty
                ? 'SEARCH DISCOVERY'
                : 'THE NOVA SELECTION',
            style: textTheme.labelSmall?.copyWith(
              color: AppTheme.steelBlueColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 7),
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
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              if (!provider.isLoading && provider.errorMessage == null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    '${provider.products.length} ITEMS',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 9,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 11),
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
      return SliverToBoxAdapter(child: _buildErrorState(provider));
    }

    if (provider.products.isEmpty) {
      return SliverToBoxAdapter(child: _buildEmptyState());
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
                  builder: (context) {
                    return ProductDetailPage(product: product);
                  },
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
                foregroundColor: AppTheme.surfaceColor,
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
              color: AppTheme.steelBlueColor,
            ),
            const SizedBox(height: 14),
            Text(
              'Nothing found just yet',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontFamily: 'serif', fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 7),
            Text(
              'Try another keyword or explore a different collection.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: AppTheme.textSecondaryColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCategory(String category) {
    switch (category.toLowerCase()) {
      case 'all':
        return 'All';
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
