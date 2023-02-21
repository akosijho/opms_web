import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/core/service/api/api_service.dart';
import 'package:opmsapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmsapp/core/service/dialog/dialog_service.dart';
import 'package:opmsapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmsapp/core/service/validator/validator_service.dart';
import 'package:opmsapp/extensions/string_extension.dart';
import 'package:opmsapp/models/dental_notes/dental_notes.dart';
import 'package:opmsapp/models/payment/payment.dart';
import 'package:opmsapp/ui/widgets/select_payment_type/select_payment_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../main.dart';
import '../../../models/medicine/medicine.dart';
import '../../../models/notification/notification_model.dart';
import '../../../models/user_model/user_model.dart';
import '../../widgets/selection_date/selection_date.dart';

class AddPaymentViewModel extends BaseViewModel {
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();

  final dentistTxtController = TextEditingController();
  final paymentTypeTxtController = TextEditingController();
  final dateTxtController = TextEditingController();
  final totalAmountTxtController = TextEditingController();
  final remarksTxtController = TextEditingController();

  String selectedPaymentType = "";
  DateTime? selectedPaymentDate;
  List<DentalNotes> selectedDentalNotes = [];
  List<Medicine> selectedMedicines = [];
  final addPaymentFormKey = GlobalKey<FormState>();
  double dentalNoteSubTotal = 0.00;
  double medicineSubTotal = 0.00;
  double totalAmountFinal = 0.00;

  @override
  void dispose() {
    dentistTxtController.dispose();
    paymentTypeTxtController.dispose();
    dateTxtController.dispose();
    totalAmountTxtController.dispose();
    remarksTxtController.dispose();
    super.dispose();
  }

  void init() async {
    totalAmountTxtController.text = totalAmountFinal.toString();
  }

  Future<void> getAllPatientDentalNotes() async {}

  void showSelectDentist() async {
    UserModel? selectedDentist =
        await navigationService.pushNamed(Routes.SelectionDentist);
    if (selectedDentist != null) {
      dentistTxtController.text = selectedDentist.fullName;
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

  void selectDentalNote(String patientId) async {
    selectedDentalNotes = await navigationService.pushNamed(
            Routes.PaymentSelectDentalNoteView,
            arguments:
                PaymentSelectDentalNoteViewArguments(patientId: patientId)) ??
        [];
    notifyListeners();
    computeDentalNoteSubTotal();
  }

  void selectMedicines(String patientId) async {
    selectedMedicines =
        await navigationService.pushNamed(Routes.SelectMedicineView) ?? [];
    notifyListeners();
    computeMedicineSubTotal();
  }

  void computeDentalNoteSubTotal() {
    dentalNoteSubTotal = 0;
    for (DentalNotes dentalNote in selectedDentalNotes) {
      dentalNoteSubTotal += double.parse(dentalNote.procedure.price!);
      notifyListeners();
    }
    computeTotalAmountFinal();
  }

  void computeMedicineSubTotal() {
    medicineSubTotal = 0;
    for (Medicine medicine in selectedMedicines) {
      medicineSubTotal +=
          (double.parse(medicine.price!) * int.parse(medicine.qty!));
      notifyListeners();
    }
    computeTotalAmountFinal();
  }

  void computeTotalAmountFinal() {
    totalAmountFinal = 0;
    totalAmountFinal = dentalNoteSubTotal + medicineSubTotal;
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

  void updateDentalNotePaidStatus({List<DentalNotes>? selectedNotes}) {
    if (selectedDentalNotes.isNotEmpty)
      for (DentalNotes dentalNotes in selectedNotes ?? []) {
        dentalNotes.isPaid = true;
      }
  }

  void updateDentalNotePaidStatusOnDB(
      {List<DentalNotes>? selectedNotes, required String patientId}) async {
    if (selectedDentalNotes.isNotEmpty)
      for (DentalNotes dentalNote in selectedNotes ?? []) {
        await apiService.updateDentalANotePaidStatus(
            patientId: patientId, dental_noteId: dentalNote.id, isPaid: true);
      }
  }

  Future<void> savePaymentInfo({
    List<DentalNotes>? selectedNotes,
    List<Medicine>? selectedMedicine,
    required String dentist,
    required String patientId,
    required String patient_name,
    double? medicineSubTotal,
    double? dentalNoteSubTotal,
    required double totalAmountFinal,
    required String paymentType,
  }) async {
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
            updateDentalNotePaidStatus(selectedNotes: selectedNotes);
            final paymentQueryRes = await apiService.addPayment(
              payment: Payment(
                patient_id: patientId,
                dentist: dentist,
                paymentDate: selectedPaymentDate.toString(),
                dentalNote: selectedNotes,
                medicineList: selectedMedicines,
                dentalNoteSubTotal: dentalNoteSubTotal.toString(),
                medicineSubTotal: medicineSubTotal.toString(),
                totalAmount: totalAmountFinal.toString(),
                payment_type: paymentType,
                patient_name: patient_name,
                remarks: remarksTxtController.text,
              ),
            );
            if (paymentQueryRes.success) {
              updateDentalNotePaidStatusOnDB(
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
            } else {
              navigationService.popRepeated(1);
              snackBarService.showSnackBar(
                  message:
                      paymentQueryRes.errorMessage ?? 'Something Went Wrong',
                  title: 'Error');
            }
          });
    }
  }
}
