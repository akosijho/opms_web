import 'dart:async';

import 'package:opmsapp/app/app.router.dart';
import 'package:opmsapp/core/service/api/api_service.dart';
import 'package:opmsapp/core/service/connectivity/connectivity_service.dart';
import 'package:opmsapp/core/service/dialog/dialog_service.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:opmsapp/core/service/snack_bar/snack_bar_service.dart';
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
        arguments: ReceiptViewArguments(payment: patientPaymentList[index]));
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
