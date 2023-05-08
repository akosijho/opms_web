import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
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

  // Future<void> setGenderValue(
  //     TextEditingController textEditingController) async {
  //   String? selectedGender =
  //       await bottomSheetService.openBottomSheet(SelectionOption(
  //             options: SetupUserViewModel().genderOptions,
  //             title: 'Select gender',
  //           )) ??
  //           '';
  //   if (selectedGender != null) {
  //     textEditingController.text = selectedGender;
  //     notifyListeners();
  //   }
  // }
  Future<void> setGenderValue(TextEditingController textEditingController,
      BuildContext context) async {
    String? selectedGender = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          width: 300,
          child: AlertDialog(
            title: Text('Select Gender'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: SetupUserViewModel().genderOptions.map((gender) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop(gender);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        gender,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );

    if (selectedGender != null) {
      textEditingController.text = selectedGender;
      notifyListeners();
    }
  }

  // Future<void> setBirthDateValue(
  //     TextEditingController textEditingController) async {
  //   DateTime? birthDate =
  //       await bottomSheetService.openBottomSheet(SelectionDate(
  //     title: 'Select birth date',
  //   ));
  //   if (birthDate != null) {
  //     selectedBirthDate = birthDate;
  //     textEditingController.text =
  //         DateFormat.yMMMd().format(selectedBirthDate!);
  //     notifyListeners();
  //   }
  // }

  Future<void> setBirthDateValue(TextEditingController textEditingController,
      BuildContext context) async {
    DateTime? birthDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select Birth Date',
      cancelText: 'CANCEL',
      confirmText: 'SELECT',
      errorFormatText: 'Invalid date format',
      errorInvalidText: 'Invalid date',
      fieldLabelText: 'Birth date',
      fieldHintText: 'Month/Date/Year',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );

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
    final updatePatientQuery = await apiService.updatePatientInfo(
        patient: updatedPatient);
    if (updatePatientQuery.success) {
      navigationService.popRepeated(1);
      snackBarService.showSnackBar(
          message: 'Patient Info was updated', title: 'Success!');
    } else {
      navigationService.popUntilNamed(Routes.EditPatientView);
      snackBarService.showSnackBar(
          message: updatePatientQuery.errorMessage!, title: 'Network Error');
    }
  }

  void performUpdate(Patient patient) async {
    dialogService.showConfirmDialog(
        title: 'Update Patient Info',
        middleText:
        'Doing this action will update the patient information. Continue this action?',
        onCancel: () => navigationService.pop(),
        // onContinue: () async {
        //   // navigationService.pop();
        //   dialogService.showDefaultLoadingDialog();
        //   await updatePatient(patient);
        //   navigationService.popUntilNamed(Routes.PatientInfoView);
        //   snackBarService.showSnackBar(
        //       message: 'Patient Info was updated', title: 'Success!');
        // }
        onContinue: () => updatePatient(patient));
  }

}
