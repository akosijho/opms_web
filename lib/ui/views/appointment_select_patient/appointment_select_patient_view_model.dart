import 'dart:async';

import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/app/app.router.dart';
import 'package:opmsapp/core/service/api/api_service.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:opmsapp/models/patient_model/patient_model.dart';
import 'package:stacked/stacked.dart';

class AppointmentSelectPatientViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? patientSubscription;
  List<Patient> patientList = [];
  List<Patient> tempPatientList = [];

  @override
  void dispose() {
    patientSubscription?.cancel();
    super.dispose();
  }

  void init() {
    apiService.getPatients().listen((event) {
      patientSubscription?.cancel();
      patientSubscription = apiService.getPatients().listen((event) {
        patientList = event;
        tempPatientList = patientList;
        notifyListeners();
      });
    });
  }

  Future<void> searchPatient(String value) async {
    setBusy(true);
    if (value.isNotEmpty) {
      value.trim();
      value.toLowerCase();
      patientList = await apiService.searchPatient(value);
      notifyListeners();
    } else {
      init();
    }
    setBusy(false);
  }

  void selectPatient(Patient patient) {
    navigationService.pushNamed(Routes.CreateAppointmentView,
        arguments:
            CreateAppointmentViewArguments(patient: patient, popTimes: 3));
  }
}
