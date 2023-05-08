import 'dart:io';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.logger.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/search_index/search_index.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/core/utility/image_selector.dart';
import 'package:opmswebstaff/models/medical_history/medical_history.dart';
import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:opmswebstaff/models/upload_results/medical_history_upload_result.dart';
import 'package:opmswebstaff/ui/views/main_body/main_body_view_model.dart';
import 'package:opmswebstaff/ui/views/update_user_info/setup_user_viewmodel.dart';
import 'package:opmswebstaff/ui/widgets/selection_date/selection_date.dart';
import 'package:opmswebstaff/ui/widgets/selection_list/selection_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class AddPatientViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();
  final imageSelectorService = locator<ImageSelector>();
  final logger = getLogger('AddPatientViewModel');
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final searchIndexService = locator<SearchIndexService>();

  bool isButtonClicked = false;
  bool haveAllergies = false;
  bool isMinor = false;
  // XFile? patientSelectedImage;
  String? tempGender;
  DateTime? tempBirthDate;
  List<XFile> listOfMedicalHistory = [];

  bool autoValidate = false;

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
  //   String selectedGender =
  //       await bottomSheetService.openBottomSheet(SelectionOption(
  //             options: SetupUserViewModel().genderOptions,
  //             title: 'Select gender',
  //           )) ??
  //           '';
  //   tempGender = selectedGender != '' ? selectedGender : tempGender ?? '';
  //   selectedGender = tempGender!;
  //   textEditingController.text = selectedGender;
  //   notifyListeners();
  // }

  Future<void> setGenderValue(TextEditingController textEditingController, BuildContext context) async {
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

    selectedGender = selectedGender ?? '';
    tempGender = selectedGender.isNotEmpty ? selectedGender : tempGender ?? '';
    selectedGender = tempGender!;
    textEditingController.text = selectedGender;
    notifyListeners();
  }

  // Future<void> setBirthDateValue(
  //     TextEditingController textEditingController) async {
  //   DateTime? selectedBirthDate =
  //       await bottomSheetService.openBottomSheet(SelectionDate(
  //     title: 'Select birth date',
  //   ));
  //   tempBirthDate =
  //       selectedBirthDate != null ? selectedBirthDate : tempBirthDate;
  //   selectedBirthDate = tempBirthDate!;
  //   textEditingController.text = DateFormat.yMMMd().format(selectedBirthDate);
  //   ;
  //   notifyListeners();
  // }
  // Future<void> setBirthDateValue(TextEditingController textEditingController, BuildContext context) async {
  //   DateTime? selectedBirthDate = await showDialog<DateTime>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 250,
  //         width: 300,
  //         child: AlertDialog(
  //           title: Text('Select Birth Date'),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               SizedBox(height: 16),
  //               InkWell(
  //                 onTap: () {
  //                   Navigator.of(context).pop(DateTime.now());
  //                 },
  //                 child: Text(
  //                   'Today',
  //                   style: TextStyle(fontSize: 16),
  //                 ),
  //               ),
  //               SizedBox(height: 8),
  //               Divider(),
  //               SizedBox(height: 8),
  //               ElevatedButton(
  //                 onPressed: () async {
  //                   DateTime? pickedDate = await showDatePicker(
  //                     context: context,
  //                     initialDate: DateTime.now(),
  //                     firstDate: DateTime(1900),
  //                     lastDate: DateTime.now(),
  //                   );
  //                   if (pickedDate != null) {
  //                     Navigator.of(context).pop(pickedDate);
  //                   }
  //                 },
  //                 child: Text('Select Date'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //
  //   tempBirthDate = selectedBirthDate ?? tempBirthDate;
  //   selectedBirthDate = tempBirthDate!;
  //   textEditingController.text = DateFormat.yMMMd().format(selectedBirthDate);
  //   notifyListeners();
  // }
  Future<void> setBirthDateValue(TextEditingController textEditingController, BuildContext context) async {
    DateTime? selectedBirthDate = await showDatePicker(
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

    tempBirthDate = selectedBirthDate ?? tempBirthDate;
    selectedBirthDate = tempBirthDate!;
    textEditingController.text = DateFormat.yMMMd().format(selectedBirthDate);
    notifyListeners();
  }

  // Future<void> selectPatientImage() async {
  //   dynamic tempImage;
  //   var selectedImageSource =
  //       await bottomSheetService.openBottomSheet(SelectionOption(
  //     options: SetupUserViewModel().imageSourceOptions,
  //     title: 'Select Image Source',
  //   ));
  //   //Condition to select Image Source
  //   if (selectedImageSource == SetupUserViewModel().imageSourceOptions[0]) {
  //     tempImage = await imageSelectorService.selectImageWithGallery();
  //   } else if (selectedImageSource ==
  //       SetupUserViewModel().imageSourceOptions[1]) {
  //     tempImage = await imageSelectorService.selectImageWithCamera();
  //   }
  //   if (tempImage != null) {
  //     patientSelectedImage = tempImage;
  //     setBusy(false);
  //     logger.i('image selected');
  //   }
  //   imageCache.clear();
  //   logger.i('image cache cleared');
  // }

  // Future<void> setBirthDateValue(TextEditingController textEditingController, BuildContext context) async {
  //   DateTime? selectedBirthDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //     builder: (BuildContext context, Widget? child) {
  //       return AlertDialog(
  //         title: Text('Select Birth Date'),
  //         content: SizedBox(
  //           height: 250,
  //           width: 300,
  //           child: child,
  //         ),
  //       );
  //     },
  //   );
  //
  //   tempBirthDate = selectedBirthDate ?? tempBirthDate;
  //   selectedBirthDate = tempBirthDate!;
  //   textEditingController.text = DateFormat.yMMMd().format(selectedBirthDate);
  //   notifyListeners();
  // }


  Future<void> savePatient({
    required String firstName,
    required String lastName,
    required String gender,
    required String birthDate,
    required String phoneNum,
    required String address,
    required String allergies,
    String? notes,
    String? emergencyContactName,
    String? emergencyContactNumber,
  }) async {
    // if (patientSelectedImage != null) {
      final patientRef = await apiService.createPatientID();
    //   dialogService.showDefaultLoadingDialog(barrierDismissible: false);
      // final imageUploadResult = await apiService.uploadPatientProfileImage(
      //     patientId: patientRef.id,
      //     imageToUpload: File(patientSelectedImage!.path));

      final medHistoryUploadResult = await uploadMedicalHistory(
          patientId: patientRef.id, listOfMedicalHistory: listOfMedicalHistory);

      if (medHistoryUploadResult.isUploaded) {
        final patientSearchIndex = await searchIndexService.setSearchIndex(
            string: '$firstName $lastName');
        final result = await apiService.addPatient(
          patientRef: patientRef,
          patient: Patient(
            // image: imageUploadResult.imageUrl ?? '',
              firstName: firstName,
              lastName: lastName,
              gender: gender,
              birthDate: birthDate,
              phoneNum: phoneNum,
              address: address,
              allergies: allergies,
              emergencyContactNumber: emergencyContactNumber ?? '',
              emergencyContactName: emergencyContactName ?? '',
              searchIndex: patientSearchIndex,
              notes: notes ?? ''),
        );

        if (result == null) {
          navigationService.closeOverlay();
          MainBodyViewModel().setSelectedIndex(2);
          navigationService.pop();
          snackBarService.showSnackBar(
              title: 'Success', message: 'New Patient Added!');
          logger.v('patient details saved');
        } else {
          navigationService.closeOverlay();
          snackBarService.showSnackBar(
              title: 'Error',
              message: "There's an error encountered with adding new patient!");
        }
      } else {
        navigationService.closeOverlay();
        snackBarService.showSnackBar(
            title: 'Error',
            message: "There's an error encountered with adding new patient!");
      }
    }
    // } else {
    //   snackBarService.showSnackBar(
    //       message: 'Patient profile image is not set',
    //       title: 'Missing required Data');
    // }
  // }

  void selectMedicalHistoryFile() async {
    dynamic tempImage;
    var selectedImageSource =
        await bottomSheetService.openBottomSheet(SelectionOption(
      options: SetupUserViewModel().imageSourceOptions,
      title: 'Get Medical History From',
    ));

    if (selectedImageSource == SetupUserViewModel().imageSourceOptions[0]) {
      tempImage = await imageSelectorService.selectImageWithGallery();
    } else if (selectedImageSource ==
        SetupUserViewModel().imageSourceOptions[1]) {
      tempImage = await imageSelectorService.selectImageWithCamera();
    }
    if (tempImage != null) {
      listOfMedicalHistory.add(tempImage);
      notifyListeners();
    }
  }

  void selectMedicalHistFile(BuildContext context) async {
    // await documentScannerService.scanImageToPDF(context);
  }

  Future<MedHistoryUploadResult> uploadMedicalHistory(
      {required patientId, required List<XFile> listOfMedicalHistory}) async {
    List<MedicalHistory> medHistory = [];

    try {
      for (final e in listOfMedicalHistory) {
        final imageUploadResult = await apiService.uploadMedicalHistoryPhoto(
            patientId: patientId,
            imageToUpload: File(e.path),
            fileName: e.name);
        if (imageUploadResult.isUploaded) {
          medHistory.add(MedicalHistory(
              id: imageUploadResult.imageFileName,
              date: DateFormat.yMMMd().format(DateTime.now()),
              image: imageUploadResult.imageUrl));
          notifyListeners();
        }
        debugPrint('uploading ${e.path}');
      }
      return MedHistoryUploadResult.success(medHistory: medHistory);
    } catch (e) {
      debugPrint(e.toString());
      return MedHistoryUploadResult.failed(message: 'Something went wrong');
    }
  }
}
