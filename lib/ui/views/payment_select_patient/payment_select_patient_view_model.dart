import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/ui/views/add_payment/add_payment_view.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/patient_model/patient_model.dart';

class PaymentSelectPatientViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  List<Patient> patientList = [];
  StreamSubscription? patientSubscription;

  void init() {
    apiService.getPatients().listen((event) {
      patientSubscription?.cancel();
      patientSubscription = apiService.getPatients().listen((event) {
        patientList = event;
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
  //   navigationService.pushNamed(Routes.AddPaymentView,
  //       arguments: AddPaymentViewArguments(patient: patient));
  // }

  void selectPatient(BuildContext context, Patient patient) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: AddPaymentView(patient: patient,),
          ),
        );
      },
    );
  }
}
