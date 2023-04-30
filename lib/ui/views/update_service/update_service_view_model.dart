import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/search_index/search_index.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:flutter/material.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/navigation/navigation_service.dart';
import '../../../core/service/snack_bar/snack_bar_service.dart';

class UpdateServiceViewModel extends BaseViewModel {
//
  final validatorService = locator<ValidatorService>();
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final searchIndexService = locator<SearchIndexService>();

  final updateFormKey = GlobalKey<FormState>();
  final serviceNameTxtController = TextEditingController();
  final amountTxtController = TextEditingController();

  @override
  void dispose() {
    serviceNameTxtController.dispose();
    amountTxtController.dispose();
    super.dispose();
  }

  void init(Service service) async {
    setBusy(true);
    await Future.delayed(Duration(milliseconds: 500));
    serviceNameTxtController.text = service.serviceName;
    amountTxtController.text = service.price ?? 'Not Set';
    setBusy(false);
  }

  void performUpdate(String serviceId) async {
    dialogService.showConfirmDialog(
        title: 'Update service',
        middleText:
            'This action will saved the changes made in the selected service. Continue this action?',
        onCancel: () => navigationService.pop(),
        onContinue: () => updateService(serviceId));
  }

  void updateService(String serviceId) async {
    dialogService.showDefaultLoadingDialog(
        barrierDismissible: false, willPop: true);
    final procedureIndex = await searchIndexService.setSearchIndex(
        string: serviceNameTxtController.text);
    final procedure = Service(
      id: serviceId,
      serviceName: serviceNameTxtController.text,
      price: amountTxtController.text,
      searchIndex: procedureIndex,
    );

    final updateServiceQuery = await apiService.updateService(procedure);
    if (updateServiceQuery.success) {
      navigationService.popUntilNamed(Routes.MainBodyView);
      snackBarService.showSnackBar(
          message: 'Service was updated.', title: 'Success!');
    } else {
      navigationService.popUntilNamed(Routes.UpdateServiceViews);
      snackBarService.showSnackBar(
          message: updateServiceQuery.errorMessage!, title: 'Network Error');
    }
  }
}
