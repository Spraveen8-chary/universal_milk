import 'package:stacked/stacked.dart';

class DeliveryItem {
  final String id;
  final String productName;
  final String date;
  final String status;

  DeliveryItem({
    required this.id,
    required this.productName,
    required this.date,
    required this.status,
  });
}

class RecommendationItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  RecommendationItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class DashboardViewModel extends BaseViewModel {
  String _userName = 'Rahul';
  int _totalDeliveries = 32;
  int _monthlyDeliveries = 12;
  List<DeliveryItem> _recentDeliveries = [];
  List<RecommendationItem> _recommendations = [];

  String get userName => _userName;
  int get totalDeliveries => _totalDeliveries;
  int get monthlyDeliveries => _monthlyDeliveries;
  List<DeliveryItem> get recentDeliveries => _recentDeliveries;
  List<RecommendationItem> get recommendations => _recommendations;

  Future<void> initialize() async {
    setBusy(true);

    try {
      // In a real app, this would fetch data from a service
      await Future.delayed(const Duration(seconds: 1));
      _loadDeliveries();
      _loadRecommendations();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void _loadDeliveries() {
    _recentDeliveries = [
      DeliveryItem(
        id: '1',
        productName: 'Full Cream Milk',
        date: 'Today, 7:15 AM',
        status: 'Delivered',
      ),
      DeliveryItem(
        id: '2',
        productName: 'Natural Yogurt',
        date: 'Today, 7:15 AM',
        status: 'Delivered',
      ),
      DeliveryItem(
        id: '3',
        productName: 'Fresh Paneer',
        date: 'Yesterday, 7:30 AM',
        status: 'Delivered',
      ),
      DeliveryItem(
        id: '4',
        productName: 'Full Cream Milk',
        date: 'Tomorrow, 7:00 AM',
        status: 'Scheduled',
      ),
    ];
  }

  void _loadRecommendations() {
    _recommendations = [
      RecommendationItem(
        id: '1',
        name: 'Butter',
        price: 50.0,
        imageUrl: 'assets/images/butter.png',
      ),
      RecommendationItem(
        id: '2',
        name: 'Paneer',
        price: 80.0,
        imageUrl: 'assets/images/paneer.png',
      ),
      RecommendationItem(
        id: '3',
        name: 'Ghee',
        price: 120.0,
        imageUrl: 'assets/images/ghee.png',
      ),
    ];
  }
}
