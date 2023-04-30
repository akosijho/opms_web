import 'package:flutter/material.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/search_index/search_index.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/models/medicine/medicine.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/navigation/navigation_service.dart';
import '../../../core/service/snack_bar/snack_bar_service.dart';

class UpdateProductViewModel extends BaseViewModel {
//
  final validatorService = locator<ValidatorService>();
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final searchIndexService = locator<SearchIndexService>();

  final updateFormKey = GlobalKey<FormState>();
  final productNameTxtController = TextEditingController();
  final brandNameTxtController = TextEditingController();
  final amountTxtController = TextEditingController();

  @override
  void dispose() {
    productNameTxtController.dispose();
    brandNameTxtController.dispose();
    amountTxtController.dispose();
    super.dispose();
  }

  void init(Product medicine) async {
    setBusy(true);
    await Future.delayed(Duration(milliseconds: 500));
    productNameTxtController.text = medicine.productName;
    brandNameTxtController.text = medicine.brandName!;
    amountTxtController.text = medicine.price ?? 'Not Set';
    setBusy(false);
  }

  void performUpdate(String productId) async {
    dialogService.showConfirmDialog(
        title: 'Update service',
        middleText:
            'This action will saved the changes made in the selected service. Continue this action?',
        onCancel: () => navigationService.pop(),
        onContinue: () => updateProduct(productId));
  }

  void updateProduct(String productId) async {
    dialogService.showDefaultLoadingDialog(
        barrierDismissible: false, willPop: true);
    // final productIndex = await searchIndexService.setSearchIndex(
    //     string: productNameTxtController.text);
    // final brandIndex = await searchIndexService.setSearchIndex(
    //     string: productNameTxtController.text);
    final product = Product(
      id: productId,
      productName: productNameTxtController.text,
      brandName: brandNameTxtController.text,
      price: amountTxtController.text,

    );

    final updateProductQuery = await apiService.updateProduct(product);
    if (updateProductQuery.success) {
      navigationService.popUntilNamed(Routes.MainBodyView);
      snackBarService.showSnackBar(
          message: 'Product was updated.', title: 'Success!');
    } else {
      navigationService.popUntilNamed(Routes.UpdateProductViews);
      snackBarService.showSnackBar(
          message: updateProductQuery.errorMessage!, title: 'Network Error');
    }
  }

  // void performUpdate(String productId) {
  //   dialogService.showConfirmDialog(
  //     title: 'Update product',
  //     middleText:
  //     'This action will saved the changes made in the selected product. Continue this action?',
  //     onCancel: () => navigationService.pop(),
  //     onContinue: () async {
  //       await dialogService.showDefaultLoadingDialog(
  //         barrierDismissible: false,
  //         willPop: true,
  //       );
  //       // final productIndex = await searchIndexService.setSearchIndex(
  //       //   string: productNameTxtController.text,
  //       // );
  //       // final brandIndex = await searchIndexService.setSearchIndex(
  //       //   string: productNameTxtController.text,
  //       // );
  //       final product = Medicine(
  //         id: productId,
  //         medicineName: productNameTxtController.text,
  //         brandName: brandNameTxtController.text,
  //         price: amountTxtController.text,
  //       );
  //
  //       final updateProductQuery = await apiService.updateProduct(product);
  //       if (updateProductQuery.success) {
  //         navigationService.popUntilNamed(Routes.MainBodyView);
  //         snackBarService.showSnackBar(
  //           message: 'Product was updated.',
  //           title: 'Success!',
  //         );
  //       } else {
  //         navigationService.popUntilNamed(Routes.UpdateProcedureViews);
  //         snackBarService.showSnackBar(
  //           message: updateProductQuery.errorMessage!,
  //           title: 'Network Error',
  //         );
  //       }
  //     },
  //   );
  // }

}
