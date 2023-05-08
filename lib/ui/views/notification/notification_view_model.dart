import 'dart:async';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/models/notification/notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../core/service/navigation/navigation_service.dart';

class NotificationViewModel extends BaseViewModel {
  //

  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  List<NotificationModel> notifications = [];
  List<NotificationModel> selectedNotification = [];

  StreamSubscription? notifSub;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  void init() async {
    setBusy(true);
    await getNotification();
    await Future.delayed(Duration(seconds: 1));
    listenToNotification();
    setBusy(false);
  }

  Future<void> getNotification() async {
    debugPrint('User Id ${currentUserId}');
    final notifs = await apiService.getNotification(
        userId: currentUserId.trimLeft().trimRight());

    if (notifs != null) {
      notifications.clear();
      notifications.addAll(notifs);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    notifSub?.cancel();
    super.dispose();
  }

  void listenToNotification() {
    apiService
        .listenToNotificationChanges(userId: currentUserId)
        .listen((event) {
      notifSub?.cancel();
      notifSub = apiService
          .listenToNotificationChanges(userId: currentUserId)
          .listen((event) {
        getNotification();
      });
    });
  }

  void markRead(String notificationId) async {
    await apiService.markReadNotification(notificationId: notificationId);
  }

  void deleteNotif(String notificationId) async {
    await apiService.deleteNotification(notificationId: notificationId);
  }

  void markAllRead() async {
    for (NotificationModel notification in notifications) {
      markRead(notification.id);
    }
  }

  void deleteAllNotif() async {
    for (NotificationModel notification in notifications) {
      deleteNotif(notification.id);
    }
  }

  // Future<void> openNotification(NotificationModel notification) async {
  //   if (notification.notification_type == 'appointment') {
  //     final appointmentId = notification.id.toString().split(' ').first;
  //     final appointment = await apiService.getAppointmentById(appointmentId);
  //     navigationService.pushNamed(Routes.AppointmentView,
  //         arguments: AppointmentViewArguments(appointment: appointment));
  //   } else if (notification.notification_type == 'payment') {
  //     //
  //   }
  // }
  Future<void> openNotification(NotificationModel notification) async {
    try {
      if (notification.notification_type == 'appointment') {
        final appointmentId = notification.id.toString().split(' ').first;
        final appointment = await apiService.getAppointmentById(appointmentId);
        navigationService.pushNamed(Routes.AppointmentView,
            arguments: AppointmentViewArguments(appointment: appointment));
      } else if (notification.notification_type == 'payment') {
        //
      }
    } catch (e) {
      // Handle the error here
      print('Error opening notification: $e');
      // Show a snackbar or a dialog with the error message
      // snackbarService.showSnackbar(message: 'Error opening notification: $e');
    }
  }

}
