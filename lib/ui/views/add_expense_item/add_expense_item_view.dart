import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_border_styles.dart';
import '../../../constants/styles/text_styles.dart';
import 'add_expense_item_view_model.dart';

class AddExpenseItemView extends StatelessWidget {
  const AddExpenseItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddExpenseItemViewModel>.nonReactive(
      viewModelBuilder: () => AddExpenseItemViewModel(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Add Expense Item'),
          centerTitle: true,
        ),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => model.returnExpenseItem(),
                child: Text('Add',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ),
            ],
          )
        ],
        body: Form(
          key: model.addExpenseItemFormKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            children: [
              TextFormField(
                controller: model.itemNameTxtController,
                validator: (value) =>
                    model.validatorService.validateItemName(value!),
                textInputAction: TextInputAction.next,
                maxLength: 40,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  enabledBorder: TextBorderStyles.normalBorder,
                  focusedBorder: TextBorderStyles.focusedBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Type here',
                  labelText: 'Item Name*',
                  labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: model.itemQuantityTxtController,
                enableInteractiveSelection: false,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    model.validatorService.validateItemQty(value!),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  enabledBorder: TextBorderStyles.normalBorder,
                  focusedBorder: TextBorderStyles.focusedBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Type here',
                  labelText: 'Quantity*',
                  labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: model.itemTotalAmountTxtController,
                validator: (value) =>
                    model.validatorService.validateTotalAmount(value!),
                enableInteractiveSelection: false,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(7),
                ],
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  enabledBorder: TextBorderStyles.normalBorder,
                  focusedBorder: TextBorderStyles.focusedBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Type here',
                  labelText: 'Total Amount Paid*',
                  labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
