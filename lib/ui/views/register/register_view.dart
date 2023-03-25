import 'package:opmswebstaff/constants/font_name/font_name.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/ui/views/register/register_view.form.dart';
import 'package:opmswebstaff/ui/views/register/register_view_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
  FormTextField(name: 'confirmPass'),
])
class RegisterView extends StatelessWidget with $RegisterView {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      onDispose: (model) {
        disposeForm();
        model.log.d('form disposed');
      },
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              width: screenWidth(context),
              height: screenHeight(context),
              color: Palettes.kcBlueMain1,
              child: Stack(
                children: [
                  // IconButton(
                  //   onPressed: () {
                  //     model.navigationService.pop();
                  //   },
                  //   color: Colors.white,
                  //   icon: SvgPicture.asset(
                  //     'assets/icons/arrow-back-white.svg',
                  //     height: 24,
                  //     width: 24,
                  //   ),
                  // ),
                  Center(
                    child: Container(
                      width: 600,
                      height: double.infinity,
                      margin: EdgeInsets.only(top: 50, bottom: 50),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(65),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 15.h),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/icons/logo_opms_circle.png',
                                height: 80,
                                width: 80,
                              ),
                            ),
                            SizedBox(height: 4),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'EyeChoice Optical Shop',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FontNames.gilRoy,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  letterSpacing: 1,
                                  wordSpacing: 1,
                                  color: Palettes.kcBlueMain1,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            RegisterFields(
                              emailController: emailController,
                              passwordController: passwordController,
                              confirmPassController: confirmPassController,
                              emailFNode: emailFocusNode,
                              passFNode: passwordFocusNode,
                              confirmPassFNode: confirmPassFocusNode,
                              validatorService: model.validatorService,
                              formKey: model.registerFormKey,
                              setShowIconVisibility: model.setShowIconVisibility,
                              isVisible: model.isShowIconVisible,
                              isObscure: model.isObscure,
                              showHidePassword: model.showHidePassword,
                              autoValidate: model.autoValidate,
                              register: () {
                                if (model.registerFormKey.currentState!
                                    .validate()) {
                                  model.registerAccount();
                                } else {
                                  model.setAutoValidate();
                                }
                              },
                            ),
                            SocialLogin(
                              goToRegister: model.goToLogin,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // LoginOverlay()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//Required Fields For Register View
class RegisterFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPassController;
  final FocusNode emailFNode;
  final FocusNode passFNode;
  final FocusNode confirmPassFNode;
  final ValidatorService validatorService;
  final VoidCallback register;
  final formKey;
  final bool isVisible;
  final bool isObscure;
  final VoidCallback showHidePassword;
  final bool autoValidate;
  final VoidCallback setShowIconVisibility;

  const RegisterFields({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPassController,
    required this.emailFNode,
    required this.passFNode,
    required this.confirmPassFNode,
    required this.validatorService,
    required this.register,
    required this.formKey,
    required this.isVisible,
    required this.isObscure,
    required this.showHidePassword,
    required this.autoValidate,
    required this.setShowIconVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Register',
            style: TextStyles.tsHeading3(),
          ),
          SizedBox(height: 2.h),
          Text(
            'Register To Continue',
            style: TextStyles.tsHeading4(color: Palettes.kcNeutral2),
          ),
          SizedBox(height: 15.h),

          //EMAIL TEXT FIELD
          TextFormField(
            controller: emailController,
            focusNode: emailFNode,
            autovalidateMode: autoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => validatorService.validateEmailAddress(value!),
            style: TextStyles.tsBody1(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 5),
              enabledBorder: TextBorderStyles.normalBorder,
              focusedBorder: TextBorderStyles.focusedBorder,
              prefixIconConstraints: BoxConstraints(minWidth: 20),
              prefixIcon: Container(
                margin: EdgeInsets.only(right: 10),

                child: SvgPicture.asset(
                  'assets/icons/Message.svg',
                  color: emailFNode.hasFocus
                      ? Palettes.kcBlueMain1
                      : Palettes.kcNeutral2,
                ),
              ),
              hintText: 'Your Email Account',
              hintStyle: TextStyles.ktsHintTextStyle,
            ),
          ),
          SizedBox(height: 10.h),

          //PASSWORD TEXT FIELD
          TextFormField(
            controller: passwordController,
            focusNode: passFNode,
            autovalidateMode: autoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            validator: (value) => validatorService.validatePassword(value!),
            onEditingComplete: () => confirmPassFNode.requestFocus(),
            onChanged: (value) => setShowIconVisibility(),
            textInputAction: TextInputAction.next,
            obscureText: isObscure,
            style: TextStyles.tsBody1(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 16),
              enabledBorder: TextBorderStyles.normalBorder,
              focusedBorder: TextBorderStyles.focusedBorder,
              prefixIconConstraints: BoxConstraints(minWidth: 20),
              prefixIcon: Container(
                margin: EdgeInsets.only(right: 10),
                // height: 25.h,
                // width: 25.w,
                child: SvgPicture.asset(
                  'assets/icons/Lock.svg',
                  color: passFNode.hasFocus
                      ? Palettes.kcBlueMain1
                      : Palettes.kcNeutral2,
                ),
              ),
              suffixIcon: Visibility(
                visible: isVisible,
                child: IconButton(
                    onPressed: () => showHidePassword(),
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      isObscure
                          ? 'assets/icons/Show.svg'
                          : 'assets/icons/Hide.svg',
                      color: Palettes.kcBlueMain1,
                    )),
              ),
              hintText: 'Your Password',
              hintStyle: TextStyles.ktsHintTextStyle,
            ),
          ),
          SizedBox(height: 20.h),

