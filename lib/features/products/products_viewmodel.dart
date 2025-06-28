import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:universal_milk/app/app.locator.dart';
import 'package:universal_milk/app/app.router.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String category;
  final List<String> variants;
  int quantity;
  bool isSubscribed;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.variants,
    this.quantity = 0,
    this.isSubscribed = false,
  });
}

class ProductsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  List<Product> _products = [];
  List<String> _categories = ['All', 'Milk', 'Yogurt', 'Paneer', 'Other'];
  String _selectedCategory = 'All';

  List<Product> get products {
    if (_selectedCategory == 'All') {
      return _products;
    } else {
      return _products.where((p) => p.category == _selectedCategory).toList();
    }
  }

  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  bool get hasSubscriptions => _products.any((p) => p.isSubscribed);

  Future<void> initialize() async {
    setBusy(true);

    try {
      // In a real app, this would fetch data from a service
      await Future.delayed(const Duration(seconds: 1));
      _loadProducts();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void _loadProducts() {
    _products = [
      Product(
        id: '1',
        name: 'Full Cream Milk',
        description: 'Fresh farm milk with 6% fat content',
        imageUrl: 'assets/images/milk1.png',
        price: 60.0,
        category: 'Milk',
        variants: ['500ml', '1L'],
      ),
      Product(
        id: '2',
        name: 'Toned Milk',
        description: 'Pasteurized milk with 3% fat content',
        imageUrl: 'assets/images/milk2.png',
        price: 45.0,
        category: 'Milk',
        variants: ['500ml', '1L'],
      ),
      Product(
        id: '3',
        name: 'Double Toned Milk',
        description: 'Low fat milk with 1.5% fat content',
        imageUrl: 'assets/images/milk3.png',
        price: 40.0,
        category: 'Milk',
        variants: ['500ml', '1L'],
      ),
      Product(
        id: '4',
        name: 'Natural Yogurt',
        description: 'Creamy yogurt made from full cream milk',
        imageUrl: 'assets/images/yogurt1.png',
        price: 35.0,
        category: 'Yogurt',
        variants: ['200g', '400g'],
      ),
      Product(
        id: '5',
        name: 'Fresh Paneer',
        description: 'Soft and fresh cottage cheese',
        imageUrl: 'assets/images/paneer.png',
        price: 80.0,
        category: 'Paneer',
        variants: ['200g', '500g'],
      ),
      Product(
        id: '6',
        name: 'Butter',
        description: 'Farm fresh butter',
        imageUrl: 'assets/images/butter.png',
        price: 50.0,
        category: 'Other',
        variants: ['100g', '250g'],
      ),
    ];
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    final product = _products.firstWhere((p) => p.id == productId);
    product.quantity++;
    notifyListeners();
  }

  void decrementQuantity(String productId) {
    final product = _products.firstWhere((p) => p.id == productId);
    if (product.quantity > 0) {
      product.quantity--;

      // If quantity becomes 0, unsubscribe
      if (product.quantity == 0) {
        product.isSubscribed = false;
      }

      notifyListeners();
    }
  }

  void toggleSubscription(String productId) {
    final product = _products.firstWhere((p) => p.id == productId);

    // Can't subscribe if quantity is 0
    if (product.quantity == 0) {
      product.quantity = 1;
    }

    product.isSubscribed = !product.isSubscribed;
    notifyListeners();
  }

  Future<void> proceedToCalendar() async {
    if (!hasSubscriptions) {
      await _dialogService.showDialog(
        title: 'No Subscriptions',
        description:
            'Please subscribe to at least one product before proceeding.',
      );
      return;
    }

    await _navigationService.navigateTo(Routes.calendarView);
  }
}
