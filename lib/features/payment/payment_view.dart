import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:universal_milk/features/payment/payment_viewmodel.dart';
import 'package:universal_milk/shared/app_colors.dart';
import 'package:universal_milk/shared/button.dart';
import 'package:universal_milk/shared/card.dart';
import 'package:universal_milk/shared/text_style.dart';
import 'package:universal_milk/shared/ui_helpers.dart';

class PaymentView extends StackedView<PaymentViewModel> {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PaymentViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
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
                    // Due amount summary
                    _buildDueSummary(context, viewModel),

                    kSpaceMedium,

                    // Pending payments
                    _buildPendingPayments(context, viewModel),

                    kSpaceMedium,

                    // Payment methods
                    _buildPaymentMethods(context, viewModel),

                    kSpaceMedium,

                    // Pay button
                    CustomButton(
                      text: 'Pay Now ₹${viewModel.totalDue.toStringAsFixed(2)}',
                      variant: ButtonVariant.primary,
                      isFullWidth: true,
                      isLoading: viewModel.isBusy,
                      onPressed:
                          viewModel.totalDue > 0 ? viewModel.makePayment : null,
                    ),

                    kSpaceMedium,

                    // Previous payments
                    if (viewModel.paidPayments.isNotEmpty)
                      _buildPaidPayments(context, viewModel),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDueSummary(BuildContext context, PaymentViewModel viewModel) {
    return CustomCard(
      variant: CardVariant.filled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount Due',
            style: heading3Style(context),
          ),
          const SizedBox(height: 8),
          Text(
            '₹${viewModel.totalDue.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: viewModel.totalDue > 0 ? kcPrimaryColor : kcSuccessColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            viewModel.totalDue > 0
                ? 'Please clear your dues by the 15th of this month.'
                : 'You have no pending payments. Great job!',
            style: bodySmallStyle(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingPayments(
      BuildContext context, PaymentViewModel viewModel) {
    if (viewModel.pendingPayments.isEmpty) {
      return CustomCard(
        variant: CardVariant.outlined,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: kcSuccessColor,
                  size: 48,
                ),
                kSpaceSmall,
                Text(
                  'All Payments Cleared',
                  style: heading3Style(context),
                ),
                kSpaceSmall,
                Text(
                  'You have no pending payments at this time.',
                  style: bodyStyle(context),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pending Payments',
          style: heading3Style(context),
        ),
        kSpaceSmall,
        ...viewModel.pendingPayments.map(
          (payment) => _buildPaymentItem(
            context,
            payment,
            isPending: true,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentItem(
    BuildContext context,
    PaymentItem payment, {
    bool isPending = false,
  }) {
    return CustomCard(
      variant: CardVariant.outlined,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isPending
                  ? kcWarningColor.withOpacity(0.1)
                  : kcSuccessColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                isPending ? Icons.pending : Icons.check_circle,
                color: isPending ? kcWarningColor : kcSuccessColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.name,
                  style:
                      bodyStyle(context).copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  payment.date,
                  style: bodySmallStyle(context),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${payment.amount.toStringAsFixed(2)}',
                style: bodyStyle(context).copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                isPending ? 'Due' : 'Paid',
                style: TextStyle(
                  color: isPending ? kcWarningColor : kcSuccessColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(
      BuildContext context, PaymentViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: heading3Style(context),
        ),
        kSpaceSmall,
        CustomCard(
          variant: CardVariant.outlined,
          child: Column(
            children: viewModel.paymentMethods.map((method) {
              final isSelected = method == viewModel.selectedPaymentMethod;
              return RadioListTile<String>(
                title: Text(method, style: bodyStyle(context)),
                value: method,
                groupValue: viewModel.selectedPaymentMethod,
                onChanged: (value) {
                  if (value != null) {
                    viewModel.setPaymentMethod(value);
                  }
                },
                activeColor: kcPrimaryColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPaidPayments(BuildContext context, PaymentViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment History',
          style: heading3Style(context),
        ),
        kSpaceSmall,
        ...viewModel.paidPayments.map(
          (payment) => _buildPaymentItem(
            context,
            payment,
            isPending: false,
          ),
        ),
      ],
    );
  }

  @override
  PaymentViewModel viewModelBuilder(BuildContext context) => PaymentViewModel();

  @override
  void onViewModelReady(PaymentViewModel viewModel) => viewModel.initialize();
}
