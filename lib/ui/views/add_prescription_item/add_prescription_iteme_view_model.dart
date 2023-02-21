import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:opmsapp/core/service/validator/validator_service.dart';
import 'package:opmsapp/models/prescription/prescription.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class AddPrescriptionItemViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();

  final prescriptionItemFormKey = GlobalKey<FormState>();
  final inscriptionTxtController = TextEditingController();
  final subscriptionTxtController = TextEditingController();
  final signaturaTxtController = TextEditingController();

  @override
  void dispose() {
    inscriptionTxtController.dispose();
    subscriptionTxtController.dispose();
    signaturaTxtController.dispose();
    super.dispose();
  }

  void returnPrescriptionItem() {
    if (prescriptionItemFormKey.currentState!.validate()) {
      navigationService.pop(
        returnValue: PrescriptionItem(
            inscription: inscriptionTxtController.text,
            subscription: subscriptionTxtController.text,
            signatura: signaturaTxtController.text),
      );
    }
  }
}
