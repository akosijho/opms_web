import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/ui/views/add_prescription_item/add_prescription_iteme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddPrescriptionItemView extends StatelessWidget {
  const AddPrescriptionItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPrescriptionItemViewModel>.reactive(
      viewModelBuilder: () => AddPrescriptionItemViewModel(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Prescription Item'),
        ),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () => model.returnPrescriptionItem(),
                      child: Text('Done'))),
            ],
          )
        ],
        body: Form(
          key: model.prescriptionItemFormKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: model.inscriptionTxtController,
                    textInputAction: TextInputAction.done,
                    maxLines: 3,
                    maxLength: 40,
                    validator: (value) =>
                        model.validatorService.validateInscription(value!),
                    decoration: InputDecoration(
                      hintText: 'Type here the product prescribed',
                      labelText: 'Inscription*',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle:
                          TextStyle(fontSize: 20, color: Palettes.kcNeutral1),
                      enabledBorder: TextBorderStyles.normalBorder,
                      focusedBorder: TextBorderStyles.focusedBorder,
                    ),
                  ),
                  TextFormField(
                    controller: model.subscriptionTxtController,
                    textInputAction: TextInputAction.done,
                    validator: (value) =>
                        model.validatorService.validateSubscription(value!),
                    maxLines: 3,
                    maxLength: 40,
                    decoration: InputDecoration(
                      hintText: 'Type here the direction for pharmacist',
                      labelText: 'Subscription*',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle:
                          TextStyle(fontSize: 20, color: Palettes.kcNeutral1),
                      enabledBorder: TextBorderStyles.normalBorder,
                      focusedBorder: TextBorderStyles.focusedBorder,
                    ),
                  ),
                  TextFormField(
                    controller: model.signaturaTxtController,
                    textInputAction: TextInputAction.done,
                    validator: (value) =>
                        model.validatorService.validateSignatura(value!),
                    maxLines: 3,
                    maxLength: 40,
                    decoration: InputDecoration(
                      hintText: 'Type here the direction for patient',
                      labelText: 'Signatura*',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle:
                          TextStyle(fontSize: 20, color: Palettes.kcNeutral1),
                      enabledBorder: TextBorderStyles.normalBorder,
                      focusedBorder: TextBorderStyles.focusedBorder,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
