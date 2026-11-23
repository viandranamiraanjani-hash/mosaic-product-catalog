import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../state/cart_provider.dart';
import '../widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppTheme.backgroundColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 19,
                color: AppTheme.primaryColor,
              ),
            ),
            title: const Text(
              'YOUR BAG',
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 21,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                color: AppTheme.primaryColor,
              ),
            ),
            centerTitle: true,
          ),
          body: cart.isEmpty
              ? _buildEmptyCart(context)
              : _buildCartContent(context, cart),
        );
      },
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 105,
              height: 105,
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 43,
                color: AppTheme.steelBlueColor,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Your bag is waiting',
              style: textTheme.headlineSmall?.copyWith(
                fontFamily: 'serif',
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Discover something special and add it to your collection.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondaryColor,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.surfaceColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 27,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'EXPLORE PRODUCTS',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartProvider cart) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${cart.itemCount} ITEMS IN YOUR BAG',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.textSecondaryColor,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: cart.clearCart,
                    child: const Text(
                      'CLEAR BAG',
                      style: TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 10,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...cart.items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: CartItemCard(
                    item: item,
                    onIncrease: () {
                      cart.increaseQuantity(item.product.id);
                    },
                    onDecrease: () {
                      cart.decreaseQuantity(item.product.id);
                    },
                    onRemove: () {
                      cart.removeProduct(item.product.id);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildOrderSummary(context, cart),
      ],
    );
  }

  Widget _buildOrderSummary(BuildContext context, CartProvider cart) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 25),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border(top: BorderSide(color: AppTheme.borderColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORDER SUMMARY',
            style: textTheme.labelSmall?.copyWith(
              color: AppTheme.steelBlueColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 17),
          _summaryRow(
            'Subtotal',
            '\$${cart.subtotal.toStringAsFixed(2)}',
            textTheme,
          ),
          const SizedBox(height: 12),
          _summaryRow('Shipping', 'Calculated separately', textTheme),
          const SizedBox(height: 16),
          Container(height: 1, color: AppTheme.borderColor),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'TOTAL',
                  style: textTheme.labelLarge?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Text(
                '\$${cart.total.toStringAsFixed(2)}',
                style: textTheme.titleLarge?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Checkout is not available in this demo.'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.surfaceColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'PROCEED TO CHECKOUT',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'A CURATED EXPERIENCE BY NOVA.',
              style: textTheme.labelSmall?.copyWith(
                color: AppTheme.textMutedColor,
                fontSize: 9,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, TextTheme textTheme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ),
        Text(
          value,
          style: textTheme.bodySmall?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
