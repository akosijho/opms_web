import 'dart:async';

import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/app/app.router.dart';
import 'package:opmsapp/core/service/api/api_service.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:opmsapp/core/service/pdf_service/pdf_service.dart';
import 'package:stacked/stacked.dart';

import '../../../core/service/dialog/dialog_service.dart';
import '../../../models/patient_model/patient_model.dart';
import '../../../models/prescription/prescription.dart';

class PrescriptionViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();
  final pdfService = locator<PdfService>();
  StreamSubscription? prescriptionSub;

  List<Prescription> prescriptionList = [];

  void goToAddPrescription(Patient patient) {
    navigationService.pushNamed(Routes.AddPrescriptionView,
        arguments: AddPrescriptionViewArguments(patient: patient));
  }

  Future<void> getPrescriptionList(dynamic patientId) async {
    final prescriptionL =
        await apiService.getPatientPrescription(patientId: patientId);

    dialogService.showDefaultLoadingDialog();
    await Future.delayed(Duration(milliseconds: 500));
    prescriptionList=prescriptionL;
    navigationService.pop();
    notifyListeners();
  }

  @override
  void dispose() {
    prescriptionSub?.cancel();
    super.dispose();
  }

  void listenToPrescriptionSub(dynamic patientId) {
    apiService.listenToPrescription(patientId).listen((event) {
      prescriptionSub?.cancel();
      prescriptionSub =
          apiService.listenToPrescription(patientId).listen((event) {
        getPrescriptionList(patientId);
      });
    });
  }

  void saveAndOpenPrescriptionDoc(
      {required Prescription prescription, required Patient patient}) async {
    final pdfPrescription = await pdfService.printPrescription(
        prescription: prescription, patient: patient);
    pdfService.savePdfFile(
        fileName: patient.fullName + '-Prescription-' + prescription.date,
        byteList: pdfPrescription);
  }
}
