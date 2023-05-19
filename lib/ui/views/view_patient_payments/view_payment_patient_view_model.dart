import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/connectivity/connectivity_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/ui/views/add%20rx/rx_view.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/patient_model/patient_model.dart';
import '../../../models/payment/payment.dart';


class ViewPatientPaymentViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();
  final connectivityService = locator<ConnectivityService>();
  final snackBarService = locator<SnackBarService>();
  StreamSubscription? paymentSub;

  List<Payment> patientPaymentList = [];

  @override
  void dispose() {
    paymentSub?.cancel();
    super.dispose();
  }

  Future<void> getPatientPayment({required String patientId}) async {
    if (await connectivityService.checkConnectivity()) {
      await Future.delayed(Duration(milliseconds: 300));
      dialogService.showDefaultLoadingDialog();
      final payments =
      await apiService.getPaymentByPatient(patientId: patientId);
      patientPaymentList.clear();
      patientPaymentList.addAll(payments);
      navigationService.pop();
      notifyListeners();
    } else {
      navigationService.pop();
      snackBarService.showSnackBar(
          message: 'Check your network connection and try again.',
          title: 'Network Error');
    }
  }

  void goToReceipt(int index) {
    navigationService.pushNamed(Routes.ReceiptView,
        arguments: ReceiptViewArguments(payment: patientPaymentList[index], showAppBar: false));
  }
  void goToRx(int index) {
    navigationService.pushNamed(Routes.RxView,
        arguments: RxViewArguments(payment: patientPaymentList[index]));
  }

  void goToAddBilling(Patient patient) {
    navigationService.pushNamed(Routes.AddPaymentView,
        arguments: AddPaymentViewArguments(patient: patient));
  }

  void listenToPaymentChange(dynamic patientId) {
    apiService.listenToPaymentChanges().listen((event) {
      paymentSub?.cancel();
      paymentSub = apiService.listenToPaymentChanges().listen((event) {
        getPatientPayment(patientId: patientId);
      });
    });
  }
}

// class ViewPatientPaymentViewModel extends BaseViewModel {
//   final apiService = locator<ApiService>();
//   final dialogService = locator<DialogService>();
//   final navigationService = locator<NavigationService>();
//   // final connectivityService = locator<ConnectivityService>();
//   final snackBarService = locator<SnackBarService>();
//   StreamSubscription? paymentSub;
//
//   List<Payment> patientPaymentList = [];
//
//   @override
//   void dispose() {
//     paymentSub?.cancel();
//     super.dispose();
//   }
//
//   // Future<void> getPatientPayment({required String patientId}) async {
//   //   if (await connectivityService.checkConnectivity()) {
//   //     await Future.delayed(Duration(milliseconds: 300));
//   //     dialogService.showDefaultLoadingDialog();
//   //     final payments =
//   //         await apiService.getPaymentByPatient(patientId: patientId);
//   //     patientPaymentList.clear();
//   //     patientPaymentList.addAll(payments);
//   //     navigationService.pop();
//   //     notifyListeners();
//   //   } else {
//   //     navigationService.pop();
//   //     snackBarService.showSnackBar(
//   //         message: 'Check your network connection and try again.',
//   //         title: 'Network Error');
//   //   }
//   // }
//   // void getPatientPayment({required String patientId}) async {
//   //   // if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
//   //
//   //     final payments = await apiService.getPaymentByPatient(patientId: patientId);
//   //     dialogService.showDefaultLoadingDialog();
//   //     await Future.delayed(Duration(milliseconds: 300));
//   //     patientPaymentList.clear();
//   //     patientPaymentList.addAll(payments);
//   //     navigationService.pop();
//   //     notifyListeners();
//   //     // print(patientPaymentList);
//   //   }
//     // else {
//     //   navigationService.pop();
//     //   snackBarService.showSnackBar(
//     //     message: 'Check your network connection and try again.',
//     //     title: 'Network Error',
//     //   );
//     // }
//   // }
//   Future<void> getPatientPayment({required String patientId}) async {
//     // if (await connectivityService.checkConnectivity()) {
//     //   await Future.delayed(Duration(milliseconds: 300));
//     //   dialogService.showDefaultLoadingDialog();
//     setBusy(true);
//       final payments =
//       await apiService.getPaymentByPatient(patientId: patientId);
//       print(payments);
//
//       if (payments != null){
//         patientPaymentList.clear();
//         patientPaymentList.addAll(payments);
//         navigationService.pop();
//         notifyListeners();
//       }
//       setBusy(true);
//
//     // } else {
//     //   navigationService.pop();
//     //   snackBarService.showSnackBar(
//     //       message: 'Check your network connection and try again.',
//     //       title: 'Network Error');
//     // }
//   }
//
//   void goToReceipt(int index) {
//     navigationService.pushNamed(Routes.ReceiptView,
//         arguments: ReceiptViewArguments(payment: patientPaymentList[index], showAppBar: true));
//   }
//   void goToRx(int index) {
//     navigationService.pushNamed(Routes.RxView,
//         arguments: RxViewArguments(payment: patientPaymentList[index]));
//   }
//
//   void goToAddBilling(Patient patient) {
//     navigationService.pushNamed(Routes.AddPaymentView,
//         arguments: AddPaymentViewArguments(patient: patient));
//   }
//
//   void listenToPaymentChange(dynamic patientId) {
//     apiService.listenToPaymentChanges().listen((event) {
//       paymentSub?.cancel();
//       paymentSub = apiService.listenToPaymentChanges().listen((event) {
//         getPatientPayment(patientId: patientId);
//       });
//     });
//   }
// }
