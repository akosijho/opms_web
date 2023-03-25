import 'dart:async';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/core/service/url_launcher/url_launcher_service.dart';
import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:stacked/stacked.dart';

class PatientsViewModel extends BaseViewModel {
  List<Patient> patientList = [];
  StreamSubscription? patientSub;
  final apiService = locator<ApiService>();
  final toastService = locator<ToastService>();
  final urlLauncherService = locator<URLLauncherService>();
  final navigationService = locator<NavigationService>();
  bool isScrolledUp = true;
  final stickController = StickyHeaderController();
  final scrollController = ScrollController();

  @override
  void dispose() {
    stickController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void getPatientList() {
    apiService.getPatients().listen((event) {
      patientSub?.cancel();
      patientSub = apiService.getPatients().listen((myPatientList) {
        patientList = myPatientList;
        notifyListeners();
      });
    });
  }

  void setFabSize({required bool isScrolledUp}) {
    this.isScrolledUp = isScrolledUp;
    notifyListeners();
  }

  Future<void> searchPatient(String value) async {
    setBusy(true);
    if (value.isNotEmpty) {
      value.trim();
      value.toLowerCase();
      patientList = await apiService.searchPatient(value);
      notifyListeners();
    } else {
      getPatientList();
    }
    setBusy(false);
  }

  void goToPatientInfoView(int index) {
    navigationService.pushNamed(Routes.PatientInfoView,
        arguments: PatientInfoViewArguments(patient: patientList[index]));
  }
}
