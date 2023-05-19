import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opmswebstaff/ui/views/add_expense_item/add_expense_item_view.dart';
import 'package:opmswebstaff/ui/views/add_expenses/add_expenses_view.dart';
import 'package:stacked/stacked.dart';

import '../../../core/service/api/api_service.dart';
import '../../../core/service/bottom_sheet/bottom_sheet_service.dart';
import '../../../core/service/validator/validator_service.dart';
import '../../../models/expense/expense.dart';
import '../../widgets/selection_date/selection_date.dart';

class AddExpensesViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final dialogService = locator<DialogService>();
  final snackBarService = locator<SnackBarService>();
  final bottomSheetService = locator<BottomSheetService>();
  final apiService = locator<ApiService>();

  final addExpenseFormKey = GlobalKey<FormState>();
  final dateTxtController = TextEditingController();
  final noteTextController = TextEditingController();
  DateTime? selectedExpenseDate;

  List<ExpenseItem> listOfExpenseItem = [];
  double totalAmount = 0;

  // void goToAddExpenseItem() async {
  //   final ExpenseItem? item =
  //       await navigationService.pushNamed(Routes.AddExpenseItemView);
  //   if (item != null) {
  //     listOfExpenseItem.add(item);
  //     computeTotalAmount();
  //     notifyListeners();
  //   }
  // }

  void goToAddExpenseItem(BuildContext context) async {
    ExpenseItem? item = await showDialog<ExpenseItem>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: AddExpenseItemView(),
          ),
        );
      },
    );
      if (item != null) {
        listOfExpenseItem.add(item);
        computeTotalAmount();
        notifyListeners();
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
      selectedExpenseDate = date;
      textEditingController.text =
          DateFormat.yMMMd().format(selectedExpenseDate!);
      notifyListeners();
    }
  }

  void removeExpenseItem(String id) {
    dialogService.showConfirmDialog(
      title: 'Remove Item',
      middleText: 'Are you sure to remove this item?',
      mainOptionColor: Colors.red,
      mainOptionTxt: 'Remove',
      onCancel: () {
        navigationService.pop();
      },
      onContinue: () {
        listOfExpenseItem.removeWhere((item) => item.id == id);
        notifyListeners();
        computeTotalAmount();

        navigationService.pop();
      },
    );
  }

  void computeTotalAmount() {
    totalAmount = 0;
    for (ExpenseItem item in listOfExpenseItem) {
      totalAmount += item.amount;
      notifyListeners();
    }
  }

  // Future<void> addExpense() async {
  void addExpense() async {
    dialogService.showDefaultLoadingDialog(
        barrierDismissible: false, willPop: true);
    final expense = Expense(
        items: listOfExpenseItem,
        totalAmount: totalAmount,
        date: selectedExpenseDate.toString(),
        note: noteTextController.text);
    final addExpenseQueryRes = await apiService.addExpense(expense: expense);
    if (addExpenseQueryRes.success) {
      // navigationService.popRepeated(1);
      navigationService.popAllAndPushNamed(Routes.MainBodyView);
      snackBarService.showSnackBar(
          message: 'Clinic Expense Saved', title: 'SUCCESS!');
    } else {
      navigationService.popRepeated(1);
      // navigationService.popUntilNamed(Routes.AddExpenseView);
      snackBarService.showSnackBar(
          message: addExpenseQueryRes.errorMessage ?? 'Something Went Wrong',
          title: 'Error');
    }
  }

  void performAddingExpense() async {
    // if (addExpenseFormKey.currentState!.validate()) {
      if (listOfExpenseItem.isNotEmpty) {
        dialogService.showConfirmDialog(
          title: 'Add clinic expense',
          middleText: 'Doing this action will let you add a new clinic'
              ' expense record. Continue this action?',
          onCancel: () {
            navigationService.pop();
          },
          onContinue: () => addExpense(),
        );
      } else {
        snackBarService.showSnackBar(
            message:
                'No Items added. You must add at least one item to continue',
            title: 'Error');
      }
    // }
  }
}
