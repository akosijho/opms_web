import 'dart:async';

import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/navigation/navigation_service.dart';
import '../../../models/medicine/medicine.dart';

class SelectProductViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? productSub;

  List<Product> productList = [];
  List<Product> selectedProduct = [];

  void init() async {
    getProduct();
  }

  @override
  void dispose() {
    productSub?.cancel();
    super.dispose();
  }

  void getProduct() {
    apiService.getPatients().listen((event) {
      productSub?.cancel();
      productSub = apiService.getProductList().listen((medicine) {
        productList = medicine;
        notifyListeners();
      });
    });
  }

  bool productExistInSelectedMedicines(String medicineId) {
    if ((selectedProduct
        .map((medicine) => medicine.id)
        .contains(medicineId))) {
      return true;
    } else {
      return false;
    }
  }

  void returnSelectedProduct() {
    navigationService.pop(returnValue: selectedProduct);
  }
}
