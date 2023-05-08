import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';

class ReportsViewModel extends BaseViewModel {
  int currentIndex = 0;
  final navigationService = locator<NavigationService>();
  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
