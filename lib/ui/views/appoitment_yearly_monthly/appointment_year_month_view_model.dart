import 'package:stacked/stacked.dart';

class AppointmentYearMonthViewModel extends BaseViewModel {
  int index = 0;

  void changeIndex(int index) {
    this.index = index;
    notifyListeners();
  }
}
