import 'package:universal_milk/main/bootstrap.dart';
import 'package:universal_milk/models/enums/flavor.dart';
import 'package:universal_milk/features/app/app_view.dart';

void main() {
  bootstrap(
    builder: () => const AppView(),
    flavor: Flavor.production,
  );
}
