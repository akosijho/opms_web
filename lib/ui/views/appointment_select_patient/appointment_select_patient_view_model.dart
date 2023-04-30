import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:opmswebstaff/ui/views/appointment_select_patient/appointment_select_patient_view.dart';
import 'package:opmswebstaff/ui/views/create_appointment/create_appointment_view.dart';
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

  // void selectPatient(Patient patient) {
  //   navigationService.pushNamed(Routes.CreateAppointmentView,
  //       arguments:
  //           CreateAppointmentViewArguments(patient: patient, popTimes: 3));
  // }

  void selectPatient(BuildContext context,Patient patient ) async {
    await showDialog<Patient>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: CreateAppointmentView(patient: patient, popTimes: 3),
          ),
        );
      },
    );

      // navigationService.pushNamed(Routes.CreateAppointmentView,
      //     arguments: CreateAppointmentViewArguments(patient: patient, popTimes: 3));

  }

}
