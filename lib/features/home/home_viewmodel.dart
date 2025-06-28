import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:universal_milk/app/app.locator.dart';
import 'package:universal_milk/app/app.router.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  String _userName = 'Rahul';
  bool _hasSubscriptions = true;
  int _currentIndex = 0;

  String get userName => _userName;
  bool get hasSubscriptions => _hasSubscriptions;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;

    // Handle navigation based on tab selection
    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        navigateToProducts();
        break;
      case 2:
        navigateToCalendar();
        break;
      case 3:
        navigateToDashboard();
        break;
    }

    notifyListeners();
  }

  void navigateToProducts() {
    _navigationService.navigateTo(Routes.productsView);
  }

  void navigateToCalendar() {
    _navigationService.navigateTo(Routes.calendarView);
  }

  void navigateToPayment() {
    _navigationService.navigateTo(Routes.paymentView);
  }

  void navigateToChat() {
    _navigationService.navigateTo(Routes.chatView);
  }

  void navigateToDashboard() {
    _navigationService.navigateTo(Routes.dashboardView);
  }

  void showNotifications() {
    _dialogService.showDialog(
      title: 'Notifications',
      description: 'You have no new notifications at this time.',
    );
  }

  Future<void> logout() async {
    final response = await _dialogService.showDialog(
      title: 'Logout',
      description: 'Are you sure you want to logout?',
      buttonTitle: 'Logout',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed == true) {
      await _navigationService.clearStackAndShow(Routes.authView);
    }
  }
}
