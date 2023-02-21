import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/app/app.logger.dart';
import 'package:opmsapp/app/app.router.dart';
import 'package:opmsapp/core/service/api/api_service.dart';
import 'package:opmsapp/core/service/dialog/dialog_service.dart';
import 'package:opmsapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:opmsapp/core/service/firebase_messaging/firebase_messaging_service.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:opmsapp/core/service/session_service/session_service.dart';
import 'package:opmsapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmsapp/core/service/validator/validator_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import 'register_view.form.dart';

class RegisterViewModel extends FormViewModel {
  //services
  final navigationService = locator<NavigationService>();
  final firebaseAuthService = locator<FirebaseAuthService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final validatorService = locator<ValidatorService>();
  final log = getLogger('RegisterViewModel');
  final sessionService = locator<SessionService>();
  final apiService = locator<ApiService>();
  final fcmService = locator<FirebaseMessagingService>();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  bool isObscure = false;
  bool isShowIconVisible = false;
  bool autoValidate = false;

  void goToLogin() {
    navigationService.pop();
  }

  void registerAccount() async {
    if (emailValue != null && passwordValue != null) {
      dialogService.showDefaultLoadingDialog();
      final authResponse = await firebaseAuthService.signUpWithEmail(
          email: emailValue!, password: passwordValue!);
      if (authResponse.success) {
        navigationService.closeOverlay();
        firebaseAuthService.sendEmailVerification();
        sessionService.saveSession(
            isRunFirstTime: false, isLoggedIn: true, isAccountSetupDone: false);
        navigationService.pushReplacementNamed(Routes.SetUpUserView);
        final notificationToken = await fcmService.saveFcmToken();
        await apiService.saveUserFcmToken(notificationToken);
      } else {
        Get.back(canPop: false);
        snackBarService.showSnackBar(
            title: 'Error', message: authResponse.errorMessage!);
      }
    }
  }

  void showHidePassword() {
    if (isObscure == true) {
      isObscure = false;
      notifyListeners();
    } else {
      isObscure = true;
      notifyListeners();
    }
  }

  void setShowIconVisibility() {
    if (hasPassword) {
      if (passwordValue != null && passwordValue!.length > 0) {
        isShowIconVisible = true;
        notifyListeners();
      } else {
        isShowIconVisible = false;
        notifyListeners();
      }
    }
  }

  void setAutoValidate() {
    autoValidate = true;
    notifyListeners();
  }

  @override
  void setFormStatus() {}
}
