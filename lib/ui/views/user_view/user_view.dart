import 'package:image_network/image_network.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/user_view/user_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/text_border_styles.dart';
import '../../../models/user_model/user_model.dart';

class UserView extends StatefulWidget {
  final UserModel user;
  const UserView({Key? key, required this.user}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
      viewModelBuilder: () => UserViewModel(),
      onModelReady: (model) => model.init(widget.user),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('User Info'),
          actions: [
            TextButton.icon(
              onPressed: () => model.logout(),
              icon: Icon(Icons.logout),
              label: Text('Log Out'),
              style: TextButton.styleFrom(primary: Colors.white),
            )
          ],
        ),
        body: Form(
          key: model.updateUserFormKey,
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Palettes.kcBlueMain1,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: () => model.updateUserImage(),
                        child: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(1, 1),
                                    )
                                  ]),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: ImageNetwork(
                                    image: model.currentUser!.image,
                                    height: 100,
                                    width: 100,
                                    fitWeb: BoxFitWeb.cover,
                                  )),
                            ),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    border: Border.all(
                                        color: Colors.grey.shade50, width: 1),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 20,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15),
                            child: Text(
                              model.currentUser!.fullName,
                              style: TextStyles.tsHeading4(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton2<String>(
                            value: model.currentUser!.active_status,
                            onChanged: (value) => model.setActiveStatus(value!),
                            items: model.activeStatus
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            style: TextStyles.tsButton1(color: Colors.purple),
                            focusColor: Colors.deepPurpleAccent,
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                            alignment: Alignment.centerRight,
                            buttonDecoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        model.currentUser!.email,
                        style: TextStyles.tsBody2(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    TextFormField(
                      controller: model.firstNameController,
                      validator: (value) =>
                          model.validatorService.validateFirstName(value!),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Your first name',
                        labelText: 'First Name*',
                        labelStyle:
                            TextStyles.tsBody1(color: Palettes.kcNeutral1),
                        enabledBorder: TextBorderStyles.normalBorder,
                        focusedBorder: TextBorderStyles.focusedBorder,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: model.lastNameController,
                      validator: (value) =>
                          model.validatorService.validateLastName(value!),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter your last name',
                        labelText: 'Last Name*',
                        labelStyle:
                            TextStyles.tsBody1(color: Palettes.kcNeutral1),
                        enabledBorder: TextBorderStyles.normalBorder,
                        focusedBorder: TextBorderStyles.focusedBorder,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: model.phoneNumController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => model.setBirthDateValue(),
                      child: TextFormField(
                        controller: model.dateOfBirthController,
                        enabled: false,
                        validator: (value) =>
                            model.validatorService.validateDate(value!),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            errorBorder: TextBorderStyles.errorBorder,
                            errorStyle: TextStyles.errorTextStyle,
                            disabledBorder: TextBorderStyles.normalBorder,
                            hintText: 'MM/DD/YYYY',
                            labelText: 'Date of Birth*',
                            // disabledBorder: ,
                            labelStyle:
                                TextStyles.tsBody1(color: Palettes.kcNeutral1),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: SvgPicture.asset(
                              'assets/icons/Calendar.svg',
                              color: Palettes.kcBlueMain1,
                              fit: BoxFit.scaleDown,
                            )),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => model.setGenderValue(),
                      child: TextFormField(
                        controller: model.genderController,
                        validator: (value) =>
                            model.validatorService.validateGender(value!),
                        textInputAction: TextInputAction.next,
                        enabled: false,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            errorBorder: TextBorderStyles.errorBorder,
                            errorStyle: TextStyles.errorTextStyle,
                            disabledBorder: TextBorderStyles.normalBorder,
                            hintText: 'Your Gender',
                            labelText: 'Gender*',
                            // disabledBorder: ,
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
                      onTap: () => model.setPositionValue(),
                      child: TextFormField(
                        controller: model.positionController,
                        enabled: false,
                        validator: (value) =>
                            model.validatorService.validatePosition(value!),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            errorBorder: TextBorderStyles.errorBorder,
                            errorStyle: TextStyles.errorTextStyle,
                            disabledBorder: TextBorderStyles.normalBorder,
                            hintText: 'Your Position in the company',
                            labelText: 'Position*',
                            // disabledBorder: ,
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
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () => model.updateUserInfo(),
                              icon: Icon(Icons.update),
                              label: Text('Update',
                              style: TextStyle(
                                fontSize: 14
                              )
                              )),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
