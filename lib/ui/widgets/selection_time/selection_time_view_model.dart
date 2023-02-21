import 'package:stacked/stacked.dart';

import '../../../main.dart';

class SelectionTimeViewModel extends BaseViewModel {
  DateTime defaultStartTime = DateTime.now();
  DateTime? selectedTime;

  void setSelectedTime(DateTime initialDate) {
    selectedTime = initialDate;
    notifyListeners();
  }

  void setReturnDateTime({DateTime? initialDate}) {
    final defaultSelectedTime = initialDate ?? defaultStartTime;
    navigationService.pop(returnValue: selectedTime ?? defaultSelectedTime);
  }
}
