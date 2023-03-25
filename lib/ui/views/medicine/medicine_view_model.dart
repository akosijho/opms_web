import 'dart:async';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/medicine/medicine.dart';
import 'package:stacked/stacked.dart';

class MedicineViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? medicineStreamSub;
  List<Medicine> medicineList = [];

  bool isScrolledUp = true;
  bool searchMode = false;

  @override
  void dispose() {
    medicineStreamSub!.cancel();
    super.dispose();
  }

  void setFabSize({required bool isScrolledUp}) {
    this.isScrolledUp = isScrolledUp;
    notifyListeners();
  }

  void getMedicineList() {
    apiService.getPatients().listen((event) {
      medicineStreamSub?.cancel();
      medicineStreamSub = apiService.getMedicineList().listen((medicine) {
        medicineList = medicine;
        notifyListeners();
      });
    });
  }

  void deleteMedicine(String medicineId) {
    //  Todo: logic code to delete medicine
  }

  void searchMedicine(String query) {
    if (searchMode == false) {
      searchMode = true;
      notifyListeners();
    }
  }
}
