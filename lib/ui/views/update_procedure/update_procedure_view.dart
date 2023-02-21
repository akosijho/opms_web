import 'package:opmsapp/models/procedure/procedure.dart';
import 'package:opmsapp/ui/views/update_procedure/update_procedure_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_border_styles.dart';
import '../../../constants/styles/text_styles.dart';

class UpdateProcedureView extends StatelessWidget {
  final Procedure procedure;
  const UpdateProcedureView({Key? key, required this.procedure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateProcedureViewModel>.reactive(
      viewModelBuilder: () => UpdateProcedureViewModel(),
      onModelReady: (model) => model.init(procedure),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Update Procedure'),
          centerTitle: true,
        ),
        persistentFooterButtons: [
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () {
                  if (model.updateFormKey.currentState!.validate()) {
                    model.performUpdate(procedure.id!);
                  }
                },
                child: Text('Save Changes')),
          )
        ],
        body: model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: model.updateFormKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  children: [
                    TextFormField(
                      controller: model.procedureNameTxtController,
                      validator: (value) =>
                          model.validatorService.validateMedicineName(value!),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        errorBorder: TextBorderStyles.errorBorder,
                        errorStyle: TextStyles.errorTextStyle,
                        hintText: 'Procedure Name',
                        labelText: 'Procedure*',
                        // disabledBorder: ,
                        labelStyle:
                            TextStyles.tsBody1(color: Palettes.kcNeutral1),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: model.amountTxtController,
                      validator: (value) =>
                          model.validatorService.validateMedicineName(value!),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorBorder: TextBorderStyles.errorBorder,
                        errorStyle: TextStyles.errorTextStyle,
                        hintText: 'Procedure Amount Fee',
                        labelText: 'Amount(Optional)',
                        // disabledBorder: ,
                        labelStyle:
                            TextStyles.tsBody1(color: Palettes.kcNeutral1),
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
