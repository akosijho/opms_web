import 'dart:io';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.logger.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/search_index/search_index.dart';
import 'package:opmswebstaff/core/service/session_service/session_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/core/utility/image_selector.dart';
import 'package:opmswebstaff/models/user_model/user_model.dart';
import 'package:opmswebstaff/ui/widgets/selection_date/selection_date.dart';
import 'package:opmswebstaff/ui/widgets/selection_list/selection_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SetupUserViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();
  final imageSelectorService = locator<ImageSelector>();
  final logger = getLogger('SetupUserViewModel');
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final sessionService = locator<SessionService>();
  final searchIndexService = locator<SearchIndexService>();
  final firebaseAuthService = locator<FirebaseAuthService>();
  final setupFormKey = GlobalKey<FormState>();

  final List<String> genderOptions = ['Male', 'Female'];
  final List<String> positionOptions = ['Doctor', 'Staff'];
  final List<String> imageSourceOptions = ['Gallery', 'Camera'];
  XFile? selectedImage;

  String? tempGender;
  DateTime? selectedBirthDate;
  String selectedGender = '';

  Future<void> setGenderValue(
      TextEditingController textEditingController) async {
    selectedGender = await bottomSheetService.openBottomSheet(SelectionOption(
          options: genderOptions,
          title: 'Select your gender',
        )) ??
        '';
    tempGender = selectedGender != '' ? selectedGender : tempGender ?? '';
    selectedGender = tempGender!;
    textEditingController.text = selectedGender;
    notifyListeners();
  }

  String? tempPosition;

  Future<void> setPositionValue(
      TextEditingController textEditingController) async {
    String selectedPosition =
        await bottomSheetService.openBottomSheet(SelectionOption(
              options: positionOptions,
              title: 'Select your position',
            )) ??
            '';
    tempPosition =
        selectedPosition != '' ? selectedPosition : tempPosition ?? '';
    selectedPosition = tempPosition!;
    textEditingController.text = selectedPosition;
    notifyListeners();
  }

  DateTime? tempBirthDate;

  Future<void> setBirthDateValue(
      TextEditingController textEditingController) async {
    selectedBirthDate = await bottomSheetService.openBottomSheet(SelectionDate(
          title: 'Select birth date',
        )) ??
        '';
    tempBirthDate =
        selectedBirthDate != null ? selectedBirthDate : tempBirthDate;
    selectedBirthDate = tempBirthDate!;
    textEditingController.text = DateFormat.yMMMd().format(selectedBirthDate!);
    debugPrint('Selected Date is $tempBirthDate');
    notifyListeners();
  }

  Future<void> selectImageSource() async {
    dynamic tempImage;
    var selectedImageSource =
        await bottomSheetService.openBottomSheet(SelectionOption(
      options: imageSourceOptions,
      title: 'Select Image Source',
    ));

    //Condition to select Image Source
    if (selectedImageSource == imageSourceOptions[0]) {
      tempImage = await imageSelectorService.selectImageWithGallery();
    } else if (selectedImageSource == imageSourceOptions[1]) {
      tempImage = await imageSelectorService.selectImageWithCamera();
    }

    if (tempImage != null) {
      selectedImage = tempImage;

      setBusy(false);
      logger.i('image selected');
    }
    imageCache.clear();
    logger.i('image cache cleared');
  }

  Future<void> saveUser(String firstName, String lastName, String dateOfBirth,
      String gender, String position, String phoneNum) async {
    dialogService.showDefaultLoadingDialog(barrierDismissible: false);
    await firebaseAuthService.reLoad();

    final imageUploadResult = await apiService.uploadProfileImage(
        imageToUpload: File(selectedImage!.path),
        imageFileName: selectedImage!.name);
    logger.i('image uploading');

    try {
      if (imageUploadResult.isUploaded) {
        logger.i('Image Uploaded');
        final userSearchIndex = await searchIndexService.setSearchIndex(
            string: '$firstName $lastName');
        final userProfile = UserModel(
          apiService.currentFirebaseUser!.uid,
          firstName: firstName,
          lastName: lastName,
          email: apiService.currentFirebaseUser!.email!,
          image: imageUploadResult.imageUrl ?? 'd',
          position: position,
          appointments: [],
          fcmToken: [],
          searchIndex: userSearchIndex,
          gender: gender,
          dateOfBirth: dateOfBirth,
          active_status: 'active',
          phoneNum: phoneNum,
        );
        await apiService.createUser(userProfile);
        navigationService.closeOverlay();
        sessionService.saveSession(
            isRunFirstTime: false, isLoggedIn: true, isAccountSetupDone: true);
        navigationService.popAllAndPushNamed(Routes.Success);
        logger.i('User Created Successfully');
      } else {
        navigationService.closeOverlay();
        logger.e('Upload Image Failed');
        snackBarService.showSnackBar(
            title: 'Error', message: imageUploadResult.message!);
      }
    } catch (e) {
      snackBarService.showSnackBar(
          title: 'Error',
          message:
              "There's an error encountered on our end. Please try again later.");
    }
  }
}
