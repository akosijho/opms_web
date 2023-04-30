import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/notification/notification_model.dart';
import 'package:opmswebstaff/models/optical_notes/optical_notes.dart';
import 'package:opmswebstaff/models/payment/payment.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:opmswebstaff/ui/widgets/select_payment_type/select_payment_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../main.dart';
import '../../../models/medicine/medicine.dart';
import '../../../models/user_model/user_model.dart';
import '../../widgets/selection_date/selection_date.dart';

class AddPaymentViewModel extends BaseViewModel {
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final toastService = locator<ToastService>();

  final optometristTxtController = TextEditingController();
  final paymentTypeTxtController = TextEditingController();
  final dateTxtController = TextEditingController();
  final totalAmountTxtController = TextEditingController();
  final remarksTxtController = TextEditingController();
  final procedureTxtController = TextEditingController();

  String selectedPaymentType = "";
  DateTime? selectedPaymentDate;
  List<OpticalNotes> selectedOpticalNotes = [];
  List<Product> selectedProducts = [];
  // List<Procedure> selectedServices = [];
  final addPaymentFormKey = GlobalKey<FormState>();
  double opticalNoteSubTotal = 0.00;
  double productSubTotal = 0.00;
  double serviceSubTotal = 0.00;
  double totalAmountFinal = 0.00;

  Service? selectedService;

  @override
  void dispose() {
    optometristTxtController.dispose();
    paymentTypeTxtController.dispose();
    dateTxtController.dispose();
    totalAmountTxtController.dispose();
    remarksTxtController.dispose();
    super.dispose();
  }

  void init() async {
    totalAmountTxtController.text = totalAmountFinal.toString();
  }

  Future<void> getAllPatientOpticalNotes() async {}

  void showSelectOptometrist() async {
    UserModel? selectedOptometrist =
        await navigationService.pushNamed(Routes.SelectionOptometrist);
    if (selectedOptometrist != null) {
      optometristTxtController.text = selectedOptometrist.fullName;
    }
  }

  void showSelectPaymentType() async {
    selectedPaymentType = await Get.dialog(SelectPaymentType());
    paymentTypeTxtController.text = selectedPaymentType;
  }

  void selectDate() async {
    final DateTime? date =
        await bottomSheetService.openBottomSheet(SelectionDate(
      title: 'Set Payment Date',
      initialDate: DateTime.now(),
      maxDate: DateTime.now(),
    ));
    if (date != null) {
      selectedPaymentDate = date;
      notifyListeners();
      dateTxtController.text = DateFormat.yMMMd().format(selectedPaymentDate!);
    }
  }

  void selectOpticalNote(String patientId) async {
    selectedOpticalNotes = await navigationService.pushNamed(
            Routes.PaymentSelectOpticalNoteView,
            arguments:
                PaymentSelectOpticalNoteViewArguments(patientId: patientId)) ??
        [];
    notifyListeners();
    computeOpticalNoteSubTotal();
  }

  void selectProducts(String patientId) async {
    selectedProducts =
        await navigationService.pushNamed(Routes.SelectProductView) ?? [];
    notifyListeners();
    computeProductSubTotal();
  }


  void goToSelectService(String patientId) async {
    selectedService =
    await navigationService.pushNamed(Routes.SelectionService) ?? [];
    procedureTxtController.text = selectedService?.serviceName ?? '';
    notifyListeners();
      computeServiceSubTotal();
  }


  void computeOpticalNoteSubTotal() {
    opticalNoteSubTotal = 0;
    for (OpticalNotes opticalNote in selectedOpticalNotes) {
      opticalNoteSubTotal += double.parse(opticalNote.service.price!);
      notifyListeners();
    }
    computeTotalAmountFinal();
  }

  void computeProductSubTotal() {
    productSubTotal = 0;
    for (Product medicine in selectedProducts) {
      productSubTotal +=
          (double.parse(medicine.price!) * int.parse(medicine.qty!));
      notifyListeners();
    }
    computeTotalAmountFinal();
  }

