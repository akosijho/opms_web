import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/pdf_service/pdf_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opmswebstaff/models/optical_certificate/optical_certificate.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:stacked/stacked.dart';

import '../../../core/service/validator/validator_service.dart';
import '../../../models/patient_model/patient_model.dart';
import '../../widgets/selection_date/selection_date.dart';

class AddCertificateViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final pdfService = locator<PdfService>();
  final bottomSheetService = locator<BottomSheetService>();
  final validatorService = locator<ValidatorService>();
  final dialogService = locator<DialogService>();
  final snackBarService = locator<SnackBarService>();

  final addCertificateFormKey = GlobalKey<FormState>();
  final dateTextController =
      TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));
  final serviceTextController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  void selectService() async {
    final Service? service =
        await navigationService.pushNamed(Routes.SelectionService);
    if (service != null) {
      serviceTextController.text = service.serviceName;
      notifyListeners();
    }
  }

  void selectDate() async {
    final DateTime? date =
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

  void saveOpticalCertificate(Patient patient) async {
    if (addCertificateFormKey.currentState!.validate()) {
      dialogService.showDefaultLoadingDialog();

      final cert = OpticalCertificate(
        service: serviceTextController.text,
        date: selectedDate.toString(),
      );

      final addCertQuery = await apiService.addOpticalCertificate(
        opticalCertificate: cert,
        patient: patient,
      );

      if (addCertQuery.success) {
        navigationService.popRepeated(2);
        snackBarService.showSnackBar(
          message: 'Certificate Added. Open it now!',
          title: 'Success',
        );

        final pdf = await pdfService.printOpticalCertificate(
          opticalCertificate: cert,
          patient: patient,
        );

        pdfService.savePdfFile(
          // fileName: '${patient.fullName}-Certificate-${cert.date}',
          byteList: pdf,
        );
      } else {
        navigationService.pop();
        snackBarService.showSnackBar(
          message: addCertQuery.errorMessage!,
          title: 'Network Error',
        );
      }
    }
  }

}
