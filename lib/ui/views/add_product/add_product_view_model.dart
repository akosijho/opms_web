import 'dart:io';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/models/medicine/medicine.dart';
import 'package:opmswebstaff/ui/views/update_user_info/setup_user_viewmodel.dart';
import 'package:opmswebstaff/ui/widgets/selection_list/selection_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class AddProductViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final apiService = locator<ApiService>();
  final toastService = locator<ToastService>();
  final dialogService = locator<DialogService>();
  final bottomSheetService = locator<BottomSheetService>();

  XFile? selectedImage;

  Future<void> addMedicine(
      {required String medicineName, String? brandName, String? price}) async {
    setBusy(true);
    try {
      dialogService.showDefaultLoadingDialog(barrierDismissible: true);
      final imageUrl = await uploadMedicineImage(genericName: medicineName);
      if (imageUrl != null) {
        await apiService.addProduct(
            product: Product(
                productName: medicineName,
                brandName: brandName,
                price: price ?? ''),
            image: imageUrl);
      }

      setBusy(false);
      navigationService.closeOverlay();
      navigationService.pop();
      toastService.showToast(message: 'Medicine Added');
    } catch (e) {
      await apiService.addProduct(
        product: Product(
            productName: medicineName,
            brandName: brandName,
            price: price ?? ''),
      );

      setBusy(false);
      navigationService.closeOverlay();
      navigationService.pop();
      toastService.showToast(message: 'Medicine Added');
    }
  }

  Future<void> selectImage() async {
    dynamic tempImage;
    var selectedImageSource =
        await bottomSheetService.openBottomSheet(SelectionOption(
      options: SetupUserViewModel().imageSourceOptions,
      title: 'Select Image Source',
    ));

    //Condition to select Image Source
    if (selectedImageSource == SetupUserViewModel().imageSourceOptions[0]) {
      tempImage = await SetupUserViewModel()
          .imageSelectorService
          .selectImageWithGallery();
    } else if (selectedImageSource ==
        SetupUserViewModel().imageSourceOptions[1]) {
      tempImage = await SetupUserViewModel()
          .imageSelectorService
          .selectImageWithCamera();
    }

    if (tempImage != null) {
      selectedImage = tempImage;

      setBusy(false);
    }
    imageCache.clear();
  }

  Future<String?> uploadMedicineImage({required String genericName}) async {
    final uploadResult = await apiService.uploadProductImage(
        imageToUpload: File(selectedImage!.path), genericName: genericName);
    if (uploadResult.isUploaded) {
      return uploadResult.imageUrl!;
    } else {
      return null;
    }
  }
}
