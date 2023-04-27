import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.logger.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/connectivity/connectivity_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/enums/appointment_status.dart';
import 'package:opmswebstaff/models/appointment_model/appointment_model.dart';
import 'package:opmswebstaff/models/notification/notification_model.dart';
import 'package:opmswebstaff/models/user_model/user_model.dart';
import 'package:opmswebstaff/ui/views/add_expenses/add_expenses_view.dart';
import 'package:opmswebstaff/ui/views/appointment/appointment_view.dart';
import 'package:opmswebstaff/ui/views/finance/reports_view.dart';
import 'package:opmswebstaff/ui/views/home/home_view.dart';
import 'package:opmswebstaff/ui/views/medicine/medicine_view.dart';
import 'package:opmswebstaff/ui/views/patients/patients_view.dart';
import 'package:opmswebstaff/ui/views/payment_select_patient/payment_select_patient_view.dart';
import 'package:opmswebstaff/ui/views/procedures/procedure_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton(asType: MainBodyViewModel)
class MainBodyViewModel extends BaseViewModel {
  int selectedIndex = 0;
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackBarService>();

  final List<Widget> widget = [
    HomePageView(),
    AppointmentView(),
    PatientsView(),
    ProceduresView(),
    MedicineView(),
    PaymentSelectPatientView(),
    AddExpenseView(),
    // PatientReportView(showAppBar: true)
    ReportView()
  ];

  void setSelectedIndex(int index) {
    selectedIndex = index;
    print(selectedIndex);
    notifyListeners();
  }
  final logger = getLogger('AppointmentModel', printCallingFunctionName: true);
  final dialogService = locator<DialogService>();
  // final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final fAuthService = locator<FirebaseAuthService>();
  final toastService = locator<ToastService>();
  final bottomSheetService = locator<BottomSheetService>();
  // final connectivityService = locator<ConnectivityService>();
  // final snackBarService = locator<SnackBarService>();

  StreamSubscription? userSubscription;
  StreamSubscription? appointmentSubscription;
  UserModel? currentUser;
  List<AppointmentModel> myAppointments = [];
  StreamSubscription? notifSub;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  List<NotificationModel> notifications = [];
  int notificationCount = 0;

  Future<void> init() async {
    setBusy(true);
    getCurrentUser();
    getNotifications();
    listenToNotificationChanges();
    setBusy(false);
  }

  @override
  void dispose() {
    userSubscription?.cancel();
    super.dispose();
  }

  void computeTotalNotif() {
    notificationCount = 0;
    for (NotificationModel notif in notifications) {
      if (notif.isRead == false) {
        notificationCount += 1;
        notifyListeners();
      }
    }
    notifyListeners();
  }

  void listenToNotificationChanges() {
    apiService.listenToNotificationChanges(userId: userId).listen((event) {
      notifSub?.cancel();
      notifSub = apiService
          .listenToNotificationChanges(userId: userId)
          .listen((event) {
        getNotifications();
      });
    });
  }

  Future<void> getNotifications() async {
    final notif = await apiService.getNotification(userId: userId);
    if (notif != null) {
      notifications.clear();
      notifications.addAll(notif);
      notifyListeners();
      computeTotalNotif();
    }
  }

  void getCurrentUser() {
    apiService.getUserAccountDetails().listen((event) async {
      userSubscription =
          apiService.getUserAccountDetails().listen((user) async {
            await Future.delayed(Duration(milliseconds: 500));
            dialogService.showDefaultLoadingDialog();
            currentUser = user;
            await Future.delayed(Duration(milliseconds: 500));
            navigationService.pop();
            notifyListeners();
          });
    });
  }

  void logOut() async {
    dialogService.showConfirmDialog(
        onCancel: () {
          navigationService.pop();
        },
        middleText:
        'This action will lets you log out your account from the app. Are you sure to continue?',
        title: 'Logout',
        mainOptionTxt: 'Logout',
        onContinue: () async {
          await fAuthService.logOut();
          navigationService.popAllAndPushNamed(Routes.Login);
        });
  }

  void getAppointment() {
    apiService.getAppointmentToday().listen(
          (event) {
        appointmentSubscription?.cancel();
        appointmentSubscription =
            apiService.getAppointmentToday().listen((event) {
              myAppointments.clear();
              myAppointments.addAll(event);
              notifyListeners();
              // updateAppointmentList();
            });
      },
    );
  }

  updateAppointmentList() {
    for (AppointmentModel appointment in myAppointments) {
      myAppointments.removeWhere((element) =>
      (element.appointment_status == AppointmentStatus.Declined.name) ||
          (element.appointment_status == AppointmentStatus.Cancelled.name) ||
          (element.appointment_status == AppointmentStatus.Completed.name));
      notifyListeners();
    }
  }

  void goToNotificationView() {
    navigationService.pushNamed(Routes.NotificationView);
  }

  void goToUserView(UserModel user) {
    navigationService.pushNamed(Routes.UserView,
        arguments: UserViewArguments(user: user));
  }
}
