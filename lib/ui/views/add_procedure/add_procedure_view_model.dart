import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/search_index/search_index.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/models/procedure/procedure.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class AddProcedureViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final toastService = locator<ToastService>();
  final apiService = locator<ApiService>();
  final validatorService = locator<ValidatorService>();
  final dialogService = locator<DialogService>();
  final searchIndexService = locator<SearchIndexService>();

  Future<void> addProcedure(
      {required String procedureName, String? price}) async {
    setBusy(true);
    dialogService.showDefaultLoadingDialog(
        barrierDismissible: false, willPop: false);
    try {
      final procedureIndex =
          await searchIndexService.setSearchIndex(string: procedureName);
      await apiService.addProcedure(
          procedure: Procedure(
        searchIndex: procedureIndex,
        procedureName: procedureName,
        price: price ?? '',
      ));
      setBusy(false);
      navigationService.closeOverlay();
      navigationService.pop();
      toastService.showToast(message: 'Procedure Added');
    } catch (e) {
      debugPrint(e.toString());
      setBusy(false);
    }
  }
}
