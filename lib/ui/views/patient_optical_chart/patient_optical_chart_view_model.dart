import 'dart:async';
import 'package:flutter/material.dart';
import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/tooth_condition/tooth_condition.dart';
import 'package:stacked/stacked.dart';

import '../../../models/patient_model/patient_model.dart';

final GlobalKey<RefreshIndicatorState> refreshKey =
    new GlobalKey<RefreshIndicatorState>();

class PatientDentalChartViewModel extends BaseViewModel {
  // Patient? patientList;

  TextEditingController frameBrand = TextEditingController(),
      sphere = TextEditingController(),
      cylinder = TextEditingController(),
      axis = TextEditingController(),
      specr4 = TextEditingController(),
      specr5 = TextEditingController(),
      specr6 = TextEditingController(),
      specl1 = TextEditingController(),
      specl2 = TextEditingController(),
      specl3 = TextEditingController(),
      specl4 = TextEditingController(),
      specl5 = TextEditingController(),
      specl6 = TextEditingController(),
      lensr1 = TextEditingController(),
      lensr2 = TextEditingController(),
      lensr3 = TextEditingController(),
      lensr4 = TextEditingController(),
      lensr5 = TextEditingController(),
      lensr6 = TextEditingController(),
      lensl1 = TextEditingController(),
      lensl2 = TextEditingController(),
      lensl3 = TextEditingController(),
      lensl4 = TextEditingController(),
      lensl5 = TextEditingController(),
      lensl6 = TextEditingController();

  // void getPatientList() {
  //   apiService.getPatients().listen((event) {
  //     patientSub?.cancel();
  //     patientSub = apiService.getPatients().listen((myPatientList) {
  //       // patientList = myPatientList;
  //       notifyListeners();
  //     });
  //   });
  // }

  final centerTooth1 = ['E', 'F', 'P', 'O'];
  final centerTooth2 = ['8', '9', '25', '24'];

  List<String> toothWithTransactionHistory = [];

  final List<String> toothIdFromA = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J'
  ];
  final toothIdFromT = ['T', 'S', 'R', 'Q', 'P', 'O', 'N', 'M', 'L', 'K'];

  final toothIdFrom1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
  final toothIdFrom32 = [
    32,
    31,
    30,
    29,
    28,
    27,
    26,
    25,
    24,
    23,
    22,
    21,
    20,
    19,
    18,
    17
  ];

  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();

  bool isInSelectionMode = false;
  List<String> selectedTooth = [];
  StreamSubscription? patientSub;

  bool checkCenterTooth1(String toothID) {
    if (centerTooth1.contains(toothID)) {
      return true;
    } else
      return false;
  }

  bool checkCenterTooth2(String toothID) {
    if (centerTooth2.contains(toothID)) {
      return true;
    } else
      return false;
  }

  bool isSelected(String toothID) {
    if (selectedTooth.contains(toothID)) {
      return true;
    } else
      return false;
  }

  void addToSelectedTooth(String toothId) {
    if (selectedTooth.contains(toothId)) {
      selectedTooth.remove(toothId);
      print(toothId + ' isDeleted');
      notifyListeners();
    } else {
      selectedTooth.add(toothId);
      print(toothId + ' isAdded');
      notifyListeners();
    }
    if (selectedTooth.isEmpty) {
      isInSelectionMode = false;
      notifyListeners();
    } else {
      isInSelectionMode = true;
      notifyListeners();
    }
  }

  void viewDentalNoteById(
      {required Patient patient, required String selectedTooth}) {
    navigationService.pushNamed(Routes.ViewDentalNoteByToothView,
        arguments: ViewDentalNoteByToothViewArguments(
            patient: patient, selectedTooth: selectedTooth));
  }

  Future<void> getToothWithDentalCondition(
      {required String patientId, String? toothId}) async {
    var toothConditionList = await apiService.getDentalConditionList(
        patientId: patientId, toothId: toothId);
    for (ToothCondition i in toothConditionList ?? []) {
      if (!toothWithTransactionHistory.contains(i.selectedTooth)) {
        toothWithTransactionHistory.add(i.selectedTooth);
        notifyListeners();
      }
    }
  }

  void listenToPatientChanges({required String patientId}) async {
    apiService.getPatients().listen((event) async {
      patientSub?.cancel();
      patientSub = apiService.getPatients().listen((event) async {
        await init(patientId);
      });
    });
  }

  Future<void> getDentalNotes(
      {required String patientId, String? toothId}) async {
    var dentalNotes = await apiService.getOpticalNotesList(
        patientId: patientId, toothId: toothId);

    // for (DentalNotes i in dentalNotes ?? []) {
    //   if (!toothWithTransactionHistory.contains(i.selectedTooth)) {
    //     toothWithTransactionHistory.add(i.selectedTooth);
    //     notifyListeners();
    //   }
    // }
  }

  Future<void> init(String patientId) async {
    dialogService.showDefaultLoadingDialog();
    await getDentalNotes(patientId: patientId);
    await getToothWithDentalCondition(patientId: patientId);
    navigationService.pop();
    debugPrint(toothWithTransactionHistory.toString());
  }

  void showLoadingDialog(bool isBusy) {
    if (isBusy) {
    } else {
      navigationService.pop();
    }
  }

  bool hasHistory(String toothId) {
    if (toothWithTransactionHistory.contains(toothId)) {
      return true;
    } else {
      return false;
    }
  }

  // void goToSetToothCondition(String patientId) {
  //   selectedTooth.sort((a, b) => a.toString().compareTo(b.toString()));
  //   navigationService.pushNamed(Routes.SetToothConditionView,
  //       arguments: SetToothConditionViewArguments(
  //           selectedTeeth: selectedTooth, patientId: patientId));
  // }

  void goToSetDentalNote(String patientId) {
    selectedTooth.sort((a, b) => a.toString().compareTo(b.toString()));
    navigationService.pushNamed(Routes.SetOpticalNoteView,
        arguments: SetOpticalNoteViewArguments(
            selectedTeeth: selectedTooth, patientId: patientId));
  }

  void goToSetOpticalNote(String patientId){

  }

  // void goToChartLegend() {
  //   navigationService.pushNamed(Routes.DentalChartLegend);
  // }

  @override
  void dispose() {
    patientSub?.cancel();
    super.dispose();
  }
}