          //CONFIRM PASS TEXT FIELD
          TextFormField(
            controller: confirmPassController,
            focusNode: confirmPassFNode,
            autovalidateMode: autoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            validator: (value) => validatorService.validateConfirmPassword(
                value!, passwordController.text),
            onChanged: (value) => setShowIconVisibility(),
            textInputAction: TextInputAction.go,
            obscureText: isObscure,
            style: TextStyles.tsBody1(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 16),
              enabledBorder: TextBorderStyles.normalBorder,
              focusedBorder: TextBorderStyles.focusedBorder,
              prefixIconConstraints: BoxConstraints(minWidth: 20),
              prefixIcon: Container(
                margin: EdgeInsets.only(right: 10),
                // height: 25.h,
                // width: 25.w,
                child: SvgPicture.asset(
                  'assets/icons/Lock.svg',
                  color: confirmPassFNode.hasFocus
                      ? Palettes.kcBlueMain1
                      : Palettes.kcNeutral2,
                ),
              ),
              suffixIcon: Visibility(
                visible: isVisible,
                child: IconButton(
                    onPressed: () => showHidePassword(),
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      isObscure
                          ? 'assets/icons/Show.svg'
                          : 'assets/icons/Hide.svg',
                      color: Palettes.kcBlueMain1,
                    )),
              ),
              hintText: 'Confirm Password',
              hintStyle: TextStyles.ktsHintTextStyle,
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            // height: 45,
            width: screenWidth(context),
            child: ElevatedButton(
              onPressed: () => register(),
              child: Text('Register',
                  style: TextStyle(
                  fontSize: 30
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class SocialLogin extends StatelessWidget {
  final VoidCallback goToRegister;

  const SocialLogin({Key? key, required this.goToRegister}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          // Text(
          //   'Or login with..',
          //   style: TextStyles.tsBody2(color: Palettes.kcNeutral2),
          // ),
          // SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // GestureDetector(
              //   onTap: () {},
              //   child: Container(
              //     height: 50.h,
              //     width: 100.w,
              //     padding: EdgeInsets.all(6),
              //     decoration: BoxDecoration(
              //         border: Border.all(color: Palettes.kcNeutral5),
              //         borderRadius: BorderRadius.circular(10)),
              //     child: SvgPicture.asset(
              //       'assets/icons/google.svg',
              //     ),
              //   ),
              // ),
            ],
          ),
          // SizedBox(height: 15.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyles.tsHeading5(),
              ),
              GestureDetector(
                onTap: () => goToRegister(),
                child: Container(
                  height: 40.h,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Palettes.kcBlueMain2))),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontFamily: FontNames.gilRoy,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Palettes.kcBlueMain2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 13.h)
        ],
      ),
    );
  }
}

class LoginOverlay extends StatelessWidget {
  const LoginOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -12.5.h,
      right: 60,
      child: Image(
        image: AssetImage('assets/images/register-overlay.png'),
        height: 180.h,
        width: 180.h,
      ),
    );
  }
}
