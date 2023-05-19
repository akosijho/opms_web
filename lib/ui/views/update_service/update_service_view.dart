import 'package:flutter/material.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:opmswebstaff/ui/views/update_service/update_service_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_border_styles.dart';
import '../../../constants/styles/text_styles.dart';

class UpdateServiceView extends StatelessWidget {
  final Service service;
  const UpdateServiceView({Key? key, required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateServiceViewModel>.reactive(
      viewModelBuilder: () => UpdateServiceViewModel(),
      onModelReady: (model) => model.init(service),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Update Service'),
          centerTitle: true,
        ),
        persistentFooterButtons: [
          SizedBox(
            // width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () {
                  if (model.updateFormKey.currentState!.validate()) {
                    model.performUpdate(service.id!);
                  }
                },
                child: Text('Save Changes',
                    style: TextStyle(
                        fontSize: 15
                    )
                )),
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
                      controller: model.serviceNameTxtController,
                      validator: (value) =>
                          model.validatorService.validateProductName(value!),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        errorBorder: TextBorderStyles.errorBorder,
                        errorStyle: TextStyles.errorTextStyle,
                        hintText: 'Service Name',
                        labelText: 'Service*',
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
                          model.validatorService.validateProductName(value!),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorBorder: TextBorderStyles.errorBorder,
                        errorStyle: TextStyles.errorTextStyle,
                        hintText: 'Service Amount Fee',
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
