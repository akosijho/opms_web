import 'package:opmsapp/constants/font_name/font_name.dart';
import 'package:opmsapp/constants/styles/palette_color.dart';
import 'package:opmsapp/constants/styles/text_border_styles.dart';
import 'package:opmsapp/constants/styles/text_styles.dart';
import 'package:opmsapp/ui/views/login/login_view_viewmodel.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    debugPrint('login_view.dart was disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
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
                  DoubleBackToCloseApp(
                    snackBar: SnackBar(
                      content: Text('Press back again to exit'),
                      duration: Duration(seconds: 1),
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 150.h),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(65),
                      ),
                    ),
                    child: ListView(
                      children: [
                        Form(
                          key: model.loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 20.h),
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/icons/logo-blue-circle.png',
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
                                    fontSize: 16.sp,
                                    letterSpacing: 1,
                                    wordSpacing: 1,
                                    color: Palettes.kcBlueMain1,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Login',
                                  style: TextStyles.tsHeading3(),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Enter your email account to login',
                                  style: TextStyles.tsHeading4(
                                      color: Palettes.kcNeutral2),
                                ),
                              ),
                              SizedBox(height: 4.h),

                              //Email Text Field
                              TextFormField(
                                controller: emailController,
                                focusNode: emailFocusNode,
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode: model.autoValidate
                                    ? AutovalidateMode.onUserInteraction
                                    : AutovalidateMode.disabled,
                                validator: (value) => model.validatorService
                                    .validateEmailAddress(value!.trim()),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Your Email Account',
                                  enabledBorder: TextBorderStyles.normalBorder,
                                  focusedBorder: TextBorderStyles.focusedBorder,
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 20),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 22.h,
                                    width: 21.w,
                                    child: SvgPicture.asset(
                                      'assets/icons/Message.svg',
                                      color: emailFocusNode.hasFocus
                                          ? Palettes.kcBlueMain1
                                          : Palettes.kcNeutral2,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),

                              //Password Text Field
                              TextFormField(
                                controller: passwordController,
                                focusNode: passwordFocusNode,
                                obscureText: model.isObscure,
                                autovalidateMode: model.autoValidate
                                    ? AutovalidateMode.onUserInteraction
                                    : AutovalidateMode.disabled,
                                textInputAction: TextInputAction.go,
                                onChanged: (value) =>
                                    model.setShowIconVisibility(
                                        passwordController.text),
                                onEditingComplete: () => model.loginNow(
                                    emailValue: emailController.text,
                                    passwordValue: passwordController.text),
                                validator: (value) => model.validatorService
                                    .validatePassword(value!),
                                decoration: InputDecoration(
                                  enabledBorder: TextBorderStyles.normalBorder,
                                  focusedBorder: TextBorderStyles.focusedBorder,
                                  hintText: 'Your Password',
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 20),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: SvgPicture.asset(
                                      'assets/icons/Lock.svg',
                                      color: passwordFocusNode.hasFocus
                                          ? Palettes.kcBlueMain1
                                          : Palettes.kcNeutral2,
                                    ),
                                  ),
                                  suffixIcon: Visibility(
                                    visible: model.isShowIconVisible,
                                    child: IconButton(
                                        onPressed: model.showHidePassword,
                                        padding: EdgeInsets.zero,
                                        icon: SvgPicture.asset(
                                          model.isObscure
                                              ? 'assets/icons/Show.svg'
                                              : 'assets/icons/Hide.svg',
                                          color: Palettes.kcBlueMain1,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Forgot Password?',
                                  textAlign: TextAlign.end,
                                  style: TextStyles.tsHeading5(
                                      color: Palettes.kcNeutral2),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Container(
                                height: 45.sp,
                                width: screenWidth(context),
                                child: ElevatedButton(
                                  onPressed: () {
                                    model.loginNow(
                                        emailValue: emailController.text,
                                        passwordValue: passwordController.text);
                                  },
                                  child: Text('Login'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SocialLogin(
                          goToRegister: () => model.goToRegisterView(),
                          loginWithGoogle: () => model.loginWithGoogle(),
                        ),
                      ],
                    ),
                  ),
                  LoginOverlay()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SocialLogin extends StatelessWidget {
  final VoidCallback goToRegister;
  final VoidCallback loginWithGoogle;
  const SocialLogin(
      {Key? key, required this.goToRegister, required this.loginWithGoogle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 15.h),
      child: Column(
        children: [
          Text(
            'Or login with..',
            style: TextStyles.tsBody2(color: Palettes.kcNeutral2),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => loginWithGoogle(),
                child: Container(
                  height: 50.h,
                  width: 100.w,
                  padding: EdgeInsets.all(6.sp),
                  decoration: BoxDecoration(
                      border: Border.all(color: Palettes.kcNeutral5),
                      borderRadius: BorderRadius.circular(10)),
                  child: SvgPicture.asset(
                    'assets/icons/google.svg',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
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
                      'Register',
                      style: TextStyle(
                          fontFamily: FontNames.gilRoy,
                          fontWeight: FontWeight.w600,
                          fontSize: kfsHeading5.sp,
                          color: Palettes.kcBlueMain2),
                    ),
                  ),
                ),
              )
            ],
          )
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
      top: 9.5.h,
      left: 80.w,
      child: Image(
        image: AssetImage('assets/images/loginoverlay.png'),
        height: 210.h,
        width: 210.w,
        fit: BoxFit.contain,
      ),
    );
  }
}
