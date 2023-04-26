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
  List<Medicine> tempProduct = [];

  bool isScrolledUp = true;
  bool searchMode = false;

  @override
  void dispose() {
    medicineStreamSub!.cancel();
    super.dispose();
  }
  void init() async {
    setBusy(true);
    await getProducts();
    await Future.delayed(Duration(seconds: 1));
    setBusy(false);
    getMedicineList();
  }

  void setFabSize({required bool isScrolledUp}) {
    this.isScrolledUp = isScrolledUp;
    notifyListeners();
  }
  Future<void> getProducts() async {
    final products = await apiService.getProducts();
    if (products != null) {
      medicineList.clear();
      medicineList.addAll(products);
      tempProduct.clear();
      tempProduct.addAll(products);

      notifyListeners();
    }
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
