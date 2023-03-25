import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/dental_notes/dental_notes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_styles.dart';

class PaymentDentalNoteCard extends StatelessWidget {
  final DentalNotes dentalNote;
  final String patientID;
  const PaymentDentalNoteCard(
      {Key? key, required this.dentalNote, required this.patientID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(1, 1),
            spreadRadius: 2,
            blurRadius: 1),
        BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(-1, -1),
            spreadRadius: 2,
            blurRadius: 1),
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 28,
                        child: Row(
                          children: [
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Tooth Number : ',
                                  style: TextStyles.tsButton1(),
                                )),
                            Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  color: Palettes.kcBlueMain1,
                                  borderRadius: BorderRadius.circular(2)),
                              child: Center(
                                child: Text(
                                  dentalNote.selectedTooth,
                                  softWrap: true,
                                  style: TextStyles.tsHeading4(
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      RichText(
                          text: TextSpan(
                              text: 'Procedure: ',
                              style: TextStyles.tsButton2(
                                  color: Colors.grey.shade700),
                              children: [
                            TextSpan(
                                text: dentalNote.procedure.procedureName,
                                style:
                                    TextStyles.tsHeading5(color: Colors.black))
                          ])),
                      SizedBox(height: 4),
                      RichText(
                          text: TextSpan(
                              text: 'Date Rendered: ',
                              style: TextStyles.tsButton2(
                                  color: Colors.grey.shade700),
                              children: [
                            TextSpan(
                                text: DateFormat.yMd()
                                    .add_jm()
                                    .format(dentalNote.date.toDateTime()!),
                                style:
                                    TextStyles.tsHeading5(color: Colors.black))
                          ])),
                      SizedBox(height: 4),
                      RichText(
                          text: TextSpan(
                              text: 'Amount: ',
                              style: TextStyles.tsButton2(
                                  color: Colors.deepOrange),
                              children: [
                            TextSpan(
                                text: dentalNote.procedure.priceToCurrency,
                                style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontSize: 16))
                          ])),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                color: Colors.red.shade800,
                child: Text(
                  'X',
                  style: TextStyles.tsButton1(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
