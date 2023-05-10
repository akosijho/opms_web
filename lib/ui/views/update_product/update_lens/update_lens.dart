import 'package:flutter/material.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/models/product/lens.dart';
import 'package:opmswebstaff/ui/views/update_product/update_lens/update_lens_model.dart';
import 'package:stacked/stacked.dart';

class UpdateLensView extends StatelessWidget {
  final Lens lens;
  const UpdateLensView({Key? key, required this.lens})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateLensViewModel>.reactive(
      viewModelBuilder: () => UpdateLensViewModel(),
      onModelReady: (model) => model.init(lens),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Update Product'),
          centerTitle: true,
        ),
        persistentFooterButtons: [
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () {
                  if (model.updateFormKey.currentState!.validate()) {
                    model.performUpdate(lens.id!);
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
                controller: model.productNameTxtController,
                validator: (value) =>
                    model.validatorService.validateMedicineName(value!),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Lens Name',
                  labelText: 'Lens*',
                  // disabledBorder: ,
                  labelStyle:
                  TextStyles.tsBody1(color: Palettes.kcNeutral1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: model.brandNameTxtController,
                validator: (value) =>
                    model.validatorService.validateBrandName(value!),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Brand Name',
                  labelText: 'Brand Name*',
                  // disabledBorder: ,
                  labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
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
                  hintText: 'Lens Amount Fee',
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
