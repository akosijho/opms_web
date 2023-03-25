import 'dart:async';

import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/navigation/navigation_service.dart';
import '../../../models/medicine/medicine.dart';

class SelectMedicineViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? medicineSub;

  List<Medicine> medicineList = [];
  List<Medicine> selectedMedicines = [];

  void init() async {
    getMedicine();
  }

  @override
  void dispose() {
    medicineSub?.cancel();
    super.dispose();
  }

  void getMedicine() {
    apiService.getPatients().listen((event) {
      medicineSub?.cancel();
      medicineSub = apiService.getMedicineList().listen((medicine) {
        medicineList = medicine;
        notifyListeners();
      });
    });
  }

  bool medicineExistInSelectedMedicines(String medicineId) {
    if ((selectedMedicines
        .map((medicine) => medicine.id)
        .contains(medicineId))) {
      return true;
    } else {
      return false;
    }
  }

  void returnSelectedMedicine() {
    navigationService.pop(returnValue: selectedMedicines);
  }
}
