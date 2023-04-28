import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/add_procedure/add_procedure_view_model.dart';
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
          title: Text('Add Service'),
        ),
        // persistentFooterButtons: [
        //   SizedBox(
        //     width: double.maxFinite,
        //     child: ElevatedButton(
        //         onPressed: () {
        //           if (addProcedureFormKey.currentState!.validate()) {
        //             model.addProcedure(
        //                 procedureName: procedureName.text,
        //                 price: procedurePrice.text);
        //           }
        //         },
        //         child: Text('Save')),
        //   )
        // ],
        body: Form(
          key: addProcedureFormKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 300,
                width: 600,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.all( Radius.circular(30)),
                  border: Border.all(color: Colors.grey)
                ),
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
                        hintText: 'Service Name',
                        labelText: 'Service*',
                        // disabledBorder: ,
                        labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: procedurePrice,
                      // validator: (value) =>
                      //     model.validatorService.validateMedicineName(value!),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorBorder: TextBorderStyles.errorBorder,
                        errorStyle: TextStyles.errorTextStyle,
                        hintText: 'Service Amount Fee',
                        labelText: 'Amount(Optional)',
                        // disabledBorder: ,
                        labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    SizedBox(height: 100),
                    SizedBox(
                      // width: double.maxFinite,
                      child: ElevatedButton(
                          onPressed: () {
                            if (addProcedureFormKey.currentState!.validate()) {
                              model.addProcedure(
                                  procedureName: procedureName.text,
                                  price: procedurePrice.text);
                            }
                          },
                          child: Text('Save',
                          style: TextStyle(
                            fontSize: 18
                          ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
