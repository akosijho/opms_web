import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/balance_notes/balance_notes.dart';
import 'package:opmswebstaff/models/notification/notification_model.dart';
import 'package:opmswebstaff/models/optical_notes/optical_notes.dart';
import 'package:opmswebstaff/models/payment/payment.dart';
import 'package:opmswebstaff/models/product/lens.dart';
import 'package:opmswebstaff/models/product/product.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:opmswebstaff/ui/views/payment_select_balance_note/payment_select_balance_note_view.dart';
import 'package:opmswebstaff/ui/views/payment_select_optical_note/payment_select_optical_note_view.dart';
import 'package:opmswebstaff/ui/views/receipt_view/receipt_view.dart';
import 'package:opmswebstaff/ui/views/select_product_view/select_lens_view/select_lens_view.dart';
import 'package:opmswebstaff/ui/views/select_product_view/select_product_view.dart';
import 'package:opmswebstaff/ui/widgets/select_payment_type/select_payment_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:opmswebstaff/ui/widgets/selection_optometrist/selection_optometrist.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../main.dart';
import '../../../models/user_model/user_model.dart';
import '../../widgets/selection_date/selection_date.dart';

class AddPaymentViewModel extends BaseViewModel {
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();

  final optometristTxtController = TextEditingController();
  final paymentTypeTxtController = TextEditingController();
  final dateTxtController = TextEditingController();
  final totalAmountTxtController = TextEditingController();
  final depositTxtController = TextEditingController();
  final balanceTxtController = TextEditingController();
  final remarksTxtController = TextEditingController();
  final serviceTxtController = TextEditingController();

  String selectedPaymentType = "";
  DateTime? selectedPaymentDate;
  List<OpticalNotes> selectedOpticalNotes = [];
  List<BalanceNotes> selectedBalanceNotes = [];
  List<Product> selectedProduct = [];
  List<Lens> selectedLens = [];
  final addPaymentFormKey = GlobalKey<FormState>();
  double opticalNoteSubTotal = 0.00;
  double balanceNoteSubTotal = 0.00;
  double productSubTotal = 0.00;
  double lensSubTotal = 0.00;
  double serviceSubTotal = 0.00;
  double totalAmountFinal = 0.00;
  double balance = 0.00;
  double deposit = 0.00;

  Service? selectedService;

