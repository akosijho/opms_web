import 'package:flutter/cupertino.dart';
import 'package:opmswebstaff/constants/font_name/font_name.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/ui/views/login/login_view_viewmodel.dart';
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
      // onModelReady: (model) {
      //   // model.listenToConnectivityChanges();
      //   model.getSessionInfo();
      // },
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  width: screenWidth(context),
                  height: screenHeight(context),
                  // color: Palettes.kcBlueMain1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage( 'assets/icons/eye_choice.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: 400,
                          height: 400,
                          margin: EdgeInsets.only(top: 50, bottom: 50),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.4),
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          child: ListView(
                            children: [
                              Form(
                                key: model.loginFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // SizedBox(height: 20.h),
                                    // Align(
                                    //   alignment: Alignment.center,
                                    //   child: Image.asset(
                                    //     'assets/icons/logo1.png',
                                    //     height: 100,
                                    //     width: 100,
                                    //   ),
                                    // ),
                                    SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        // 'EyeChoice Optical Shop',
                                        'Welcome !',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FontNames.gilRoy,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          letterSpacing: 1,
                                          wordSpacing: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 50),
                                    // Align(
                                    //   alignment: Alignment.centerLeft,
                                    //   child: Text(
                                    //     'Login',
                                    //     style: TextStyles.tsHeading3(),
                                    //   ),
                                    // ),
                                    // Align(
                                    //   alignment: Alignment.centerLeft,
                                    //   child: Text(
                                    //     'Enter your email account to login',
                                    //     style: TextStyles.tsHeading4(
                                    //         color: Colors.white),
                                    //   ),
                                    // ),
                                    SizedBox(height: 4.h),

                                    //Email Text Field
                                    TextFormField(
                                      // style: TextStyle(
                                      //   color: Colors.red, // Set your desired text color
                                      // ),
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
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        hintText: 'Your Email Account',
                                        // hintStyle: TextStyle(
                                        //   color: Colors.black, // Set your desired hint text color
                                        // ),
                                        // enabledBorder: TextBorderStyles.whiteBorder,
                                        // focusedBorder: TextBorderStyles.whiteBorder,
                                        prefixIconConstraints:
                                            BoxConstraints(minWidth: 20),
                                        prefixIcon: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          // height: 22.h,
                                          // width: 21.w,
                                          child: SvgPicture.asset(
                                            'assets/icons/Message.svg',
                                            color: emailFocusNode.hasFocus
                                                // ? Palettes.kcBlueMain1
                                                // : Palettes.kcNeutral2,
                                            ? Colors.blue
                                                : Colors.black
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15.h),

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
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          // borderSide: BorderSide(color: Colors.white),
                                        ),
                                        // enabledBorder: TextBorderStyles.normalBorder,
                                        // focusedBorder: TextBorderStyles.whiteBorder,
                                        hintText: 'Your Password',
                                        prefixIconConstraints:
                                            BoxConstraints(minWidth: 20),
                                        prefixIcon: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: SvgPicture.asset(
                                            'assets/icons/Lock.svg',
                                            color: passwordFocusNode.hasFocus
                                                ? Colors.blue
                                                : Colors.black
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
                                        style: TextStyle(
                                            color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Align(
                                      alignment: Alignment.center,
                                      // height: 45,
                                      // width: screenWidth(context),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Set your desired button color
                                        ),
                                        onPressed: () {
                                          model.loginNow(
                                              emailValue: emailController.text,
                                              passwordValue: passwordController.text);
                                        },
                                        child: Text('Login',
                                          style: TextStyle(
                                              fontSize: 30,
                                            color: Colors.white
                                          )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SocialLogin(
                              //   goToRegister: () => model.goToRegisterView(),
                              //   // loginWithGoogle: () => model.loginWithGoogle(),
                              // ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: TextStyles.tsHeading5(),
                                  ),
                                  GestureDetector(
                                    onTap: () => model.goToRegisterView(),
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
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        // Divider(
                        //   color: Colors.white,
                        // ),
                        // Text('Location'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
//
// class SocialLogin extends StatelessWidget {
//   final VoidCallback goToRegister;
//   // final VoidCallback loginWithGoogle;
//   const SocialLogin(
//       {Key? key, required this.goToRegister})
//       : super(key: key);
//   // required this.loginWithGoogle
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.only(top: 15.h),
//       child: Column(
//         children: [
//           // Text(
//           //   'Or login with..',
//           //   style: TextStyles.tsBody2(color: Palettes.kcNeutral2),
//           // ),
//           SizedBox(height: 15.h),
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.center,
//           //   children: [
//           //     GestureDetector(
//           //       onTap: () => loginWithGoogle(),
//           //       child: Container(
//           //         height: 50.h,
//           //         width: 100.w,
//           //         padding: EdgeInsets.all(6.sp),
//           //         decoration: BoxDecoration(
//           //             border: Border.all(color: Palettes.kcNeutral5),
//           //             borderRadius: BorderRadius.circular(10)),
//           //         child: SvgPicture.asset(
//           //           'assets/icons/google.svg',
//           //         ),
//           //       ),
//           //     ),
//           //   ],
//           // ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Don't have an account? ",
//                 style: TextStyles.tsHeading5(),
//               ),
//               GestureDetector(
//                 onTap: () => goToRegister(),
//                 child: Container(
//                   height: 40.h,
//                   alignment: Alignment.center,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border(
//                             bottom: BorderSide(color: Palettes.kcBlueMain2))),
//                     child: Text(
//                       'Register',
//                       style: TextStyle(
//                           fontFamily: FontNames.gilRoy,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 20,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class LoginOverlay extends StatelessWidget {
//   const LoginOverlay({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: 9.5.h,
//       left: 80.w,
//       child: Image(
//         image: AssetImage('assets/images/loginoverlay.png'),
//         height: 210.h,
//         width: 210.w,
//         fit: BoxFit.contain,
//       ),
//     );
//   }
// }
