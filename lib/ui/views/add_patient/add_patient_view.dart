import 'dart:io';

import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/add_patient/add_patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class AddPatientView extends StatefulWidget {
  const AddPatientView({Key? key}) : super(key: key);

  @override
  State<AddPatientView> createState() => _AddPatientViewState();
}

class _AddPatientViewState extends State<AddPatientView> {
  final addPatientFormKey = GlobalKey<FormState>();
  final firstNameTxtController = TextEditingController();
  final lastNameTxtController = TextEditingController();
  final genderTxtController = TextEditingController();
  final birthDateTxtController = TextEditingController();
  final phoneTxtController = TextEditingController();
  final addressTxtController = TextEditingController();
  final allergyTxtController = TextEditingController();
  final noteTxtController = TextEditingController();
  final emergencyContactName = TextEditingController();
  final emergencyContactNumber = TextEditingController();

  @override
  void dispose() {
    firstNameTxtController.dispose();
    lastNameTxtController.dispose();
    genderTxtController.dispose();
    birthDateTxtController.dispose();
    phoneTxtController.dispose();
    addressTxtController.dispose();
    allergyTxtController.dispose();
    noteTxtController.dispose();
    emergencyContactName.dispose();
    emergencyContactNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPatientViewModel>.reactive(
      viewModelBuilder: () => AddPatientViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add New Patient',
            style: TextStyles.tsHeading3(color: Colors.white),
          ),
        ),
        persistentFooterButtons: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                if (addPatientFormKey.currentState!.validate()) {
                  model.savePatient(
                    firstName: firstNameTxtController.text,
                    lastName: lastNameTxtController.text,
                    gender: genderTxtController.text,
                    birthDate: model.tempBirthDate.toString(),
                    phoneNum: phoneTxtController.text,
                    address: addressTxtController.text,
                    allergies: allergyTxtController.text,
                    emergencyContactName: emergencyContactName.text,
                    emergencyContactNumber: emergencyContactNumber.text,
                  );
                } else {
                  model.autoValidate = true;
                  model.notifyListeners();
                }
              },
              child: Text('Save',
                style: TextStyle(
                  fontSize: 16
              ),),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Form(
            key: addPatientFormKey,
            child: Column(
              children: [
                // AddPatientHeader(
                //   onTap: () => model.selectPatientImage(),
                //   filePath: model.patientSelectedImage?.path,
                // ),
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/images/optical_avatar.png'),
                  ),
                  // child: filePath != null
                  //     ? CircleAvatar(
                  //         backgroundImage: FileImage(File(filePath!)),
                  //       )
                  //     : CircleAvatar(
                  //         backgroundImage:
                  //             AssetImage('assets/images/optical_avatar.png'),
                  //       ),

                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: firstNameTxtController,
                        autovalidateMode: model.autoValidate
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
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
                        controller: lastNameTxtController,
                        autovalidateMode: model.autoValidate
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
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
                        onTap: () => model.setGenderValue(genderTxtController),
                        child: TextFormField(
                          controller: genderTxtController,
                          autovalidateMode: model.autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
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
                        onTap: () =>
                            model.setBirthDateValue(birthDateTxtController),
                        child: TextFormField(
                          controller: birthDateTxtController,
                          autovalidateMode: model.autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
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
                        controller: phoneTxtController,
                        autovalidateMode: model.autoValidate
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        textCapitalization: TextCapitalization.words,
                        enableInteractiveSelection: false,
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
                        controller: addressTxtController,
                        autovalidateMode: model.autoValidate
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
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
                          controller: allergyTxtController,
                          autovalidateMode: model.autoValidate
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
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
                      // SizedBox(height: 10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('Medical History'),
                      //     ElevatedButton(
                      //         onPressed: () => model.selectMedicalHistoryFile(),
                      //         style: ElevatedButton.styleFrom(
                      //             primary: Palettes.kcBlueMain2),
                      //         child: Text(
                      //           'Add Medical History',
                      //           style: TextStyles.tsBody3(color: Colors.white),
                      //         ))
                      //   ],
                      // ),
                      SizedBox(height: 10),
                      Visibility(
                          visible: model.listOfMedicalHistory.isNotEmpty
                              ? true
                              : false,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)),
                            child: Wrap(
                              runSpacing: 8,
                              spacing: 8,
                              children: model.listOfMedicalHistory
                                  .map((e) => Stack(
                                        children: [
                                          Image(
                                              height: 150,
                                              width: 80,
                                              fit: BoxFit.cover,
                                              image: FileImage(File(e.path))),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                model.listOfMedicalHistory
                                                    .remove(e);
                                                model.notifyListeners();
                                              },
                                              child: Container(
                                                width: 15,
                                                height: 15,
                                                alignment: Alignment.center,
                                                color: Colors.red,
                                                child: Text(
                                                  'X',
                                                  style: TextStyles.tsBody4(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                  .toList(),
                            ),
                          )),
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
                              controller: emergencyContactName,
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
                              controller: emergencyContactNumber,
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
                        controller: noteTxtController,
                        textInputAction: TextInputAction.done,
                        maxLines: 3,
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

class AddPatientHeader extends StatelessWidget {
  final VoidCallback onTap;
  final String? filePath;

  const AddPatientHeader({Key? key, required this.onTap, this.filePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 55,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            color: Palettes.kcBlueMain1,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () => onTap(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade50,
                            width: 4,
                          ),
                          shape: BoxShape.circle),
                      child: Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundImage:
                          AssetImage('assets/images/optical_avatar.png'),
                        ),
                        // child: filePath != null
                        //     ? CircleAvatar(
                        //         backgroundImage: FileImage(File(filePath!)),
                        //       )
                        //     : CircleAvatar(
                        //         backgroundImage:
                        //             AssetImage('assets/images/optical_avatar.png'),
                        //       ),

                      ),
                    ),
                  ),
                  // Positioned(
                  //   right: 0,
                  //   bottom: 5,
                  //   child: GestureDetector(
                  //     onTap: () => this.onTap(),
                  //     child: Container(
                  //       height: 35,
                  //       width: 35,
                  //       padding: EdgeInsets.all(5),
                  //       decoration: BoxDecoration(
                  //         border:
                  //             Border.all(color: Colors.grey.shade50, width: 2),
                  //         shape: BoxShape.circle,
                  //         color: Colors.grey.shade300,
                  //       ),
                  //       child: SvgPicture.asset('assets/icons/Camera.svg'),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
