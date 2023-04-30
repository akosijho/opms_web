import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/models/optical_notes/optical_notes.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:opmswebstaff/ui/views/patient_optical_chart/patient_optical_chart_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../widgets/selection_date/selection_date.dart';

class SetOpticalNoteViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();
  final procedureTxtController = TextEditingController();
  final setDentalNoteFormKey = GlobalKey<FormState>();
  final toastService = locator<ToastService>();
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();

  Service? selectedService;
  DateTime selectedDate = DateTime.now();
  final dateTextController =
  TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));
  final noteTextController = TextEditingController();
  final sphere = TextEditingController();
  final cylinder = TextEditingController();
  final axis = TextEditingController();
  final pd = TextEditingController();
  final add = TextEditingController();
  final va = TextEditingController();
  //contact lens
  final sphereCL = TextEditingController();
  final cylinderCL = TextEditingController();
  final axisCL = TextEditingController();
  final bcCL = TextEditingController();
  final diaCL = TextEditingController();
  final tintCL = TextEditingController();


  void goToSelectProcedure() async {
    selectedService =
    await navigationService.pushNamed(Routes.SelectionService);

    procedureTxtController.text = selectedService?.serviceName ?? '';
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
  }) async {
    dialogService.showDefaultLoadingDialog(
        barrierDismissible: false, willPop: false);

    final patientReference = FirebaseFirestore.instance.collection('patients');
    final toothDoc =
    await patientReference.doc(patientId).collection('optical_notes').doc();
    await toothDoc.set(OpticalNotes(
      isPaid: false,
      sphere: sphere.text,
      cylinder: cylinder.text,
      axis: axis.text,
      pd: pd.text,
      add: add.text,
      va: va.text,
      sphereCL: sphereCL.text,
      cylinderCL: cylinderCL.text,
      axisCL: axisCL.text,
      bcCL: bcCL.text,
      diaCL: diaCL.text,
      tintCL: tintCL.text,
      service: selectedService!,
      date: selectedDate.toString(),
      note: noteTextController.text,

    ).toJson(id: toothDoc.id, procedureId: selectedService!.id));
    navigationService.popRepeated(2);
    toastService.showToast(message: 'Successful: Set RX!');
    debugPrint('RX Added');
    refreshKey.currentState?.show();
  }
}
