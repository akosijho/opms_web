import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Palettes.kcBlueMain1,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, left: 5),
                child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/arrow-back.svg')),
              ),
              Image(
                image: AssetImage('assets/images/appointment.png'),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Email Verification Sent!',
                  style: TextStyles.tsHeading2(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5),
                child: Text(
                  'To Use Cagape Dental App you need to verify your Email Account.',
                  style: TextStyles.tsBody1(color: Palettes.kcNeutral2),
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     TextButton(
              //       onPressed: () {},
              //       child: Text('Resend Email Verification'),
              //       style: primaryButtonStyle,
              //     ),
              //     SizedBox(width: 10),
              //     TextButton(
              //       onPressed: () {},
              //       child: Text('Continue Login'),
              //       style: primaryButtonStyle,
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
