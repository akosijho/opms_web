import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/models/appointment_model/appointment_model.dart';
import 'package:ntp/ntp.dart';
import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:opmswebstaff/ui/views/appointment_select_patient/appointment_select_patient_view.dart';
import 'package:stacked/stacked.dart';

import '../../../enums/appointment_status.dart';

class AppointmentViewModel extends BaseViewModel {
  DateTime? ntpDate;
  final navigationService = locator<NavigationService>();
  final toastService = locator<ToastService>();
  final dialogService = locator<DialogService>();
  final apiService = locator<ApiService>();
  DateTime selectedDate = DateTime.now();
  List<AppointmentModel> appointmentList = [];
  List<AppointmentModel> tempList = [];
  String filter = 'ALL';
  StreamSubscription? appointmentSub;

  Future<void> getDateFromNtp() async {
    ntpDate = await NTP.now();
    selectedDate = ntpDate ?? DateTime.now();

    notifyListeners();
  }

  // void goToSelectPatient() {
  //   navigationService.pushNamed(Routes.AppointmentSelectPatientView);
  // }
  void goToSelectPatient(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: AppointmentSelectPatientView(),
          ),
        );
      },
    );
  }

    // navigationService.pushNamed(Routes.CreateAppointmentView,
    //     arguments: CreateAppointmentViewArguments(patient: patient, popTimes: 3));


  // void goToSelectPatient(BuildContext context, Patient patient) async {
  //   await showDialog<Patient>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Center(
  //         child: SizedBox(
  //           width: 500,
  //           height: 500,
  //           child: AppointmentSelectPatientView(),
  //         ),
  //       );
  //     },
  //   );
  //
  //
  //     navigationService.pushNamed(
  //       Routes.CreateAppointmentView,
  //       arguments: CreateAppointmentViewArguments(patient: patient, popTimes: 3),
  //     );
  //
  // }



  void setFilter(String filter) {
    this.filter = filter;
    notifyListeners();
  }

  void goToViewAppointmentByPeriod() {
    navigationService.pushNamed(Routes.ViewAppointmentByPeriod);
  }

  // Future<void> getAppointmentByDate(DateTime? dateTime) async {
  //   setBusy(true);
  //   setFilter('ALL');
  //   selectedDate = dateTime ?? DateTime.now();
  //   tempList = await apiService.getAppointmentAccordingToDate(date: dateTime);
  //   appointmentList.clear();
  //   appointmentList.addAll(tempList);
  //   print(tempList);
  //   notifyListeners();
  //   setBusy(false);
  // }
  Future<void> getAppointmentByDate(DateTime? dateTime) async {
    setBusy(true);
    setFilter('ALL');
    selectedDate = dateTime ?? DateTime.now();

    try {
      tempList = await apiService.getAppointmentAccordingToDate(date: dateTime);
      appointmentList.clear();
      appointmentList.addAll(tempList);
      print(tempList);
      notifyListeners();
    } catch (error) {
      // Handle the error here
      print('Error occurred: $error');
      // Handle any necessary error-related tasks
    } finally {
      setBusy(false);
    }
  }


  void listenToAppointmentChanges() async {
    apiService.listenToAppointmentChanges().listen((event) {
      appointmentSub =
          apiService.listenToAppointmentChanges().listen((event) async {
            await getAppointmentByDate(selectedDate);
          });
    });
  }

  // void getAppointmentByAll() {
  //   setBusy(true);
  //   setFilter('ALL');
  //   appointmentList.clear();
  //   appointmentList.addAll(tempList);
  //   notifyListeners();
  //   setBusy(false);
  // }
  void getAppointmentByAll() {
    try {
      setBusy(true);
      setFilter('ALL');
      appointmentList.clear();
      appointmentList.addAll(tempList);
      notifyListeners();
    } catch (error) {
      // Handle the error here
      print('Error occurred: $error');
      // Handle any necessary error-related tasks
    } finally {
      setBusy(false);
    }
  }


  // void getAppointmentByCompleted() {
  //   setBusy(true);
  //   setFilter(AppointmentStatus.Completed.name);
  //   appointmentList.clear();
  //   appointmentList.addAll(tempList);
  //   for (AppointmentModel appointment in tempList) {
  //     appointmentList.removeWhere((element) =>
  //     !(element.appointment_status == AppointmentStatus.Completed.name));
  //     notifyListeners();
  //   }
  //   setBusy(false);
  // }

  void getAppointmentByCompleted() {
    try {
      setBusy(true);
      setFilter(AppointmentStatus.Completed.name);
      appointmentList.clear();
      appointmentList.addAll(tempList);
      for (AppointmentModel appointment in tempList) {
        appointmentList.removeWhere((element) =>
        !(element.appointment_status == AppointmentStatus.Completed.name));
        notifyListeners();
      }
    } catch (error) {
      // Handle the error here
      print('Error occurred: $error');
      // Handle any necessary error-related tasks
    } finally {
      setBusy(false);
    }
  }

  //
  // void getAppointmentByPending() {
  //   setBusy(true);
  //   setFilter(AppointmentStatus.Pending.name);
  //   appointmentList.clear();
  //   appointmentList.addAll(tempList);
  //   for (AppointmentModel appointment in tempList) {
  //     appointmentList.removeWhere((element) =>
  //     !(element.appointment_status == AppointmentStatus.Pending.name));
  //     notifyListeners();
  //   }
  //   setBusy(false);
  // }
  void getAppointmentByPending() {
    try {
      setBusy(true);
      setFilter(AppointmentStatus.Pending.name);
      appointmentList.clear();
      appointmentList.addAll(tempList);
      for (AppointmentModel appointment in tempList) {
        appointmentList.removeWhere((element) =>
        !(element.appointment_status == AppointmentStatus.Pending.name));
        notifyListeners();
      }
    } catch (error) {
      // Handle the error here
      print('Error occurred: $error');
      // Handle any necessary error-related tasks
    } finally {
      setBusy(false);
    }
  }


  // void getAppointmentByRequest() {
  //   setBusy(true);
  //   setFilter(AppointmentStatus.OnRequest.name);
  //   appointmentList.clear();
  //   appointmentList.addAll(tempList);
  //   for (AppointmentModel appointment in tempList) {
  //     appointmentList.removeWhere((element) =>
  //     !(element.appointment_status == AppointmentStatus.OnRequest.name));
  //     notifyListeners();
  //   }
  //   setBusy(false);
  // }
  void getAppointmentByRequest() {
    try {
      setBusy(true);
      setFilter(AppointmentStatus.OnRequest.name);
      appointmentList.clear();
      appointmentList.addAll(tempList);
      for (AppointmentModel appointment in tempList) {
        appointmentList.removeWhere((element) =>
        !(element.appointment_status == AppointmentStatus.OnRequest.name));
        notifyListeners();
      }
    } catch (error) {
      // Handle the error here
      print('Error occurred: $error');
      // Handle any necessary error-related tasks
    } finally {
      setBusy(false);
    }
  }


  // void getAppointmentByCancelled() {
  //   setBusy(true);
  //   setFilter(AppointmentStatus.Cancelled.name);
  //   appointmentList.clear();
  //   appointmentList.addAll(tempList);
  //   for (AppointmentModel appointment in tempList) {
  //     appointmentList.removeWhere((element) =>
  //     !(element.appointment_status == AppointmentStatus.Cancelled.name));
  //     notifyListeners();
  //   }
  //   setBusy(false);
  // }
  void getAppointmentByCancelled() {
    try {
      setBusy(true);
      setFilter(AppointmentStatus.Cancelled.name);
      appointmentList.clear();
      appointmentList.addAll(tempList);
      for (AppointmentModel appointment in tempList) {
        appointmentList.removeWhere((element) =>
        !(element.appointment_status == AppointmentStatus.Cancelled.name));
        notifyListeners();
      }
    } catch (error) {
      // Handle the error here
      print('Error occurred: $error');
      // Handle any necessary error-related tasks
    } finally {
      setBusy(false);
    }
  }


  // void getAppointmentByDeclined() {
  //   setBusy(true);
  //   setFilter(AppointmentStatus.Declined.name);
  //   appointmentList.clear();
  //   appointmentList.addAll(tempList);
  //   for (AppointmentModel appointment in tempList) {
  //     appointmentList.removeWhere((element) =>
  //     !(element.appointment_status == AppointmentStatus.Declined.name));
  //     notifyListeners();
  //   }
  //   setBusy(false);
  // }
  void getAppointmentByDeclined() {
    try {
      setBusy(true);
      setFilter(AppointmentStatus.Declined.name);
      appointmentList.clear();
      appointmentList.addAll(tempList);
      for (AppointmentModel appointment in tempList) {
        appointmentList.removeWhere((element) =>
        !(element.appointment_status == AppointmentStatus.Declined.name));
        notifyListeners();
      }
    } catch (error) {
      // Handle the error here
      print('Error occurred: $error');
      // Handle any necessary error-related tasks
    } finally {
      setBusy(false);
    }
  }


  Future<void> deleteAppointment(int index) async {
    dialogService.showConfirmDialog(
        title: 'Delete  appointment',
        middleText:
        'This action will delete the appointment permanently. Continue this action?',
        onCancel: () => navigationService.pop(),
        onContinue: () async {
          await apiService.deleteAppointment(
              appointmentId: appointmentList[index].appointment_id!);
          navigationService.pop();
          toastService.showToast(message: 'Appointment deleted');
        });
  }
}
