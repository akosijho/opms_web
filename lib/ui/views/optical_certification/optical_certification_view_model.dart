import 'dart:async';
import 'dart:typed_data';

import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/pdf_service/pdf_service.dart';
import 'package:opmswebstaff/models/optical_certificate/optical_certificate.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/dialog/dialog_service.dart';
import '../../../models/patient_model/patient_model.dart';
import 'package:pdf/widgets.dart' as pw;


class OpticalCertification extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();
  final pdfService = locator<PdfService>();
  StreamSubscription? certSub;

  List<OpticalCertificate> opticalCertificates = [];

  void goToAddCertificate(Patient patient) async {
    navigationService.pushNamed(Routes.AddCertificateView,
        arguments: AddCertificateViewArguments(patient: patient));
  }

  @override
  void dispose() {
    certSub?.cancel();
    super.dispose();
  }

  void getOpticalCertificates({required Patient patient}) async {
    final cert = await apiService.getOpticalCert(patient: patient);
    dialogService.showDefaultLoadingDialog();
    await Future.delayed(Duration(milliseconds: 300));
    opticalCertificates.clear();
    opticalCertificates.addAll(cert);
    navigationService.pop();
    notifyListeners();
  }

  void listenToGetOpticalCert({required Patient patient}) {
    apiService.listenToOpticalCertChanges(patient: patient).listen((event) {
      certSub?.cancel();
      certSub = apiService
          .listenToOpticalCertChanges(patient: patient)
          .listen((event) {
        getOpticalCertificates(patient: patient);
      });
    });
  }

  void openCertificate(
      {required OpticalCertificate certificate,
      required Patient patient}) async {
    final pdf = await pdfService.printOpticalCertificate(
        opticalCertificate: certificate, patient: patient);

    pdfService.savePdfFile(
        // fileName: patient.fullName + '-Certificate-' + certificate.date,
        byteList: pdf);
  }
}
