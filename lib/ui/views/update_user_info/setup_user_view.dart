import 'dart:io';

import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/update_user_info/setup_user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class SetUpUserView extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? userPhoto;
  SetUpUserView({Key? key, this.firstName, this.lastName, this.userPhoto})
      : super(key: key);

  @override
  State<SetUpUserView> createState() => _SetUpUserViewState();
}

class _SetUpUserViewState extends State<SetUpUserView> {
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final positionController = TextEditingController();
  final phoneNumController = TextEditingController();

  @override
  void dispose() {
    dateOfBirthController.dispose();
    genderController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    positionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    firstNameController.text = widget.firstName ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupUserViewModel>.reactive(
      viewModelBuilder: () => SetupUserViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          // bottomSheet: Container(
          //   height: 50,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     border: Border(top: BorderSide(color: Palettes.kcNeutral5)),
          //   ),
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       if (model.setupFormKey.currentState!.validate()) {
          //         if (model.selectedImage == null) {
          //           model.snackBarService.showSnackBar(
          //               message:
          //                   'Error: No Profile Image Selected. Please Try Again!',
          //               title: 'Missing Required Data');
          //         } else {
          //           model.saveUser(
          //             firstNameController.text,
          //             lastNameController.text,
          //             model.selectedBirthDate.toString(),
          //             model.selectedGender,
          //             positionController.text,
          //             phoneNumController.text,
          //           );
          //         }
          //       }
          //     },
          //     child: Text('Save'),
          //   ),
          // ),
          body: SingleChildScrollView(
            child: Container(
              color: Palettes.kcBlueMain1,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Center(
                child:
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: 600,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all( Radius.circular(30))),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Header(),
                            SizedBox(height: 20),
                            Text(
                              'Profile Picture*',
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Palettes.kcLightGreyAccentColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Palettes.kcNeutral3,
                                      blurRadius: 3,
                                      offset: Offset(1, 2))
                                ],
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: model.selectImageSource,
                                icon: model.selectedImage != null
                                    ? CircleAvatar(
                                        radius: 59,
                                        backgroundColor:
                                            Palettes.kcLightGreyAccentColor,
                                        backgroundImage: FileImage(
                                          File(model.selectedImage!.path),
                                        ),
                                      )
                                    : SvgPicture.asset(
                                        'assets/icons/Camera.svg',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),

                            //Form for Setup Info
                            Form(
                                key: model.setupFormKey,
                                child: Column(
                                  children: [
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: firstNameController,
                                      validator: (value) => model.validatorService
                                          .validateFirstName(value!),
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: 'Your first name',
                                        labelText: 'First Name*',
                                        labelStyle: TextStyles.tsBody1(
                                            color: Palettes.kcNeutral1),
                                        enabledBorder: TextBorderStyles.normalBorder,
                                        focusedBorder: TextBorderStyles.focusedBorder,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      controller: lastNameController,
                                      validator: (value) => model.validatorService
                                          .validateLastName(value!),
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your last name',
                                        labelText: 'Last Name*',
                                        labelStyle: TextStyles.tsBody1(
                                            color: Palettes.kcNeutral1),
                                        enabledBorder: TextBorderStyles.normalBorder,
                                        focusedBorder: TextBorderStyles.focusedBorder,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      controller: phoneNumController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      textCapitalization: TextCapitalization.words,
                                      enableInteractiveSelection: false,
                                      validator: (value) => model.validatorService
                                          .validatePhoneNumber(value!),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(11),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: '09xxxxxxxxx',
                                        labelText: 'Contact Number*',
                                        labelStyle: TextStyles.tsBody1(
                                            color: Palettes.kcNeutral1),
                                        enabledBorder: TextBorderStyles.normalBorder,
                                        focusedBorder: TextBorderStyles.focusedBorder,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () => model
                                          .setBirthDateValue(dateOfBirthController),
                                      child: TextFormField(
                                        controller: dateOfBirthController,
                                        enabled: false,
                                        validator: (value) => model.validatorService
                                            .validateDate(value!),
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.datetime,
                                        decoration: InputDecoration(
                                            errorBorder: TextBorderStyles.errorBorder,
                                            errorStyle: TextStyles.errorTextStyle,
                                            disabledBorder:
                                                TextBorderStyles.normalBorder,
                                            hintText: 'MM/DD/YYYY',
                                            labelText: 'Date of Birth*',
                                            // disabledBorder: ,
                                            labelStyle: TextStyles.tsBody1(
                                                color: Palettes.kcNeutral1),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            suffixIcon: SvgPicture.asset(
                                              'assets/icons/Calendar.svg',
                                              color: Palettes.kcBlueMain1,
                                              fit: BoxFit.scaleDown,
                                            )),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () =>
                                          model.setGenderValue(genderController),
                                      child: TextFormField(
                                        controller: genderController,
                                        validator: (value) => model.validatorService
                                            .validateGender(value!),
                                        textInputAction: TextInputAction.next,
                                        enabled: false,
                                        keyboardType: TextInputType.datetime,
                                        decoration: InputDecoration(
                                            errorBorder: TextBorderStyles.errorBorder,
                                            errorStyle: TextStyles.errorTextStyle,
                                            disabledBorder:
                                                TextBorderStyles.normalBorder,
                                            hintText: 'Your Gender',
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
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () =>
                                          model.setPositionValue(positionController),
                                      child: TextFormField(
                                        controller: positionController,
                                        enabled: false,
                                        validator: (value) => model.validatorService
                                            .validatePosition(value!),
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.datetime,
                                        decoration: InputDecoration(
                                            errorBorder: TextBorderStyles.errorBorder,
                                            errorStyle: TextStyles.errorTextStyle,
                                            disabledBorder:
                                                TextBorderStyles.normalBorder,
                                            hintText: 'Your Position in the company',
                                            labelText: 'Position*',
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

                                  ],
                                )),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(top: BorderSide(color: Palettes.kcNeutral5)),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              if (model.setupFormKey.currentState!.validate()) {
                                if (model.selectedImage == null) {
                                  model.snackBarService.showSnackBar(
                                      message:
                                      'Error: No Profile Image Selected. Please Try Again!',
                                      title: 'Missing Required Data');
                                } else {
                                  model.saveUser(
                                    firstNameController.text,
                                    lastNameController.text,
                                    model.selectedBirthDate.toString(),
                                    model.selectedGender,
                                    positionController.text,
                                    phoneNumController.text,
                                  );
                                }
                              }
                            },
                            child: Text('Save',
                            style: TextStyle(
                              fontSize: 20
                            ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

              ),
            ),
          ),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            // child: SvgPicture.asset('assets/icons/arrow-back.svg'),
            child: Text(
              'Account setup',
              style: TextStyles.tsHeading4(color: Palettes.kcNeutral1),
            ),
          ),
        ),
        SizedBox(height: 1),
        Text(
          'Setup User Information!',
          style: TextStyles.tsHeading2(),
        ),
      ],
    );
  }
}