  // AddRxView? addedRx;

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
    // totalAmountTxtController.text = totalAmountFinal.toString();
    balanceTxtController.text = balance.toString();
  }

  Future<void> getAllPatientDentalNotes() async {}

  // void showSelectOptometrist() async {
  //   UserModel? selectedOptometrist =
  //   await navigationService.pushNamed(Routes.SelectionOptometrist);
  //   if (selectedOptometrist != null) {
  //     optometristTxtController.text = selectedOptometrist.fullName;
  //   }
  // }
  void showSelectOptometrist(BuildContext context) async {
    UserModel? selectedOptometrist;
    selectedOptometrist = await showDialog<UserModel>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: SelectionOptometrist(),
          ),
        );
      },
    );
    if (selectedOptometrist != null) {
      optometristTxtController.text = selectedOptometrist.fullName;
    }
  }

  // void showSelectPaymentType() async {
  //   selectedPaymentType = await Get.dialog(SelectPaymentType());
  //   paymentTypeTxtController.text = selectedPaymentType;
  // }

  void showSelectPaymentType(BuildContext context) async {
    String? selectedPaymentType = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: SelectPaymentType(),
          ),
        );
      },
    );
    if (selectedPaymentType != null) {
      paymentTypeTxtController.text = selectedPaymentType;
    }
  }

  Future<void> selectDate(
      TextEditingController textEditingController, BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select Date',
      cancelText: 'CANCEL',
      confirmText: 'SELECT',
      errorFormatText: 'Invalid date format',
      errorInvalidText: 'Invalid date',
      fieldLabelText: 'date',
      fieldHintText: 'Month/Date/Year',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      selectedPaymentDate = date;
      textEditingController.text =
          DateFormat.yMMMd().format(selectedPaymentDate!);
      notifyListeners();
    }
  }

  void selectOpticalNote(BuildContext context, String patientId) async {
    selectedOpticalNotes = await showDialog<List<OpticalNotes>>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: PaymentSelectOpticalNoteView(patientId: patientId),
          ),
        );
      },
    ) ??
        [];
    notifyListeners();
    computeOpticalNoteSubTotal();
  }


  void selectBalanceNote(BuildContext context, String patientId) async {
    selectedBalanceNotes = await showDialog<List<BalanceNotes>>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: PaymentSelectBalanceNoteView(patientId: patientId),
          ),
        );
      },
    ) ??
        [];
    notifyListeners();
    computeBalanceNoteSubTotal();
  }


  void selectProduct(BuildContext context, String patientId) async {
    selectedProduct = await showDialog<List<Product>>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: SelectProductView(),
          ),
        );
      },
    ) ??
        [];
    notifyListeners();
    computeProductSubTotal();
  }

  // void selectLens(String patientId) async {
  //   selectedLens =
  //       await navigationService.pushNamed(Routes.SelectLensView) ?? [];
  //   notifyListeners();
  //   computeLensSubTotal();
  // }
  void selectLens(BuildContext context, String patientId) async {
    selectedLens = await showDialog<List<Lens>>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: SelectLensView(),
          ),
        );
      },
    ) ??
        [];
    notifyListeners();
    computeLensSubTotal();
  }

  // void goToSelectProcedure(String patientId) async {
  //   selectedService =
  //   await navigationService.pushNamed(Routes.SelectionService) ?? [];
  //   serviceTxtController.text = selectedService?.serviceName ?? '';
  //   notifyListeners();
  //     computeServiceSubTotal();
  // }

  void computeOpticalNoteSubTotal() {
    opticalNoteSubTotal = 0;
    for (OpticalNotes opticalNote in selectedOpticalNotes) {
      opticalNoteSubTotal += double.parse(opticalNote.service.price!);
      notifyListeners();
    }
    computeTotalAmountFinal();
  }

  void computeBalanceNoteSubTotal() {
    balanceNoteSubTotal = 0;
    for (BalanceNotes balanceNote in selectedBalanceNotes) {
      balanceNoteSubTotal += double.parse(balanceNote.balance);
      notifyListeners();
    }
    computeTotalAmountFinal();
  }

  void computeProductSubTotal() {
    productSubTotal = 0;
    for (Product product in selectedProduct) {
      productSubTotal +=
      (double.parse(product.price!) * int.parse(product.qty!));
      notifyListeners();
    }
    computeTotalAmountFinal();
  }

  void computeLensSubTotal() {
    lensSubTotal = 0;
    for (Lens lens in selectedLens) {
      lensSubTotal += (double.parse(lens.price!) * int.parse(lens.qty!));
      notifyListeners();
    }
    computeTotalAmountFinal();
  }

  void computeTotalAmountFinal() {
    totalAmountFinal = 0;
    totalAmountFinal = opticalNoteSubTotal +
        productSubTotal +
        lensSubTotal +
        balanceNoteSubTotal;
    totalAmountTxtController.text = totalAmountFinal.toString();
    notifyListeners();
  }

  void computeDeposit() {
    deposit = 0;
    depositTxtController.text = deposit.toString();
    notifyListeners();
  }

  void computeBalance() {
    balance = 0;
    double deposit = double.tryParse(depositTxtController.text) ?? 0.0;
    balance = totalAmountFinal - deposit;
    balanceTxtController.text = balance.toString();
    notifyListeners();
  }

  // void _calculateBalance() {
  //   double totalAmount = double.tryParse(_totalAmountController.text) ?? 0.0;
  //   double deposit = double.tryParse(depositTxtController.text) ?? 0.0;
  //   setState(() {
  //     _balance = totalAmount - deposit;
  //   });
  // }

  void onTotalAmountTextEdit(String value) {
    try {
      totalAmountFinal = double.parse(value);
    } catch (e) {
      totalAmountFinal = 0;
    }
    notifyListeners();
  }

  void onBalanceAmountTextEdit(String value) {
    try {
      balance = double.parse(value);
    } catch (e) {
      balance = 0;
    }
    notifyListeners();
  }

  void updateOpticalNotePaidStatus({List<OpticalNotes>? selectedNotes}) {
    if (selectedOpticalNotes.isNotEmpty)
      for (OpticalNotes opticalNotes in selectedNotes ?? []) {
        opticalNotes.isPaid = true;
      }
  }

  void updateBalanceNotePaidStatus({List<BalanceNotes>? selectedBalNotes}) {
    if (selectedBalanceNotes.isNotEmpty)
      for (BalanceNotes balanceNotes in selectedBalNotes ?? []) {
        balanceNotes.isPaid = true;
      }
  }

  void updateOpticalNotePaidStatusOnDB(
      {List<OpticalNotes>? selectedNotes, required String patientId}) async {
    if (selectedOpticalNotes.isNotEmpty)
      for (OpticalNotes opticalNote in selectedNotes ?? []) {
        await apiService.updateOpticalANotePaidStatus(
            patientId: patientId, optical_noteId: opticalNote.id, isPaid: true);
      }
  }

  void updateBalanceNotePaidStatusOnDB(
      {List<BalanceNotes>? selectedBalNotes, required String patientId}) async {
    if (selectedBalanceNotes.isNotEmpty)
      for (BalanceNotes balanceNote in selectedBalNotes ?? []) {
        await apiService.updateBalanceANotePaidStatus(
            patientId: patientId, balance_noteId: balanceNote.id, isPaid: true);
      }
  }

  Future<void> savePaymentInfo(
      {List<OpticalNotes>? selectedNotes,
        List<Product>? selectedProduct,
        List<Lens>? selectedLens,
        required String optometrist,
        required String patientId,
        required String patient_name,
        double? productSubTotal,
        double? lensSubTotal,
        double? opticalNoteSubTotal,
        double? balanceNoteSubTotal,
        required double totalAmountFinal,
        required String deposit,
        double? balance,
        required String paymentType,
        required BuildContext context}) async {
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
            updateBalanceNotePaidStatus(selectedBalNotes: selectedBalanceNotes);
            final paymentQueryRes = await apiService.addPayment(
              payment: Payment(
                patient_id: patientId,
                optometrist: optometrist,
                paymentDate: selectedPaymentDate.toString(),
                opticalNote: selectedNotes,
                productList: selectedProduct,
                lensList: selectedLens,
                opticalNoteSubTotal: opticalNoteSubTotal.toString(),
                balanceNoteSubTotal: balanceNoteSubTotal.toString(),
                productSubTotal: productSubTotal.toString(),
                lensSubTotal: lensSubTotal.toString(),
                totalAmount: totalAmountFinal.toString(),
                deposit: deposit.toString(),
                balance: balance.toString(),
                payment_type: paymentType,
                patient_name: patient_name,
                remarks: remarksTxtController.text,
              ),
            );

            final patientReference =
            FirebaseFirestore.instance.collection('patients');
            final balanceAmount = await patientReference
                .doc(patientId)
                .collection('balance_notes')
                .doc();
            if (balance! > 0) {
              await balanceAmount.set(BalanceNotes(
                isPaid: false,
                balance: balance.toString(),
                date: selectedPaymentDate.toString(),
              ).toJson(id: balanceAmount.id));
            }

            if (paymentQueryRes.success) {
              updateOpticalNotePaidStatusOnDB(
                  patientId: patientId, selectedNotes: selectedNotes);
              updateBalanceNotePaidStatusOnDB(
                  patientId: patientId, selectedBalNotes: selectedBalanceNotes);
              final paymentRec = await apiService.getPaymentInfo(
                  paymentId: paymentQueryRes.returnValue);
              //
              // navigationService.popUntilFirstAndPushNamed(Routes.ReceiptView,
              //     arguments: ReceiptViewArguments(payment: paymentRec));
              // navigationService.popUntilFirstAndPushNamed(Routes.MainBodyView);

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Receipt'),
                  content: Container(
                    height: 600,
                    width: 400,
                    child: ReceiptView(payment: paymentRec, showAppBar: false),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        navigationService.popAllAndPushNamed(Routes.MainBodyView);
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
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
