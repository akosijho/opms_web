import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.logger.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/session_service/session_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/service/firebase_messaging/firebase_messaging_service.dart';

class LoginViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final firebaseAuthService = locator<FirebaseAuthService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final apiService = locator<ApiService>();
  final sessionService = locator<SessionService>();
  final toastService = locator<ToastService>();
  final fcmService = locator<FirebaseMessagingService>();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final logger = getLogger('LoginViewModel');
  bool autoValidate = false;
  bool isObscure = true;
  bool isShowIconVisible = false;

  Future<void> loginNow(
      {required String emailValue, required String passwordValue}) async {
    if (loginFormKey.currentState!.validate()) {
      dialogService.showDefaultLoadingDialog(
          barrierDismissible: false, willPop: false);

      var loginResult = await firebaseAuthService.loginWithEmail(
          email: emailValue.trim(), password: passwordValue);

      if (loginResult != null) {
        if (loginResult.success) {
          final isAccountSetupDone = await apiService.checkUserStatus();
          sessionService.saveSession(
              isRunFirstTime: false,
              isLoggedIn: true,
              isAccountSetupDone: isAccountSetupDone);
          logger.i('Checking User Account Details');
          if (isAccountSetupDone) {
            navigationService.popAllAndPushNamed(Routes.MainBodyView);
            final notificationToken = await fcmService.saveFcmToken();
            await apiService.saveUserFcmToken(notificationToken);
          } else {
            navigationService.popAllAndPushNamed(Routes.SetUpUserView);
            final notificationToken = await fcmService.saveFcmToken();
            await apiService.saveUserFcmToken(notificationToken);
          }
        } else {
          navigationService.closeOverlay();
          toastService.showToast(message: loginResult.errorMessage ?? '');
        }
      } else {
        setAutoValidate();
      }
    }
  }

  void goToRegisterView() {
    navigationService.pushNamed(Routes.Register);
  }

  void setAutoValidate() {
    autoValidate = true;
    notifyListeners();
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

  void setShowIconVisibility(String passwordValue) {
    if (passwordValue.length > 0) {
      isShowIconVisible = true;
      notifyListeners();
    } else {
      isShowIconVisible = false;
      notifyListeners();
    }
  }
  // void listenToConnectivityChanges() {
  //   connectivitySub =
  //       InternetConnectionChecker().onStatusChange.listen((event) async {
  //         if (event == InternetConnectionStatus.connected) {
  //           await getSessionInfo();
  //         } else {
  //           snackBarService.showSnackBar(
  //               message: 'No Internet Connection, Retrying...');
  //         }
  //       });
  // }

  @override
  void setFormStatus() {}

  Future<void> loginWithGoogle() async {
    var loginResult = await firebaseAuthService.loginWithGoogle();
    if (loginResult != null) {
      if (loginResult.success) {
        final isAccountSetupDone = await apiService.checkUserStatus();
        sessionService.saveSession(
          isRunFirstTime: false,
          isLoggedIn: true,
          isAccountSetupDone: isAccountSetupDone,
        );
        logger.i('Checking User Account Details');
        if (isAccountSetupDone) {
          navigationService.popAllAndPushNamed(Routes.MainBodyView);
          final notificationToken = await fcmService.saveFcmToken();
          await apiService.saveUserFcmToken(notificationToken);
        } else {
          navigationService.popAllAndPushNamed(Routes.SetUpUserView,
              arguments: SetUpUserViewArguments(
                firstName: loginResult.user?.displayName ?? '',
                userPhoto: loginResult.user?.photoURL ?? '',
              ));
          final notificationToken = await fcmService.saveFcmToken();
          await apiService.saveUserFcmToken(notificationToken);
        }
      } else {
        navigationService.closeOverlay();
        toastService.showToast(message: loginResult.errorMessage ?? '');
      }
    }
  }
}