  void computeServiceSubTotal() {
    serviceSubTotal = 0;

    serviceSubTotal +=
        double.parse(selectedService!.price!);
    notifyListeners();

    computeTotalAmountFinal();
  }

  void computeTotalAmountFinal() {
    totalAmountFinal = 0;
    // totalAmountFinal = dentalNoteSubTotal + medicineSubTotal;
    totalAmountFinal = opticalNoteSubTotal + productSubTotal;
    totalAmountTxtController.text = totalAmountFinal.toString();
    notifyListeners();
  }

  void onTotalAmountTextEdit(String value) {
    try {
      totalAmountFinal = double.parse(value);
    } catch (e) {
      totalAmountFinal = 0;
    }
    notifyListeners();
  }

  void updateOpticalNotePaidStatus({List<OpticalNotes>? selectedNotes}) {
    if (selectedOpticalNotes.isNotEmpty)
      for (OpticalNotes opticalNotes in selectedNotes ?? []) {
        opticalNotes.isPaid = true;
      }
  }

  void updateOpticalNotePaidStatusOnDB(
      {List<OpticalNotes>? selectedNotes, required String patientId}) async {
    if (selectedOpticalNotes.isNotEmpty)
      for (OpticalNotes dentalNote in selectedNotes ?? []) {
        await apiService.updateOpticalANotePaidStatus(
            patientId: patientId, dental_noteId: dentalNote.id, isPaid: true);
      }
  }

  Future<void> savePaymentInfo({
    List<OpticalNotes>? selectedNotes,
    List<Product>? selectedProduct,
    required String optometrist,
    required String patientId,
    required String patient_name,
    double? productSubTotal,
    double? opticalNoteSubTotal,
    required double totalAmountFinal,
    required String paymentType,
  }) async {
    try {
      if (addPaymentFormKey.currentState!.validate()) {
        dialogService.showConfirmDialog(
            onCancel: () => navigationService.pop(),
            middleText: 'You are trying to save a payment record.'
                ' Are you sure to continue this action?',
            title: 'Save payment record',
            onContinue: () async {
              navigationService.pop();
              dialogService.showDefaultLoadingDialog(
                  willPop: false, barrierDismissible: false);
              updateOpticalNotePaidStatus(selectedNotes: selectedNotes);
              final paymentQueryRes = await apiService.addPayment(
                payment: Payment(
                  patient_id: patientId,
                  optometrist: optometrist,
                  paymentDate: selectedPaymentDate.toString(),
                  opticalNote: selectedNotes,
                  productList: selectedProducts,
                  opticalNoteSubTotal: opticalNoteSubTotal.toString(),
                  productSubTotal: productSubTotal.toString(),
                  totalAmount: totalAmountFinal.toString(),
                  payment_type: paymentType,
                  patient_name: patient_name,
                  remarks: remarksTxtController.text,
                ),
              );

              updateOpticalNotePaidStatusOnDB(
                  patientId: patientId, selectedNotes: selectedNotes);
              final paymentRec = await apiService.getPaymentInfo(
                  paymentId: paymentQueryRes.returnValue);
              navigationService.popUntilFirstAndPushNamed(Routes.ReceiptView,
                  arguments: ReceiptViewArguments(payment: paymentRec));
              final notification = NotificationModel(
                user_id: patientId,
                notification_title:
                'Payment Record ${paymentRec.totalAmount.toCurrency}',
                notification_msg: 'Your payment on date'
                    ' ${DateFormat.yMMMd().add_jm().format(paymentRec.paymentDate.toDateTime()!)} was saved',
                notification_type: 'payment',
                isRead: false,
              );
              await apiService.saveNotification(
                  notification: notification,
                  typeId: paymentRec.payment_id ?? 'paymentId');
              snackBarService.showSnackBar(
                  message: paymentQueryRes.errorMessage ?? 'Payment Saved',
                  title: 'SUCCESS!');
            });
      }
    } catch (e) {
      navigationService.popRepeated(1);
      snackBarService.showSnackBar(
          message: 'Something Went Wrong: ${e.toString()}',
          title: 'Error');
    }
  }



}
