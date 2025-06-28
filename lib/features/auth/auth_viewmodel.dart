import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:universal_milk/app/app.locator.dart';
import 'package:universal_milk/app/app.router.dart';

class AuthViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  String _phoneNumber = '';
  String _address = '';
  bool _isPhoneValid = false;

  String get phoneNumber => _phoneNumber;
  String get address => _address;
  bool get isPhoneValid => _isPhoneValid;
  bool get canProceed => _isPhoneValid && _address.trim().isNotEmpty;

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    // Basic validation for Indian phone numbers (10 digits)
    _isPhoneValid = value.length == 10 && int.tryParse(value) != null;
    notifyListeners();
  }

  void setAddress(String value) {
    _address = value;
    notifyListeners();
  }

  Future<void> login() async {
    if (!canProceed) return;

    setBusy(true);
    try {
      // Here we would typically call a service to verify the phone number
      // For now, we'll just simulate a successful login
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to the home view after successful login
      await _navigationService.replaceWithHomeView();
    } catch (e) {
      setError(e.toString());
      await _dialogService.showDialog(
        title: 'Login Failed',
        description:
            'Unable to login. Please check your details and try again.',
      );
    } finally {
      setBusy(false);
    }
  }
}
