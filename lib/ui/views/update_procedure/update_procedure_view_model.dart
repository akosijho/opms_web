import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/search_index/search_index.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/navigation/navigation_service.dart';
import '../../../core/service/snack_bar/snack_bar_service.dart';
import '../../../models/procedure/procedure.dart';

class UpdateProcedureViewModel extends BaseViewModel {
//
  final validatorService = locator<ValidatorService>();
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final searchIndexService = locator<SearchIndexService>();

  final updateFormKey = GlobalKey<FormState>();
  final procedureNameTxtController = TextEditingController();
  final amountTxtController = TextEditingController();

  @override
  void dispose() {
    procedureNameTxtController.dispose();
    amountTxtController.dispose();
    super.dispose();
  }

  void init(Procedure procedure) async {
    setBusy(true);
    await Future.delayed(Duration(milliseconds: 500));
    procedureNameTxtController.text = procedure.procedureName;
    amountTxtController.text = procedure.price ?? 'Not Set';
    setBusy(false);
  }

  void performUpdate(String procedureId) async {
    dialogService.showConfirmDialog(
        title: 'Update procedure',
        middleText:
            'This action will saved the changes made in the selected procedure. Continue this action?',
        onCancel: () => navigationService.pop(),
        onContinue: () => updateProcedure(procedureId));
  }

  void updateProcedure(String procedureId) async {
    dialogService.showDefaultLoadingDialog(
        barrierDismissible: false, willPop: true);
    final procedureIndex = await searchIndexService.setSearchIndex(
        string: procedureNameTxtController.text);
    final procedure = Procedure(
      id: procedureId,
      procedureName: procedureNameTxtController.text,
      price: amountTxtController.text,
      searchIndex: procedureIndex,
    );

    final updateProcedureQuery = await apiService.updateProcedure(procedure);
    if (updateProcedureQuery.success) {
      navigationService.popUntilNamed(Routes.MainBodyView);
      snackBarService.showSnackBar(
          message: 'Procedure was updated.', title: 'Success!');
    } else {
      navigationService.popUntilNamed(Routes.UpdateProcedureViews);
      snackBarService.showSnackBar(
          message: updateProcedureQuery.errorMessage!, title: 'Network Error');
    }
  }
}
