import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';

class SelectionDateViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  DateTime? selectedDate;
  final dateTimeNow = DateTime.now();
  final defaultStartDate = DateTime.utc(2000);

  void setSelectedDate(DateTime dateTime) {
    selectedDate = dateTime;
    notifyListeners();
  }

  void setReturnDate({DateTime? initialDate}) {
    dynamic defaultSelectedDate = initialDate ?? defaultStartDate;
    navigationService.pop(
        returnValue: selectedDate ?? defaultSelectedDate ?? '');
  }
}
