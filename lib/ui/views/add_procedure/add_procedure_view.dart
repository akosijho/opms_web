import 'package:opmsapp/constants/styles/palette_color.dart';
import 'package:opmsapp/constants/styles/text_border_styles.dart';
import 'package:opmsapp/constants/styles/text_styles.dart';
import 'package:opmsapp/ui/views/add_procedure/add_procedure_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddProcedureView extends StatefulWidget {
  const AddProcedureView({Key? key}) : super(key: key);

  @override
  State<AddProcedureView> createState() => _AddProcedureViewState();
}

class _AddProcedureViewState extends State<AddProcedureView> {
  final addProcedureFormKey = GlobalKey<FormState>();
  final procedureName = TextEditingController();
  final procedurePrice = TextEditingController();

  @override
  void dispose() {
    procedureName.dispose();
    procedurePrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddProcedureViewModel>.reactive(
      viewModelBuilder: () => AddProcedureViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Procedure'),
        ),
        persistentFooterButtons: [
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () {
                  if (addProcedureFormKey.currentState!.validate()) {
                    model.addProcedure(
                        procedureName: procedureName.text,
                        price: procedurePrice.text);
                  }
                },
                child: Text('Save')),
          )
        ],
        body: Form(
          key: addProcedureFormKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            children: [
              TextFormField(
                controller: procedureName,
                validator: (value) =>
                    model.validatorService.validateMedicineName(value!),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Procedure Name',
                  labelText: 'Procedure*',
                  // disabledBorder: ,
                  labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: procedurePrice,
                // validator: (value) =>
                //     model.validatorService.validateMedicineName(value!),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Procedure Amount Fee',
                  labelText: 'Amount(Optional)',
                  // disabledBorder: ,
                  labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
