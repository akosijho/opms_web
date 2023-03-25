import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeShortcut extends StatelessWidget {
  final VoidCallback? addProcedureOnTap;
  final VoidCallback? addPatientOnTap;
  final VoidCallback? addMedicineOnTap;
  final VoidCallback? financeOnTap;
  final VoidCallback? addPaymentOnTap;
  final VoidCallback? addExpensesOnTap;

  const HomeShortcut(
      {Key? key,
      this.addProcedureOnTap,
      this.addPatientOnTap,
      this.addMedicineOnTap,
      this.financeOnTap,
      this.addPaymentOnTap,
      this.addExpensesOnTap
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: Container(
        //     height: 150,
        //     decoration: BoxDecoration(
        //         color: Palettes.kcBlueMain1,
        //         borderRadius: BorderRadius.only(
        //             bottomLeft: Radius.circular(30),
        //             bottomRight: Radius.circular(30))),
        //   ),
        // ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   'EyeChoice Optical Shop',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Colors.white,
            //       fontWeight: FontWeight.w700, fontSize: 25),
            // ),
            // Text(
            //   'Optical Shop',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Colors.white,
            //       fontWeight: FontWeight.w400, fontSize: 17),
            // ),
            // Image.asset(
            //   'assets/icons/logo_opms_circle.png',
            //   height: 80,
            //   width: 80,
            // ),
            // SizedBox(height: 4),
            // Text(
            //   'EyeChoice Optical Shop',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontFamily: FontNames.gilRoy,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 30,
            //     letterSpacing: 1,
            //     wordSpacing: 1,
            //     color: Palettes.kcBlueMain1,
            //   ),
            // ),
            SizedBox(height: 5),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/Star Line.svg',
                  height: 20,
                  width: 20,
                    color: Palettes.kcNeutral1
                ),
                SizedBox(width: 2),
                Text(
                  'Shortcuts',
                  style: TextStyles.tsHeading4(color: Palettes.kcNeutral1),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(0, 1))
                  ]),
              child: Material(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => this.addProcedureOnTap!(),
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/Plus.svg',
                                      height: 25,
                                      width: 25,
                                      color: Palettes.kcDarkerBlueMain1,
                                    ),
                                    SizedBox(height: 5),
                                    Text('Add Service',
                                        style: TextStyles.tsBody4())
                                  ],
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(width: 1),
                          Expanded(
                            child: InkWell(
                              onTap: () => addExpensesOnTap!(),
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/Ticket.svg',
                                      height: 25,
                                      width: 25,
                                      color: Palettes.kcDarkerBlueMain1,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Add Expenses',
                                      style: TextStyles.tsBody4(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(width: 1),
                          Expanded(
                            child: InkWell(
                              onTap: () => addMedicineOnTap!(),
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/Pills.svg',
                                      height: 25,
                                      width: 25,
                                      color: Palettes.kcDarkerBlueMain1,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Add Products',
                                      style: TextStyles.tsBody4(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => financeOnTap!(),
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/Graph.svg',
                                      height: 25,
                                      width: 25,
                                      color: Palettes.kcDarkerBlueMain1,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Reports',
                                      style: TextStyles.tsBody4(),

                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(width: 1),
                          Expanded(
                            child: InkWell(
                              onTap: addPaymentOnTap,
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/Wallet.svg',
                                      height: 25,
                                      width: 25,
                                      color: Palettes.kcDarkerBlueMain1,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Add Payment',
                                      style: TextStyles.tsBody4(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(width: 1),
                          Expanded(
                            child: InkWell(
                              onTap: addPatientOnTap,
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/Clients.svg',
                                      height: 25,
                                      width: 25,
                                      color: Palettes.kcDarkerBlueMain1,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Add Patient',
                                      style: TextStyles.tsBody4(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
