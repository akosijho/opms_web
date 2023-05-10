
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/navigation/navigation_service.dart';

class BottomNavigationModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final fAuthService = locator<FirebaseAuthService>();

  void goToHome() {
    navigationService.pushNamed(Routes.HomePageView);
  }
  void goToAppointment() {
    navigationService.pushNamed(Routes.AppointmentView);
  }
  void goToPatients() {
    navigationService.pushNamed(Routes.PatientsView);
  }

  void goToService() {
    navigationService.pushNamed(Routes.ServicesView);
  }
  void goToProduct() {
    navigationService.pushNamed(Routes.FrameLensView);
  }


  void logOut() {
    dialogService.showConfirmDialog(
        onCancel: () {
          navigationService.pop();
        },
        middleText:
        'This action wil log out your account from the app. Are you sure to continue?',
        title: 'Logout',
        mainOptionTxt: 'Logout',
        onContinue: () async {
          await fAuthService.logOut();
          navigationService.popAllAndPushNamed(Routes.Login);
        });
  }
}
