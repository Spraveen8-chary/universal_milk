import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:universal_milk/features/auth/auth_viewmodel.dart';
import 'package:universal_milk/shared/app_colors.dart';
import 'package:universal_milk/shared/button.dart';
import 'package:universal_milk/shared/card.dart';
import 'package:universal_milk/shared/text_style.dart';
import 'package:universal_milk/shared/ui_helpers.dart';

class AuthView extends StackedView<AuthViewModel> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: kcPrimaryGradient),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo and Title
                  _buildHeader(),
                  kSpaceLarge,

                  // Login Form
                  CustomCard(
                    variant: CardVariant.elevated,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to MilkMate',
                          style: heading2Style(context),
                        ),
                        kSpaceSmall,
                        Text(
                          'Please enter your mobile number and delivery address to continue',
                          style: bodyStyle(context),
                        ),
                        kSpaceMedium,

                        // Phone Number Field
                        _buildPhoneField(context, viewModel),
                        kSpaceMedium,

                        // Address Field
                        _buildAddressField(context, viewModel),
                        kSpaceMedium,

                        // Login Button
                        CustomButton(
                          text: 'Continue',
                          variant: ButtonVariant.primary,
                          isFullWidth: true,
                          isLoading: viewModel.isBusy,
                          onPressed:
                              viewModel.canProceed ? viewModel.login : null,
                        ),

                        // Error Message
                        if (viewModel.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              viewModel.modelError.toString(),
                              style: errorStyle(context),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),

                  kSpaceMedium,

                  // Terms & Conditions
                  Text(
                    'By continuing, you agree to our Terms & Conditions',
                    style:
                        bodySmallStyle(context).copyWith(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.local_drink_outlined,
            size: 50,
            color: kcPrimaryColor,
          ),
        ),
        kSpaceMedium,
        const Text(
          'MilkMate',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Fresh dairy delivered daily',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField(BuildContext context, AuthViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile Number',
          style: bodyStyle(context).copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  '+91',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Enter 10-digit mobile number',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  maxLength: 10,
                  buildCounter: (context,
                          {required currentLength,
                          required isFocused,
                          maxLength}) =>
                      null,
                  onChanged: viewModel.setPhoneNumber,
                ),
              ),
              if (viewModel.isPhoneValid)
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.check_circle,
                    color: kcSuccessColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressField(BuildContext context, AuthViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Address',
          style: bodyStyle(context).copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: TextField(
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Enter your full delivery address',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            onChanged: viewModel.setAddress,
          ),
        ),
      ],
    );
  }

  @override
  AuthViewModel viewModelBuilder(BuildContext context) => AuthViewModel();
}
