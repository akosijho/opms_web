import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/core/service/validator/validator_service.dart';
import 'package:opmsapp/main.dart';
import 'package:opmsapp/models/expense/expense.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class AddExpenseItemViewModel extends BaseViewModel {
  final validatorService = locator<ValidatorService>();

  final addExpenseItemFormKey = GlobalKey<FormState>();
  final itemNameTxtController = TextEditingController();
  final itemQuantityTxtController = TextEditingController(text: '1');
  final itemTotalAmountTxtController = TextEditingController();

  @override
  void dispose() {
    itemNameTxtController.dispose();
    itemQuantityTxtController.dispose();
    itemTotalAmountTxtController.dispose();
    super.dispose();
  }

  void returnExpenseItem() {
    if (addExpenseItemFormKey.currentState!.validate()) {
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final ExpenseItem expenseItem = ExpenseItem(
          itemName: itemNameTxtController.text,
          itemQty: int.parse(itemQuantityTxtController.text),
          amount: double.parse(itemTotalAmountTxtController.text),
          id: id);
      navigationService.pop(returnValue: expenseItem);
    }
  }
}
