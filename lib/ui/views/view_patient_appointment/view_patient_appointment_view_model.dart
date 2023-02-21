import 'dart:async';

import 'package:opmsapp/core/service/api/api_service.dart';
import 'package:opmsapp/core/service/connectivity/connectivity_service.dart';
import 'package:opmsapp/core/service/dialog/dialog_service.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:opmsapp/models/appointment_model/appointment_model.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/patient_model/patient_model.dart';

class ViewPatientAppointmentViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();
  final connectivityService = locator<ConnectivityService>();

  StreamSubscription? patientSub;
  List<AppointmentModel> patientListOfAppointments = [];

  @override
  void dispose() {
    patientSub?.cancel();
    super.dispose();
  }

  Future<void> getPatientAppointment({required dynamic patientId}) async {
    patientListOfAppointments =
        await apiService.getAppointmentsByPatient(patientId: patientId);
    notifyListeners();
  }

  void init({required dynamic patientId}) async {
    await Future.delayed(Duration(milliseconds: 300));
    dialogService.showDefaultLoadingDialog(
        willPop: false, barrierDismissible: false);
    if (await connectivityService.checkConnectivity()) {
      getPatientAppointment(patientId: patientId);
      navigationService.pop();
    } else {
      navigationService.pop();
      dialogService.showConfirmDialog(
          mainOptionTxt: 'Okay',
          willPop: false,
          barrierDismissible: false,
          title: 'Network Error'
              '',
          middleText: "Check your internet connection"
              " and try again.",
          onCancel: () {
            navigationService.pop();
          },
          onContinue: () {
            navigationService.pop();
          });
    }
  }

  void listenToAppointmentChanges({required dynamic patientId}) {
    apiService.listenToAppointmentChanges().listen((event) {
      patientSub?.cancel();
      patientSub =
          apiService.listenToAppointmentChanges().listen((event) async {
        await getPatientAppointment(patientId: patientId);
      });
    });
  }

  void addAppointment(Patient patient) {
    navigationService.pushNamed(Routes.CreateAppointmentView,
        arguments:
            CreateAppointmentViewArguments(patient: patient, popTimes: 2));
  }
}
