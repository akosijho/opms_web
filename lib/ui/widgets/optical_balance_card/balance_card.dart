import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/balance_notes/balance_notes.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../models/patient_model/patient_model.dart';

class BalanceCard extends StatelessWidget {
  final BalanceNotes balanceNotes;
  final Patient patient;
  const BalanceCard(
      {Key? key, required this.patient,
        required this.balanceNotes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          patient.fullName,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        balanceNotes.balance.toCurrency ?? 'Not Set',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    DateFormat.yMMMd()
                        .add_jm()
                        .format(balanceNotes.date.toDateTime()!),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(height: 8),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(4),
                  //     color: Colors.amber.shade900,
                  //   ),
                  //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       SvgPicture.asset(
                  //         'assets/icons/tooth_icon.svg',
                  //         height: 14,
                  //         width: 14,
                  //         fit: BoxFit.fitWidth,
                  //       ),
                  //       SizedBox(width: 6),
                  //       Text(
                  //         dentalNote.selectedTooth,
                  //         overflow: TextOverflow.ellipsis,
                  //         style: GoogleFonts.roboto(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 4),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(4),
                  //     color: Palettes.kcBlueMain1,
                  //   ),
                  //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Icon(
                  //         Icons.medical_services,
                  //         color: Colors.white,
                  //         size: 14,
                  //       ),
                  //       SizedBox(width: 6),
                  //       Text(
                  //         opticalNote.service.serviceName,
                  //         overflow: TextOverflow.ellipsis,
                  //         style: GoogleFonts.poppins(
                  //           fontSize: 10,
                  //           color: Colors.white,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: balanceNotes.isPaid
                          ? Palettes.kcBlueMain1
                          : Palettes.kcHintColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.payment,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 6),
                        Text(
                          balanceNotes.isPaid ? 'Paid' : 'Not Paid',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
