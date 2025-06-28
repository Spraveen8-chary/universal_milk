import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:universal_milk/features/products/products_viewmodel.dart';
import 'package:universal_milk/shared/app_colors.dart';
import 'package:universal_milk/shared/button.dart';
import 'package:universal_milk/shared/card.dart';
import 'package:universal_milk/shared/text_style.dart';
import 'package:universal_milk/shared/ui_helpers.dart';

class ProductsView extends StackedView<ProductsViewModel> {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProductsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Milk Products'),
        backgroundColor: kcPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Category selector
                _buildCategorySelector(context, viewModel),

                // Products grid
                Expanded(
                  child: _buildProductsGrid(context, viewModel),
                ),
              ],
            ),
      bottomNavigationBar: _buildBottomBar(context, viewModel),
    );
  }

  Widget _buildCategorySelector(
      BuildContext context, ProductsViewModel viewModel) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final category = viewModel.categories[index];
          final isSelected = category == viewModel.selectedCategory;

          return GestureDetector(
            onTap: () => viewModel.setCategory(category),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? kcPrimaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? kcPrimaryColor
                      : kcSecondaryTextColor.withOpacity(0.5),
                ),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : kcSecondaryTextColor,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsGrid(BuildContext context, ProductsViewModel viewModel) {
    if (viewModel.products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_basket,
              size: 64,
              color: kcSecondaryColor,
            ),
            kSpaceMedium,
            Text(
              'No products in this category',
              style: heading3Style(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: viewModel.products.length,
      itemBuilder: (context, index) {
        final product = viewModel.products[index];
        return _buildProductCard(context, viewModel, product);
      },
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ProductsViewModel viewModel,
    Product product,
  ) {
    return CustomCard(
      variant: CardVariant.elevated,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image area
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: kcCreamColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.breakfast_dining,
                size: 50,
                color: kcPrimaryColor,
              ),
            ),
          ),

          // Product details
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style:
                      bodyStyle(context).copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\u20b9${product.price}',
                  style: bodyStyle(context),
                ),
                kSpaceSmall,

                // Quantity selector
                Row(
                  children: [
                    _buildQuantityButton(
                      icon: Icons.remove,
                      onPressed: () => viewModel.decrementQuantity(product.id),
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text(
                        '${product.quantity}',
                        style: bodyStyle(context),
                      ),
                    ),
                    _buildQuantityButton(
                      icon: Icons.add,
                      onPressed: () => viewModel.incrementQuantity(product.id),
                    ),
                    const Spacer(),

                    // Subscribe toggle
                    GestureDetector(
                      onTap: () => viewModel.toggleSubscription(product.id),
                      child: Icon(
                        product.isSubscribed
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isSubscribed
                            ? kcErrorColor
                            : kcSecondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: kcPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: 16,
          color: kcPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, ProductsViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: CustomButton(
        text: 'Proceed to Calendar',
        variant: ButtonVariant.primary,
        isFullWidth: true,
        onPressed: viewModel.proceedToCalendar,
      ),
    );
  }

  @override
  ProductsViewModel viewModelBuilder(BuildContext context) =>
      ProductsViewModel();

  @override
  void onViewModelReady(ProductsViewModel viewModel) => viewModel.initialize();
}
