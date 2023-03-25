import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/add_dental_certificate/add_certicate_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_border_styles.dart';
import '../../../models/patient_model/patient_model.dart';

class AddCertificateView extends StatelessWidget {
  final Patient patient;

  const AddCertificateView({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCertificateViewModel>.reactive(
      viewModelBuilder: () => AddCertificateViewModel(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Add Optical Certificate'),
        ),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () => model.saveDentalCertificate(patient),
                      child: Text('Save & Generate PDF'))),
            ],
          )
        ],
        body: Form(
          key: model.addCertificateFormKey,
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              GestureDetector(
                onTap: () => model.selectDate(),
                child: TextFormField(
                  controller: model.dateTextController,
                  textInputAction: TextInputAction.next,
                  enabled: false,
                  validator: (value) =>
                      model.validatorService.validateDate(value!),
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      errorBorder: TextBorderStyles.errorBorder,
                      errorStyle: TextStyles.errorTextStyle,
                      disabledBorder: TextBorderStyles.normalBorder,
                      hintText: 'Date when procedure rendered',
                      labelText: 'Date*',
                      labelStyle:
                          TextStyles.tsBody1(color: Palettes.kcNeutral1),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                        color: Palettes.kcBlueMain1,
                      )),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => model.selectProcedure(),
                child: TextFormField(
                  controller: model.procedureTextController,
                  textInputAction: TextInputAction.next,
                  enabled: false,
                  validator: (value) =>
                      model.validatorService.validateProcedureName(value!),
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      errorBorder: TextBorderStyles.errorBorder,
                      errorStyle: TextStyles.errorTextStyle,
                      disabledBorder: TextBorderStyles.normalBorder,
                      hintText: 'Select Procedure',
                      labelText: 'Procedure*',
                      labelStyle:
                          TextStyles.tsBody1(color: Palettes.kcNeutral1),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                        color: Palettes.kcBlueMain1,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
