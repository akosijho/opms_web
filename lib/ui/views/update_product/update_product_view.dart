import 'package:flutter/material.dart';
import 'package:opmswebstaff/models/product/product.dart';
import 'package:opmswebstaff/ui/views/update_product/update_product_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_border_styles.dart';
import '../../../constants/styles/text_styles.dart';

class UpdateProductView extends StatelessWidget {
  final Product medicine;
  const UpdateProductView({Key? key, required this.medicine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateProductViewModel>.reactive(
      viewModelBuilder: () => UpdateProductViewModel(),
      onModelReady: (model) => model.init(medicine),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Update Product'),
          centerTitle: true,
        ),
        persistentFooterButtons: [
          SizedBox(
            // width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () {
                  if (model.updateFormKey.currentState!.validate()) {
                    model.performUpdate(medicine.id!);
                  }
                },
                child: Text('Save Changes',
                  style: TextStyle(
                    fontSize: 15
                  ))),
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
                          model.validatorService.validateProductName(value!),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        errorBorder: TextBorderStyles.errorBorder,
                        errorStyle: TextStyles.errorTextStyle,
                        hintText: 'Product Name',
                        labelText: 'Product*',
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
                          model.validatorService.validateProductName(value!),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorBorder: TextBorderStyles.errorBorder,
                        errorStyle: TextStyles.errorTextStyle,
                        hintText: 'Product Amount Fee',
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
