import 'package:opmswebstaff/ui/views/edit_patient/edit_patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_border_styles.dart';
import '../../../constants/styles/text_styles.dart';
import '../../../models/patient_model/patient_model.dart';

class EditPatientView extends StatefulWidget {
  final Patient patient;
  const EditPatientView({Key? key, required this.patient}) : super(key: key);

  @override
  State<EditPatientView> createState() => _EditPatientViewModelState();
}

class _EditPatientViewModelState extends State<EditPatientView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditPatientViewModel>.reactive(
      viewModelBuilder: () => EditPatientViewModel(),
      onModelReady: (model) => model.init(widget.patient),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Edit Patient Info',
            style: TextStyles.tsHeading3(color: Colors.white),
          ),
        ),
        persistentFooterButtons: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () => model.performUpdate(widget.patient),
              child: Text('Update', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Form(
            key: model.addPatientFormKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: model.firstNameTxtController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) =>
                            model.validatorService.validateFirstName(value!),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Enter First Name',
                          labelText: 'First Name*',
                          labelStyle:
                              TextStyles.tsBody1(color: Palettes.kcNeutral1),
                          enabledBorder: TextBorderStyles.normalBorder,
                          focusedBorder: TextBorderStyles.focusedBorder,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      TextFormField(
                        controller: model.lastNameTxtController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            model.validatorService.validateLastName(value!),
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintText: 'Enter Last Name',
                          labelText: 'Last Name*',
                          labelStyle:
                              TextStyles.tsBody1(color: Palettes.kcNeutral1),
                          enabledBorder: TextBorderStyles.normalBorder,
                          focusedBorder: TextBorderStyles.focusedBorder,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            model.setGenderValue(model.genderTxtController),
                        child: TextFormField(
                          controller: model.genderTxtController,
                          autovalidateMode: AutovalidateMode.always,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) =>
                              model.validatorService.validateGender(value!),
                          textInputAction: TextInputAction.next,
                          enabled: false,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              errorBorder: TextBorderStyles.errorBorder,
                              errorStyle: TextStyles.errorTextStyle,
                              disabledBorder: TextBorderStyles.normalBorder,
                              hintText: 'Select Gender',
                              labelText: 'Gender*',
                              // disabledBorder: ,
                              labelStyle: TextStyles.tsBody1(
                                  color: Palettes.kcNeutral1),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                size: 24,
                                color: Palettes.kcBlueMain1,
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => model
                            .setBirthDateValue(model.birthDateTxtController),
                        child: TextFormField(
                          controller: model.birthDateTxtController,
                          autovalidateMode: AutovalidateMode.always,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) =>
                              model.validatorService.validateDate(value!),
                          textInputAction: TextInputAction.next,
                          enabled: false,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              errorBorder: TextBorderStyles.errorBorder,
                              errorStyle: TextStyles.errorTextStyle,
                              disabledBorder: TextBorderStyles.normalBorder,
                              hintText: 'Enter Birthdate',
                              labelText: 'Birthdate*',
                              // disabledBorder: ,
                              labelStyle: TextStyles.tsBody1(
                                  color: Palettes.kcNeutral1),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                size: 24,
                                color: Palettes.kcBlueMain1,
                              )),
                        ),
                      ),
                      TextFormField(
                        controller: model.phoneTxtController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) =>
                            model.validatorService.validatePhoneNumber(value!),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11),
                        ],
                        decoration: InputDecoration(
                          hintText: '09xxxxxxxxx',
                          labelText: 'Contact Number*',
                          labelStyle:
                              TextStyles.tsBody1(color: Palettes.kcNeutral1),
                          enabledBorder: TextBorderStyles.normalBorder,
                          focusedBorder: TextBorderStyles.focusedBorder,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      TextFormField(
                        controller: model.addressTxtController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) =>
                            model.validatorService.validateAddress(value!),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Address',
                          labelText: 'Address*',
                          labelStyle:
                              TextStyles.tsBody1(color: Palettes.kcNeutral1),
                          enabledBorder: TextBorderStyles.normalBorder,
                          focusedBorder: TextBorderStyles.focusedBorder,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Does this patient have allergies?',
                            style: TextStyles.tsBody3(),
                          ),
                          SizedBox(
                            height: 20,
                            child: Checkbox(
                              value: model.haveAllergies,
                              onChanged: (value) =>
                                  model.setAllergyVisibility(value!),
                              activeColor: Palettes.kcBlueMain1,
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: model.haveAllergies,
                        child: TextFormField(
                          controller: model.allergyTxtController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Enter Allergies',
                            labelText: 'Allergies*',
                            labelStyle:
                                TextStyles.tsBody1(color: Palettes.kcNeutral1),
                            enabledBorder: TextBorderStyles.normalBorder,
                            focusedBorder: TextBorderStyles.focusedBorder,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('In Case of Emergency : (Optional)'),
                            TextFormField(
                              controller:
                                  model.emergencyContactNameTxtController,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                hintText: 'Enter Name',
                                labelText: 'Emergency Contact Name',
                                labelStyle: TextStyles.tsBody1(
                                    color: Palettes.kcNeutral1),
                                enabledBorder: TextBorderStyles.normalBorder,
                                focusedBorder: TextBorderStyles.focusedBorder,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                            TextFormField(
                              controller:
                                  model.emergencyContactNumberTxtController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                              ],
                              decoration: InputDecoration(
                                hintText: '09xxxxxxxxx',
                                labelText: 'Emergency Contact Number',
                                labelStyle: TextStyles.tsBody1(
                                    color: Palettes.kcNeutral1),
                                enabledBorder: TextBorderStyles.normalBorder,
                                focusedBorder: TextBorderStyles.focusedBorder,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: model.noteTxtController,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: 'Enter Notes',
                          labelText: 'Notes (Optional)',
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          labelStyle:
                              TextStyles.tsBody1(color: Palettes.kcNeutral1),
                          enabledBorder: TextBorderStyles.normalBorder,
                          focusedBorder: TextBorderStyles.focusedBorder,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
