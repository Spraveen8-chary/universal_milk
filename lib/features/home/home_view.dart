import 'package:flutter/material.dart';
import 'package:universal_milk/features/home/home_viewmodel.dart';
import 'package:universal_milk/shared/app_colors.dart';
import 'package:universal_milk/shared/button.dart';
import 'package:universal_milk/shared/card.dart';
import 'package:universal_milk/shared/text_style.dart';
import 'package:universal_milk/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context, viewModel),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome section
                      _buildWelcomeSection(context, viewModel),

                      kSpaceMedium,

                      // Subscription status
                      _buildSubscriptionStatusSection(context, viewModel),

                      kSpaceMedium,

                      // Quick actions
                      _buildQuickActionsSection(context, viewModel),

                      kSpaceMedium,

                      // Popular products
                      _buildPopularProductsSection(context, viewModel),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, viewModel),
    );
  }

  Widget _buildHeader(BuildContext context, HomeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        gradient: kcPrimaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'MilkMate',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: Icon(
                      Icons.person,
                      color: kcPrimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          kSpaceSmall,
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, HomeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning, ${viewModel.userName}',
          style: heading2Style(context),
        ),
        const SizedBox(height: 8),
        Text(
          'What would you like to order today?',
          style: bodyStyle(context),
        ),
      ],
    );
  }

  Widget _buildSubscriptionStatusSection(
      BuildContext context, HomeViewModel viewModel) {
    return CustomCard(
      variant: CardVariant.filled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, color: kcPrimaryColor),
              const SizedBox(width: 8),
              Text('Your Subscriptions', style: heading3Style(context)),
            ],
          ),
          kSpaceSmall,
          if (viewModel.hasSubscriptions) ...{
            _buildSubscriptionItem(
              context,
              'Full Cream Milk',
              'Daily - 500ml',
              Icons.breakfast_dining,
            ),
            const Divider(),
            _buildSubscriptionItem(
              context,
              'Natural Yogurt',
              'Mon, Wed, Fri - 200g',
              Icons.lunch_dining,
            ),
          } else ...{
            Text(
              'You have no active subscriptions',
              style: bodyStyle(context),
            ),
            kSpaceSmall,
          },
          kSpaceSmall,
          CustomButton(
            text: viewModel.hasSubscriptions
                ? 'Manage Subscriptions'
                : 'Add Subscription',
            variant: ButtonVariant.primary,
            onPressed: viewModel.navigateToProducts,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kcPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: kcPrimaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: bodyStyle(context)
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(subtitle, style: bodySmallStyle(context)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: kcSuccessColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Active',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(
      BuildContext context, HomeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: heading3Style(context)),
        kSpaceSmall,
        Row(
          children: [
            _buildQuickActionItem(
              context,
              Icons.add_shopping_cart,
              'Order',
              onTap: viewModel.navigateToProducts,
            ),
            _buildQuickActionItem(
              context,
              Icons.calendar_month,
              'Calendar',
              onTap: viewModel.navigateToCalendar,
            ),
            _buildQuickActionItem(
              context,
              Icons.payment,
              'Pay',
              onTap: viewModel.navigateToPayment,
            ),
            _buildQuickActionItem(
              context,
              Icons.chat,
              'Chat',
              onTap: viewModel.navigateToChat,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionItem(
      BuildContext context, IconData icon, String label,
      {required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kcPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: kcPrimaryColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: bodySmallStyle(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularProductsSection(
      BuildContext context, HomeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Popular Products', style: heading3Style(context)),
        kSpaceSmall,
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildProductCard(
                context,
                'Full Cream Milk',
                '\u20b960/500ml',
                'assets/images/milk1.png',
                onTap: () => viewModel.navigateToProducts(),
              ),
              _buildProductCard(
                context,
                'Fresh Paneer',
                '\u20b980/200g',
                'assets/images/paneer.png',
                onTap: () => viewModel.navigateToProducts(),
              ),
              _buildProductCard(
                context,
                'Natural Yogurt',
                '\u20b935/200g',
                'assets/images/yogurt1.png',
                onTap: () => viewModel.navigateToProducts(),
              ),
              _buildProductCard(
                context,
                'Butter',
                '\u20b950/100g',
                'assets/images/butter.png',
                onTap: () => viewModel.navigateToProducts(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(
      BuildContext context, String name, String price, String imageUrl,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: kcSurfaceColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [kcCardShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // This would normally be an Image.asset, but using a colored container for the template
            Container(
              height: 100,
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
                  size: 40,
                  color: kcPrimaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: bodyStyle(context)
                        .copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: bodySmallStyle(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, HomeViewModel viewModel) {
    return BottomNavigationBar(
      currentIndex: viewModel.currentIndex,
      onTap: viewModel.setIndex,
      selectedItemColor: kcPrimaryColor,
      unselectedItemColor: kcSecondaryTextColor,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Products',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
      ],
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}