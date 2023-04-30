import 'dart:io';

import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opmswebstaff/ui/views/add_product/add_product_view_model.dart';
import 'package:stacked/stacked.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final addMedicineFormKey = GlobalKey<FormState>();
  final medicineName = TextEditingController();
  final brandName = TextEditingController();
  final medicinePrice = TextEditingController();

  @override
  void dispose() {
    medicineName.dispose();
    brandName.dispose();
    medicinePrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddProductViewModel>.reactive(
      viewModelBuilder: () => AddProductViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Product'),
        ),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (addMedicineFormKey.currentState!.validate()) {
                      model.addMedicine(
                          medicineName: medicineName.text,
                          brandName: brandName.text,
                          price: medicinePrice.text);
                    }
                  },
                  child: Text('Save',
                    style: TextStyle(
                      fontSize: 16
                  ),)),
            ],
          )
        ],
        body: Form(
          key: addMedicineFormKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      border: Border.all(color: Colors.grey.shade400, width: 4),
                    ),
                    child: model.selectedImage == null
                        ? Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: SvgPicture.asset(
                                'assets/icons/Camera.svg',
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Image.file(
                            File(model.selectedImage!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () => model.selectImage(),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    child: Text(
                      'Add Picture',
                      style: TextStyles.tsBody3(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: medicineName,
                validator: (value) =>
                    model.validatorService.validateMedicineName(value!),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Product Name',
                  labelText: 'Product Name*',
                  // disabledBorder: ,
                  labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: brandName,
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
                controller: medicinePrice,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    model.validatorService.validatePrice(value!),
                keyboardType: TextInputType.number,
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Type Amount',
                  labelText: 'Amount',
                  // disabledBorder: ,
                  labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
