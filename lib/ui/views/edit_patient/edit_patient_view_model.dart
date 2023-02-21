import 'package:opmsapp/app/app.router.dart';
import 'package:opmsapp/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../core/service/api/api_service.dart';
import '../../../core/service/bottom_sheet/bottom_sheet_service.dart';
import '../../../core/service/dialog/dialog_service.dart';
import '../../../core/service/navigation/navigation_service.dart';
import '../../../core/service/search_index/search_index.dart';
import '../../../core/service/snack_bar/snack_bar_service.dart';
import '../../../core/service/validator/validator_service.dart';
import '../../../core/utility/image_selector.dart';
import '../../../models/patient_model/patient_model.dart';
import '../../widgets/selection_date/selection_date.dart';
import '../../widgets/selection_list/selection_option.dart';
import '../update_user_info/setup_user_viewmodel.dart';

class EditPatientViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();
  final imageSelectorService = locator<ImageSelector>();
  final logger = getLogger('AddPatientViewModel');
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final searchIndexService = locator<SearchIndexService>();

  final addPatientFormKey = GlobalKey<FormState>();
  final firstNameTxtController = TextEditingController();
  final lastNameTxtController = TextEditingController();
  final genderTxtController = TextEditingController();
  final birthDateTxtController = TextEditingController();
  final phoneTxtController = TextEditingController();
  final addressTxtController = TextEditingController();
  final allergyTxtController = TextEditingController();
  final noteTxtController = TextEditingController();
  final emergencyContactNameTxtController = TextEditingController();
  final emergencyContactNumberTxtController = TextEditingController();

  bool haveAllergies = false;
  XFile? patientSelectedImage;
  String gender = '';
  DateTime? selectedBirthDate;

  @override
  void dispose() {
    firstNameTxtController.dispose();
    lastNameTxtController.dispose();
    genderTxtController.dispose();
    birthDateTxtController.dispose();
    phoneTxtController.dispose();
    addressTxtController.dispose();
    allergyTxtController.dispose();
    noteTxtController.dispose();
    emergencyContactNameTxtController.dispose();
    emergencyContactNumberTxtController.dispose();
    super.dispose();
  }

  void init(Patient patient) {
    firstNameTxtController.text = patient.firstName;
    lastNameTxtController.text = patient.lastName;
    genderTxtController.text = patient.gender;
    birthDateTxtController.text =
        DateFormat.yMMMd().format(patient.birthDate.toDateTime()!);
    phoneTxtController.text = patient.phoneNum;
    addressTxtController.text = patient.address;
    allergyTxtController.text = patient.allergies ?? '';
    noteTxtController.text = patient.notes;
    emergencyContactNameTxtController.text = patient.emergencyContactName ?? '';
    emergencyContactNumberTxtController.text =
        patient.emergencyContactNumber ?? '';
    selectedBirthDate = patient.birthDate.toDateTime()!;
    if (allergyTxtController.text.isNotEmpty) {
      haveAllergies = true;
      notifyListeners();
    }
    notifyListeners();
  }

  void setAllergyVisibility(bool value) {
    if (haveAllergies) {
      haveAllergies = false;
    } else {
      haveAllergies = true;
    }
    notifyListeners();
  }

  Future<void> setGenderValue(
      TextEditingController textEditingController) async {
    String? selectedGender =
        await bottomSheetService.openBottomSheet(SelectionOption(
              options: SetupUserViewModel().genderOptions,
              title: 'Select gender',
            )) ??
            '';
    if (selectedGender != null) {
      textEditingController.text = selectedGender;
      notifyListeners();
    }
  }

  Future<void> setBirthDateValue(
      TextEditingController textEditingController) async {
    DateTime? birthDate =
        await bottomSheetService.openBottomSheet(SelectionDate(
      title: 'Select birth date',
    ));
    if (birthDate != null) {
      selectedBirthDate = birthDate;
      textEditingController.text =
          DateFormat.yMMMd().format(selectedBirthDate!);
      notifyListeners();
    }
  }

  Future<void> updatePatient(Patient patient) async {
    final patientSearchIndex = await searchIndexService.setSearchIndex(
        string: '${firstNameTxtController.text} ${lastNameTxtController.text}');

    final updatedPatient = Patient(
      id: patient.id,
      dateCreated: patient.dateCreated,
      firstName: firstNameTxtController.text,
      lastName: lastNameTxtController.text,
      gender: genderTxtController.text,
      image: patient.image,
      birthDate: selectedBirthDate.toString(),
      phoneNum: phoneTxtController.text,
      address: addressTxtController.text,
      allergies: allergyTxtController.text,
      searchIndex: patientSearchIndex,
      emergencyContactName: emergencyContactNameTxtController.text,
      emergencyContactNumber: emergencyContactNumberTxtController.text,
      notes: noteTxtController.text,
    );
    apiService.updatePatientInfo(patient: updatedPatient);
  }

  void performUpdate(Patient patient) async {
    dialogService.showConfirmDialog(
        title: 'Update Patient Info',
        middleText:
            'Doing this action will update the patient information. Continue this action?',
        onCancel: () => navigationService.pop(),
        onContinue: () async {
          navigationService.pop();
          dialogService.showDefaultLoadingDialog();
          await updatePatient(patient);
          navigationService.popUntilNamed(Routes.PatientInfoView);
          snackBarService.showSnackBar(
              message: 'Patient Info was updated', title: 'Success!');
        });
  }
}
