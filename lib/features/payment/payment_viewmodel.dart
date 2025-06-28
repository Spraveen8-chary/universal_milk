import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:universal_milk/app/app.locator.dart';
import 'package:universal_milk/app/app.router.dart';

class PaymentItem {
  final String id;
  final String name;
  final String date;
  final double amount;
  final bool isPaid;

  PaymentItem({
    required this.id,
    required this.name,
    required this.date,
    required this.amount,
    this.isPaid = false,
  });
}

class PaymentViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  List<PaymentItem> _pendingPayments = [];
  List<PaymentItem> _paidPayments = [];
  double _totalDue = 0;
  String _selectedPaymentMethod = 'UPI';

  List<PaymentItem> get pendingPayments => _pendingPayments;
  List<PaymentItem> get paidPayments => _paidPayments;
  double get totalDue => _totalDue;
  String get selectedPaymentMethod => _selectedPaymentMethod;

  // Payment methods supported
  final List<String> paymentMethods = [
    'UPI',
    'Credit Card',
    'Debit Card',
    'Net Banking'
  ];

  Future<void> initialize() async {
    setBusy(true);

    try {
      // In a real app, this would fetch data from a service
      await Future.delayed(const Duration(seconds: 1));
      _loadPayments();
      _calculateTotalDue();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void _loadPayments() {
    _pendingPayments = [
      PaymentItem(
        id: '1',
        name: 'Full Cream Milk Subscription',
        date: 'June 1-15, 2023',
        amount: 450.0,
      ),
      PaymentItem(
        id: '2',
        name: 'Natural Yogurt Subscription',
        date: 'June 1-15, 2023',
        amount: 210.0,
      ),
      PaymentItem(
        id: '3',
        name: 'Paneer (One-time order)',
        date: 'June 5, 2023',
        amount: 80.0,
      ),
    ];

    _paidPayments = [
      PaymentItem(
        id: '4',
        name: 'Full Cream Milk Subscription',
        date: 'May 15-31, 2023',
        amount: 450.0,
        isPaid: true,
      ),
      PaymentItem(
        id: '5',
        name: 'Natural Yogurt Subscription',
        date: 'May 15-31, 2023',
        amount: 210.0,
        isPaid: true,
      ),
    ];
  }

  void _calculateTotalDue() {
    _totalDue = _pendingPayments.fold(0, (sum, item) => sum + item.amount);
  }

  void setPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  Future<void> makePayment() async {
    if (_pendingPayments.isEmpty) {
      await _dialogService.showDialog(
        title: 'No Pending Payments',
        description: 'You have no pending payments to process.',
      );
      return;
    }

    setBusy(true);
    try {
      // In a real app, this would call a payment gateway service
      await Future.delayed(const Duration(seconds: 2));

      // Simulate success
      _paidPayments = [
        ..._paidPayments,
        ..._pendingPayments.map((item) {
          return PaymentItem(
            id: item.id,
            name: item.name,
            date: item.date,
            amount: item.amount,
            isPaid: true,
          );
        })
      ];

      _pendingPayments = [];
      _totalDue = 0;

      await _dialogService.showDialog(
        title: 'Payment Successful',
        description: 'Your payment has been processed successfully.',
      );
    } catch (e) {
      setError(e.toString());
      await _dialogService.showDialog(
        title: 'Payment Failed',
        description:
            'There was a problem processing your payment. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }

  void navigateBack() {
    _navigationService.back();
  }
}
