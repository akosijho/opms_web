import 'dart:async';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/extensions/date_format_extension.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/appointment_model/appointment_model.dart';
import 'package:opmswebstaff/models/notification/notification_model.dart';
import 'package:opmswebstaff/models/procedure/procedure.dart';
import 'package:opmswebstaff/models/user_model/user_model.dart';
import 'package:opmswebstaff/ui/widgets/selection_date/selection_date.dart';
import 'package:opmswebstaff/ui/widgets/selection_time/selection_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class CreateAppointmentViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  final toastService = locator<ToastService>();
  final bottomSheetService = locator<BottomSheetService>();
  final validatorService = locator<ValidatorService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();

  String? tempDate;
  List<Procedure> selectedProcedures = [];
  DateTime? selectedAppointmentDate;
  DateTime? selectedStartTime;
  DateTime? selectedEndTime;
  DateTime? tempStartTime;
  DateTime? tempEndTime;
  UserModel? myDentist;
  AppointmentModel? latestAppointment;

  Future<void> setAppointment(
      {required AppointmentModel appointment,
      required int popTime,
      required String patientId}) async {
    try {
      if (selectedStartTime!.isAfter(selectedEndTime!)) {
        snackBarService.showSnackBar(
            message: 'Start time cannot be the set before End time',
            title: 'Warning');
      }
      if (selectedStartTime!.isAtSameMomentAs(selectedEndTime!)) {
        snackBarService.showSnackBar(
            message: 'Start time cannot be the same with End time',
            title: 'Warning');
      }
      if (selectedStartTime!.isBefore(selectedEndTime!)) {
        dialogService.showDefaultLoadingDialog(
            willPop: false, barrierDismissible: false);
        final appointmentId = await apiService.createAppointment(appointment);
        final notification = NotificationModel(
          user_id: patientId,
          notification_title: 'New Appointment',
          notification_msg: 'You have new appointment '
              'with Doctor ${appointment.dentist}'
              ' on '
              '${DateFormat.yMMMd().add_jm().format(appointment.date.toDateTime()!)} ',
          notification_type: 'appointment',
          isRead: false,
        );
        await apiService.saveNotification(
            notification: notification, typeId: appointmentId);
        navigationService.popRepeated(popTime);
        toastService.showToast(message: 'Appointment added');
      }
    } catch (e) {
      debugPrint(e.toString());
      navigationService.closeOverlay();
      toastService.showToast(message: "Something's wrong");
    }
  }

  void selectDate(TextEditingController controller) async {
    selectedAppointmentDate =
        await bottomSheetService.openBottomSheet(SelectionDate(
      title: 'Set Appointment date',
      initialDate: DateTime.now(),
      maxDate: DateTime.utc(DateTime.now().year + 5),
    ));
    tempDate = selectedAppointmentDate != null
        ? selectedAppointmentDate.toString()
        : tempDate ?? '';
    selectedAppointmentDate = tempDate?.toDateTime()?.toDateMonthDayOnly() ??
        selectedAppointmentDate?.toDateMonthDayOnly();
    if (selectedAppointmentDate != null) {
      controller.text = DateFormat.yMMMd().format(selectedAppointmentDate!);
    }
    notifyListeners();
  }

  void selectStartTime(TextEditingController controller) async {
    if (selectedAppointmentDate != null) {
      selectedStartTime =
          await bottomSheetService.openBottomSheet(SelectionTime(
        title: 'Set Start Time',
        initialDateTime: DateTime(selectedAppointmentDate!.year,
            selectedAppointmentDate!.month, selectedAppointmentDate!.day),
      ));
      if (selectedStartTime != null) {
        if (selectedEndTime != selectedStartTime) {
          tempStartTime = selectedStartTime;
          controller.text = DateFormat.jm().format(selectedStartTime!);
        } else {
          snackBarService.showSnackBar(
              message: 'Start time cannot be the same with End time',
              title: 'Warning');
          controller.text = '';
        }
      } else {
        selectedStartTime = tempStartTime;
        notifyListeners();
      }
    } else {
      snackBarService.showSnackBar(
          message: 'Please Set Appointment Date First', title: 'Warning');
    }
  }

  void selectEndTime(TextEditingController controller) async {
    if (selectedStartTime != null) {
      selectedEndTime = await bottomSheetService.openBottomSheet(SelectionTime(
        title: 'Set End Time',
        initialDateTime: selectedStartTime!.add(Duration(minutes: 60)),
        minimumDateTime: selectedStartTime!.add(Duration(minutes: 5)),
      ));
      if (selectedEndTime != null) {
        if (selectedStartTime != selectedEndTime) {
          tempEndTime = selectedEndTime;
          controller.text = DateFormat.jm().format(selectedEndTime!);
        } else {
          snackBarService.showSnackBar(
              message: 'Start time cannot be the same with End time',
              title: 'Warning');
          controller.text = '';
        }
      } else {
        selectedEndTime = tempEndTime;
        notifyListeners();
      }
    } else {
      snackBarService.showSnackBar(
          message: 'Please set start time first', title: 'Warning');
    }
  }

  void openProcedureFullScreenModal(TextEditingController controller) async {
    Procedure? tempProcedure =
        await navigationService.pushNamed(Routes.SelectionProcedure);
    if (tempProcedure != null) {
      if (!(selectedProcedures
          .map((procedure) => procedure.id)
          .contains(tempProcedure.id))) {
        selectedProcedures.add(tempProcedure);
        notifyListeners();
      } else {
        toastService.showToast(message: 'Already Selected');
      }
    }
  }

  void openDentistModal(TextEditingController controller) async {
    UserModel? selectedDentist =
        await navigationService.pushNamed(Routes.SelectionDentist);
    if (selectedDentist != null) {
      myDentist = selectedDentist;
      controller.text = selectedDentist.fullName;
      notifyListeners();
    }
  }

  void deleteSelectedProcedure(Procedure procedure) {
    selectedProcedures.removeWhere((element) => element.id == procedure.id);
    notifyListeners();
    toastService.showToast(message: 'Removed');
  }
}
