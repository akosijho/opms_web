
import 'package:flutter/material.dart';
import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/search_index/search_index.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/models/product/lens.dart';
import 'package:stacked/stacked.dart';



class UpdateLensViewModel extends BaseViewModel {
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

  void init(Lens lens) async {
    setBusy(true);
    await Future.delayed(Duration(milliseconds: 500));
    productNameTxtController.text = lens.lensName;
    brandNameTxtController.text = lens.brandName!;
    amountTxtController.text = lens.price ?? 'Not Set';
    setBusy(false);
  }

  void performUpdate(String lensId) async {
    dialogService.showConfirmDialog(
        title: 'Update lens',
        middleText:
        'This action will saved the changes made in the selected lens. Continue this action?',
        onCancel: () => navigationService.pop(),
        onContinue: () => updateLens(lensId));
  }

  void updateLens(String lensId) async {
    dialogService.showDefaultLoadingDialog(
        barrierDismissible: false, willPop: true);
    final productIndex = await searchIndexService.setSearchIndex(
        string: productNameTxtController.text);
    final brandIndex = await searchIndexService.setSearchIndex(
        string: productNameTxtController.text);
    final lens = Lens(
      id: lensId,
      lensName: productNameTxtController.text,
      brandName: brandNameTxtController.text,
      price: amountTxtController.text,

    );

    final updateLensQuery = await apiService.updateLens(lens);
    if (updateLensQuery.success) {
      navigationService.popUntilNamed(Routes.MainBodyView);
      snackBarService.showSnackBar(
          message: 'Product was updated.', title: 'Success!');
    } else {
      navigationService.popUntilNamed(Routes.UpdateLensViews);
      snackBarService.showSnackBar(
          message: updateLensQuery.errorMessage!, title: 'Network Error');
    }
  }
}
