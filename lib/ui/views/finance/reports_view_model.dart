import 'package:stacked/stacked.dart';

class ReportsViewModel extends BaseViewModel {
  int currentIndex = 0;

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
