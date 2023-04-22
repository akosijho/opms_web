import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/models/dental_notes/dental_notes.dart';
import 'package:opmswebstaff/models/procedure/procedure.dart';
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

  // Future<void> addDentalNote({
  //   required String patientId,
  //   required List<String> selectedTeeth,
  // }) async {
  //   dialogService.showDefaultLoadingDialog(
  //       barrierDismissible: false, willPop: false);
  //   for (String tooth in selectedTeeth) {
  //     debugPrint('adding ${tooth}');
  //     await apiService.addToothDentalNotes(
  //         toothId: tooth,
  //         patientId: patientId,
  //         procedureId: selectedProcedure!.id,
  //         dentalNotes: DentalNotes(
  //           isPaid: false,
  //           selectedTooth: tooth,
  //           procedure: selectedProcedure!,
  //           date: selectedDate.toString(),
  //           note: noteTextController.text,
  //         ));
  //   }
  //   navigationService.popRepeated(2);
  //   toastService.showToast(message: 'Successful: Set Tooth Condition!');
  //   debugPrint('Tooth Condition Added');
  //   refreshKey.currentState?.show();
  // }

  Future<void> addDentalNote({
    required String patientId,
    // required String sphere,
    // required String cylinder,
    // required String axis,
    // required List<String> selectedTeeth,
  }) async {
    dialogService.showDefaultLoadingDialog(
        barrierDismissible: false, willPop: false);
    // for (String tooth in selectedTeeth) {
    //   debugPrint('adding ${tooth}');
    //   await apiService.addToothDentalNotes(
    //       toothId: tooth,
    //       // sphere: sphere,
    //       // cylinder: cylinder,
    //       // axis: axis,
    //       patientId: patientId,
    //       procedureId: selectedProcedure!.id,
    //       dentalNotes: DentalNotes(
    //         isPaid: false,
    //         selectedTooth: tooth,
    //         sphere: sphere.text,
    //         cylinder: cylinder.text,
    //         axis: axis.text,
    //         procedure: selectedProcedure!,
    //         date: selectedDate.toString(),
    //         note: noteTextController.text,
    //
    //       ));
    // }

    final patientReference = FirebaseFirestore.instance.collection('patients');
    final toothDoc =
    await patientReference.doc(patientId).collection('dental_notes').doc();
    await toothDoc.set(DentalNotes(
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
      procedure: selectedProcedure!,
      date: selectedDate.toString(),
      note: noteTextController.text,

    ).toJson(id: toothDoc.id, procedureId: selectedProcedure!.id));
    navigationService.popRepeated(2);
    toastService.showToast(message: 'Successful: Set RX!');
    debugPrint('RX Added');
    refreshKey.currentState?.show();
  }
}
