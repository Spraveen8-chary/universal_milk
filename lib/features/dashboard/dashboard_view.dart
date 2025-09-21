import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:universal_milk/features/dashboard/dashboard_viewmodel.dart';
import 'package:universal_milk/shared/app_colors.dart';
import 'package:universal_milk/shared/card.dart';
import 'package:universal_milk/shared/text_style.dart';
import 'package:universal_milk/shared/ui_helpers.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dashboard'),
        backgroundColor: kcPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User greeting
                    Text(
                      'Welcome back, ${viewModel.userName}',
                      style: heading2Style(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Here\'s your delivery summary',
                      style: bodyStyle(context),
                    ),

                    kSpaceMedium,

                    // Summary cards
                    _buildSummaryCards(context, viewModel),

                    kSpaceMedium,

                    // Delivery chart
                    _buildDeliveryChart(context, viewModel),

                    kSpaceMedium,

                    // Recent deliveries
                    _buildRecentDeliveries(context, viewModel),

                    kSpaceMedium,

                    // Recommendations
                    _buildRecommendations(context, viewModel),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSummaryCards(
      BuildContext context, DashboardViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            context,
            'Total Deliveries',
            viewModel.totalDeliveries.toString(),
            Icons.local_shipping,
            kcPrimaryColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            context,
            'This Month',
            viewModel.monthlyDeliveries.toString(),
            Icons.calendar_today,
            kcSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return CustomCard(
      variant: CardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: bodySmallStyle(context),
              ),
            ],
          ),
          kSpaceSmall,
          Text(
            value,
            style: heading2Style(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryChart(
      BuildContext context, DashboardViewModel viewModel) {
    return CustomCard(
      variant: CardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery History',
            style: heading3Style(context),
          ),
          kSpaceSmall,
          SizedBox(
            height: 200,
            child: _buildBarChart(context, viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(BuildContext context, DashboardViewModel viewModel) {
    // Placeholder for chart implementation
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          7,
          (index) => _buildBar(
            context,
            height: 20.0 + (index * 20),
            label: ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
            color: index == 6 ? kcSecondaryColor : kcPrimaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildBar(
    BuildContext context, {
    required double height,
    required String label,
    required Color color,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: bodySmallStyle(context),
        ),
      ],
    );
  }

  Widget _buildRecentDeliveries(
      BuildContext context, DashboardViewModel viewModel) {
    return CustomCard(
      variant: CardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Deliveries',
            style: heading3Style(context),
          ),
          kSpaceSmall,
          ...viewModel.recentDeliveries.map(
            (delivery) => _buildDeliveryItem(context, delivery),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryItem(BuildContext context, DeliveryItem delivery) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: kcCreamColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.breakfast_dining,
                color: kcPrimaryColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  delivery.productName,
                  style:
                      bodyStyle(context).copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  delivery.date,
                  style: bodySmallStyle(context),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: delivery.status == 'Delivered'
                  ? kcSuccessColor.withOpacity(0.1)
                  : kcWarningColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              delivery.status,
              style: TextStyle(
                color: delivery.status == 'Delivered'
                    ? kcSuccessColor
                    : kcWarningColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations(
      BuildContext context, DashboardViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended For You',
          style: heading3Style(context),
        ),
        kSpaceSmall,
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.recommendations.length,
            itemBuilder: (context, index) {
              final recommendation = viewModel.recommendations[index];
              return _buildRecommendationCard(context, recommendation);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(
      BuildContext context, RecommendationItem item) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.name,
                      style: bodyStyle(context)
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '\u20b9${item.price}',
                      style: bodySmallStyle(context),
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

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) =>
      DashboardViewModel();

  @override
  void onViewModelReady(DashboardViewModel viewModel) => viewModel.initialize();
}
