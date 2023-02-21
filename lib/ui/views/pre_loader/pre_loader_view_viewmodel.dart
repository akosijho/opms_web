import 'dart:async';

import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/app/app.router.dart';
import 'package:opmsapp/core/service/connectivity/connectivity_service.dart';
import 'package:opmsapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:opmsapp/core/service/session_service/session_service.dart';
import 'package:opmsapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';

class PreLoaderViewModel extends BaseViewModel {
  final sessionService = locator<SessionService>();
  final navigationService = locator<NavigationService>();
  final connectivityService = locator<ConnectivityService>();
  final snackBarService = locator<SnackBarService>();
  final firebaseAuthService = locator<FirebaseAuthService>();
  bool hasConnection = false;
  StreamSubscription? connectivitySub;

  // Future<dynamic> checkInternet() async {
  //   hasConnection = await connectivityService.checkConnectivity();
  //   notifyListeners();
  //   if (hasConnection) {
  //     getSessionInfo();
  //   } else {
  //     snackBarService.showSnackBar(
  //         message: 'No Internet Connection, Retrying...');
  //     return this;
  //   }
  // }

  void listenToConnectivityChanges() {
    connectivitySub =
        InternetConnectionChecker().onStatusChange.listen((event) async {
      if (event == InternetConnectionStatus.connected) {
        await getSessionInfo();
      } else {
        snackBarService.showSnackBar(
            message: 'No Internet Connection, Retrying...');
      }
    });
  }

  @override
  void dispose() {
    connectivitySub?.cancel();
    super.dispose();
  }

  Future<void> getSessionInfo() async {
    final sessionInfo = await sessionService.getSession();

    await Future.delayed(Duration(seconds: 1));
    if (sessionInfo.isRunFirstTime) {
      navigationService.popAllAndPushNamed(Routes.GetStarted);
    } else if (!sessionInfo.isRunFirstTime && !sessionInfo.isLoggedIn) {
      navigationService.popAllAndPushNamed(Routes.Login);
    } else if (!sessionInfo.isRunFirstTime &&
        sessionInfo.isLoggedIn &&
        !sessionInfo.isAccountSetupDone) {
      navigationService.popAllAndPushNamed(Routes.Login);
    } else if (!sessionInfo.isRunFirstTime &&
        sessionInfo.isLoggedIn &&
        sessionInfo.isAccountSetupDone) {
      final reLoginSuccess = await firebaseAuthService.reLoad();

      if (reLoginSuccess) {
        navigationService.popAllAndPushNamed(Routes.MainBodyView);
      } else {
        snackBarService.showSnackBar(
            message: 'Login Error. Check Internet Connection. Try Again.',
            title: 'Error');
      }
    }
  }
}
