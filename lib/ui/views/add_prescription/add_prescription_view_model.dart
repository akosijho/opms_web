import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/api/api_service.dart';
import '../../../core/service/dialog/dialog_service.dart';
import '../../../models/prescription/prescription.dart';
import '../../widgets/selection_date/selection_date.dart';

class AddPrescriptionViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final bottomSheetService = locator<BottomSheetService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final validatorService = locator<ValidatorService>();
  final apiService = locator<ApiService>();

  final addPrescriptionFormKey = GlobalKey<FormState>();
  DateTime selectedDateTime = DateTime.now();
  final dateTxtController =
      TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));

  List<PrescriptionItem> prescriptionItem = [];

  void selectDate() async {
    final DateTime? date =
        await bottomSheetService.openBottomSheet(SelectionDate(
      title: 'Set date',
      initialDate: DateTime.now(),
      maxDate: DateTime.now(),
    ));
    if (date != null) {
      selectedDateTime = date;
      notifyListeners();
      dateTxtController.text = DateFormat.yMMMd().format(selectedDateTime);
    }
  }

  void addPrescriptionItem() async {
    final item =
        await navigationService.pushNamed(Routes.AddPrescriptionItemView);
    if (item != null) {
      prescriptionItem.add(item);
      notifyListeners();
    }
  }

  Future<void> savePrescription(String patientId) async {
    if (addPrescriptionFormKey.currentState!.validate()) {
      if (prescriptionItem.isNotEmpty) {
        dialogService.showDefaultLoadingDialog(
            willPop: false, barrierDismissible: false);
        final addPrescriptionQuery = await apiService.addPrescription(
            prescription: Prescription(
                date: selectedDateTime.toString(),
                prescriptionItems: prescriptionItem),
            patientId: patientId);
        if (addPrescriptionQuery.success) {
          navigationService.popUntilNamed(Routes.PrescriptionView);
          snackBarService.showSnackBar(
              message: 'New Prescription Added', title: 'Success!');
        } else {
          navigationService.pop();
          snackBarService.showSnackBar(
              message: addPrescriptionQuery.errorMessage!,
              title: 'Network Error');
        }
      } else {
        snackBarService.showSnackBar(
            message: 'Prescription Item is empty. Add now');
      }
    }
  }
}
