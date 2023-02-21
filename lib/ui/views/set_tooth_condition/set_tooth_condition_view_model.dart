import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/app/app.router.dart';
import 'package:opmsapp/core/service/api/api_service.dart';
import 'package:opmsapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmsapp/core/service/dialog/dialog_service.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:opmsapp/core/service/toast/toast_service.dart';
import 'package:opmsapp/core/service/validator/validator_service.dart';
import 'package:opmsapp/models/tooth_condition/tooth_condition.dart';
import 'package:opmsapp/ui/views/patient_dental_chart/patient_dental_chart_view_model.dart';
import 'package:opmsapp/ui/widgets/selection_date/selection_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SetToothConditionViewModel extends BaseViewModel {
  final validatorService = locator<ValidatorService>();
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();
  final toastService = locator<ToastService>();
  final bottomSheetService = locator<BottomSheetService>();

  final setToothConditionFormKey = GlobalKey<FormState>();
  final toothConditionTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final dateTextController =
      TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));

  @override
  void dispose() {
    toothConditionTextController.dispose();
    dateTextController.dispose();
    super.dispose();
  }

  void goToSelectToothCondition() async {
    final toothCondition =
        await navigationService.pushNamed(Routes.SelectionToothCondition);
    if (toothCondition != null) {
      toothConditionTextController.text = toothCondition;
    }
  }

  Future<void> addToothCondition({
    required String patientId,
    required List<String> selectedTeeth,
  }) async {
    dialogService.showDefaultLoadingDialog(
        barrierDismissible: false, willPop: false);
    for (String tooth in selectedTeeth) {
      debugPrint('adding ${tooth}');
      await apiService.addToothCondition(
        toothId: tooth,
        patientId: patientId,
        toothCondition: ToothCondition(
          selectedTooth: tooth,
          toothCondition: toothConditionTextController.text,
          date: selectedDate.toString(),
        ),
      );
    }
    navigationService.popRepeated(2);
    toastService.showToast(message: 'Successful: Set Tooth Condition!');
    debugPrint('Tooth Condition Added');
    refreshKey.currentState?.show();
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
}
