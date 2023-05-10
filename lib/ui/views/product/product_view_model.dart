import 'dart:async';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/product/product.dart';
import 'package:stacked/stacked.dart';

class ProductViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? productStreamSub;
  List<Product> productList = [];
  List<Product> tempProduct = [];

  bool isScrolledUp = true;
  bool searchMode = false;

  @override
  void dispose() {
    productStreamSub!.cancel();
    super.dispose();
  }
  void init() async {
    setBusy(true);
    await getProducts();
    await Future.delayed(Duration(seconds: 1));
    setBusy(false);
    getProductList();
  }

  void setFabSize({required bool isScrolledUp}) {
    this.isScrolledUp = isScrolledUp;
    notifyListeners();
  }
  Future<void> getProducts() async {
    final products = await apiService.getProducts();
    if (products != null) {
      productList.clear();
      productList.addAll(products);
      tempProduct.clear();
      tempProduct.addAll(products);

      notifyListeners();
    }
    notifyListeners();
  }

  void getProductList() {
    apiService.getPatients().listen((event) {
      productStreamSub?.cancel();
      productStreamSub = apiService.getProductList().listen((product) {
        productList = product;
        notifyListeners();
      });
    });
  }

  void deleteMedicine(String medicineId) {
    //  Todo: logic code to delete product
  }

  void searchMedicine(String query) {
    if (searchMode == false) {
      searchMode = true;
      notifyListeners();
    }
  }
}
