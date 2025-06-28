import 'package:universal_milk/features/auth/auth_view.dart';
import 'package:universal_milk/features/calendar/calendar_view.dart';
import 'package:universal_milk/features/chat/chat_view.dart';
import 'package:universal_milk/features/dashboard/dashboard_view.dart';
import 'package:universal_milk/features/home/home_view.dart';
import 'package:universal_milk/features/payment/payment_view.dart';
import 'package:universal_milk/features/products/products_view.dart';
import 'package:universal_milk/shared/info_alert_dialog.dart';
import 'package:universal_milk/features/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: ProductsView),
    MaterialRoute(page: CalendarView),
    MaterialRoute(page: PaymentView),
    MaterialRoute(page: ChatView),
    MaterialRoute(page: DashboardView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
  ],
)
class App {}
