// import 'dart:async';
//
// import 'package:opmsapp/app/app.locator.dart';
// import 'package:opmsapp/core/service/api/api_service.dart';
// import 'package:opmsapp/core/service/navigation/navigation_service.dart';
// import 'package:opmsapp/models/product/product.dart';
// import 'package:stacked/stacked.dart';
//
// class FrameViewModel extends BaseViewModel {
//   final navigationService = locator<NavigationService>();
//   final apiService = locator<ApiService>();
//   StreamSubscription? medicineStreamSub;
//   List<Product> productList = [];
//
//   bool isScrolledUp = true;
//   bool searchMode = false;
//
//   @override
//   void dispose() {
//     medicineStreamSub!.cancel();
//     super.dispose();
//   }
//
//   void setFabSize({required bool isScrolledUp}) {
//     this.isScrolledUp = isScrolledUp;
//     notifyListeners();
//   }
//
//   void getProductList() {
//     apiService.getPatients().listen((event) {
//       medicineStreamSub?.cancel();
//       medicineStreamSub = apiService.getProductList().listen((product) {
//         productList = product;
//         notifyListeners();
//       });
//     });
//   }
//
//   void deleteMedicine(String medicineId) {
//     //  Todo: logic code to delete product
//   }
//
//   void searchProduct(String query) {
//     if (searchMode == false) {
//       searchMode = true;
//       notifyListeners();
//     }
//   }
// }
// import 'dart:async';
//
// import 'package:opmsapp/app/app.locator.dart';
// import 'package:opmsapp/core/service/api/api_service.dart';
// import 'package:opmsapp/core/service/navigation/navigation_service.dart';
// import 'package:opmsapp/models/product/product.dart';
// import 'package:stacked/stacked.dart';
//
// class ProductViewModel extends BaseViewModel {
//   final navigationService = locator<NavigationService>();
//   final apiService = locator<ApiService>();
//   StreamSubscription? medicineStreamSub;
//   List<Product> productList = [];
//
//   bool isScrolledUp = true;
//   bool searchMode = false;
//
//   @override
//   void dispose() {
//     medicineStreamSub!.cancel();
//     super.dispose();
//   }
//
//   void setFabSize({required bool isScrolledUp}) {
//     this.isScrolledUp = isScrolledUp;
//     notifyListeners();
//   }
//
//   void getProductList() {
//     apiService.getPatients().listen((event) {
//       medicineStreamSub?.cancel();
//       medicineStreamSub = apiService.getProductList().listen((product) {
//         productList = product;
//         notifyListeners();
//       });
//     });
//   }
//
//   void deleteMedicine(String medicineId) {
//     //  Todo: logic code to delete product
//   }
//
//   void searchProduct(String query) {
//     if (searchMode == false) {
//       searchMode = true;
//       notifyListeners();
//     }
//   }
// }
import 'package:stacked/stacked.dart';

class FrameLensViewModel extends BaseViewModel {
  int currentIndex = 0;

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
