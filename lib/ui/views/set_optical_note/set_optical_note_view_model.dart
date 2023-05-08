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
import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:opmswebstaff/ui/views/add_payment/add_payment_view.dart';
import 'package:opmswebstaff/ui/views/patient_optical_chart/patient_optical_chart_view_model.dart';
import 'package:opmswebstaff/ui/views/view_optical_note/view_optical_note.dart';
import 'package:opmswebstaff/ui/widgets/selection_service/selection_service.dart';
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

  // void goToSelectProcedure() async {
  //   selectedService =
  //   await navigationService.pushNamed(Routes.SelectionService);
  //
  //   procedureTxtController.text = selectedService?.serviceName ?? '';
  // }
  // void goToSelectProcedure(BuildContext context) async {
  //   selectedService = await navigationService.pushNamed(Routes.SelectionService);
  //   procedureTxtController.text = selectedService?.serviceName ?? '';
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: Container(
  //             width: 300,
  //             height: 400,
  //             child: SelectionService()
  //         ),
  //       );
  //     },
  //   );
  // }
  void goToSelectService(BuildContext context) async {
    // selectedService = await navigationService.pushNamed(Routes.SelectionService);
    // procedureTxtController.text = selectedService?.serviceName ?? '';
    Service? tempService = await showDialog<Service>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: SelectionService(),
          ),
        );
      },
    );
    if (tempService != null) {
      selectedService = tempService;
      notifyListeners();
      procedureTxtController.text = selectedService?.serviceName ?? '';
    }
  }

  // void selectDate() async {
  //   final DateTime date =
  //   await bottomSheetService.openBottomSheet(SelectionDate(
  //     title: 'Set date',
  //     initialDate: DateTime.now(),
  //     maxDate: DateTime.now(),
  //   ));
  //   if (date != null) {
  //     selectedDate = date;
  //     notifyListeners();
  //     dateTextController.text = DateFormat.yMMMd().format(selectedDate);
  //   }
  // }

  void selectDate(BuildContext context) async {
    final DateTime? date = await showDialog<DateTime>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 450,
            height: 450,
            child: SelectionDate(
              title: 'Set date',
              initialDate: DateTime.now(),
              maxDate: DateTime.now(),
            ),
          ),
        );
      },
    );

    if (date != null) {
      selectedDate = date;
      notifyListeners();
      dateTextController.text = DateFormat.yMMMd().format(selectedDate);
    }
  }

  // Future<void> addOpticalNote({
  //   required String patientId,
  // }) async {
  //   dialogService.showDefaultLoadingDialog(
  //       barrierDismissible: false, willPop: false);
  //
  //   final patientReference = FirebaseFirestore.instance.collection('patients');
  //   final toothDoc =
  //   await patientReference.doc(patientId).collection('optical_notes').doc();
  //   await toothDoc.set(OpticalNotes(
  //     isPaid: false,
  //     sphere: sphere.text,
  //     cylinder: cylinder.text,
  //     axis: axis.text,
  //     pd: pd.text,
  //     add: add.text,
  //     va: va.text,
  //     sphereCL: sphereCL.text,
  //     cylinderCL: cylinderCL.text,
  //     axisCL: axisCL.text,
  //     bcCL: bcCL.text,
  //     diaCL: diaCL.text,
  //     tintCL: tintCL.text,
  //     service: selectedService!,
  //     date: selectedDate.toString(),
  //     note: noteTextController.text,
  //
  //   ).toJson(id: toothDoc.id, procedureId: selectedService!.id));
  //   navigationService.closeOverlay();
  //   toastService.showToast(message: 'Successful: Set RX!');
  //   debugPrint('RX Added');
  //   refreshKey.currentState?.show();
  // }
  Future<void> addOpticalNote({
    required String patientId,
  }) async {
    try {
      dialogService.showDefaultLoadingDialog(
        barrierDismissible: false,
        willPop: false,
      );

      final patientReference =
          FirebaseFirestore.instance.collection('patients');
      final toothDoc = await patientReference
          .doc(patientId)
          .collection('optical_notes')
          .doc();

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

      navigationService.popRepeated(1);
      fieldsClear();
      toastService.showToast(message: 'Successful: Set RX!');
      debugPrint('RX Added');
      refreshKey.currentState?.show();
    } catch (e) {
      debugPrint('Error adding optical note: $e');
      toastService.showToast(message: 'Error adding optical note');
    }
  }

  void fieldsClear(){
    sphere.clear();
    cylinder.clear();
    axis.clear();
    pd.clear();
    add.clear();
    va.clear();
    sphereCL.clear();
    cylinderCL.clear();
    axisCL.clear();
    bcCL.clear();
    diaCL.clear();
    tintCL.clear();
    noteTextController.clear();
  }

  void goToOpticalNote (BuildContext context, Patient patient) async {
    await showDialog<Patient>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16),
          content: Container(
            width: 700,
            height: 700,
            child: ViewOpticalNote(patient: patient),
          ),
        );
      },
    );
  }

  void goToAddPayment (BuildContext context, Patient patient) async {
    await showDialog<Patient>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16),
          content: Container(
            width: 700,
            height: 700,
            child: AddPaymentView(patient: patient),
          ),
        );
      },
    );
  }
}
