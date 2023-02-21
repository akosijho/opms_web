import 'package:opmsapp/core/service/api/api_service.dart';
import 'package:opmsapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmsapp/core/service/dialog/dialog_service.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:opmsapp/core/service/toast/toast_service.dart';
import 'package:opmsapp/core/service/validator/validator_service.dart';
import 'package:opmsapp/models/dental_notes/dental_notes.dart';
import 'package:opmsapp/models/procedure/procedure.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../widgets/selection_date/selection_date.dart';
import '../patient_dental_chart/patient_dental_chart_view_model.dart';

class SetDentalNoteViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();
  final procedureTxtController = TextEditingController();
  final setDentalNoteFormKey = GlobalKey<FormState>();
  final toastService = locator<ToastService>();
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();

  Procedure? selectedProcedure;
  DateTime selectedDate = DateTime.now();
  final dateTextController =
      TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));
  final noteTextController = TextEditingController();

  void goToSelectProcedure() async {
    selectedProcedure =
        await navigationService.pushNamed(Routes.SelectionProcedure);

    procedureTxtController.text = selectedProcedure?.procedureName ?? '';
  }

  void selectDate() async {
    final DateTime date =
        await bottomSheetService.openBottomSheet(SelectionDate(
      title: 'Set date',
      initialDate: DateTime.now(),
      maxDate: DateTime.now(),
    ));
    if (date != null) {
      selectedDate = date;
      notifyListeners();
      dateTextController.text = DateFormat.yMMMd().format(selectedDate);
    }
  }

  Future<void> addDentalNote({
    required String patientId,
    required List<String> selectedTeeth,
  }) async {
    dialogService.showDefaultLoadingDialog(
        barrierDismissible: false, willPop: false);
    for (String tooth in selectedTeeth) {
      debugPrint('adding ${tooth}');
      await apiService.addToothDentalNotes(
          toothId: tooth,
          patientId: patientId,
          procedureId: selectedProcedure!.id,
          dentalNotes: DentalNotes(
            isPaid: false,
            selectedTooth: tooth,
            procedure: selectedProcedure!,
            date: selectedDate.toString(),
            note: noteTextController.text,
          ));
    }
    navigationService.popRepeated(2);
    toastService.showToast(message: 'Successful: Set Tooth Condition!');
    debugPrint('Tooth Condition Added');
    refreshKey.currentState?.show();
  }
}
