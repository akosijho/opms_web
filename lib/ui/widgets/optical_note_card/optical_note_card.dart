
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/optical_notes/optical_notes.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../models/patient_model/patient_model.dart';

class OpticalNoteCard extends StatelessWidget {
  final OpticalNotes opticalNote;
  final Patient patient;
  const OpticalNoteCard(
      {Key? key, required this.opticalNote, required this.patient})
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
            // Container(
            //   // height: 100,
            //   // width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(100),
            //       border: Border.all(color: Colors.grey.shade200, width: 2)),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(100),
            //     child: Image.asset(
            //       "assets/images/optical_avatar.png",
            //       // imageUrl: image,
            //       fit: BoxFit.fill,
            //       filterQuality:  FilterQuality.high,
            //       // progressIndicatorBuilder: (context, url, progress) =>
            //       //     CircularProgressIndicator(
            //       //       value: progress.progress,
            //       //       valueColor: AlwaysStoppedAnimation(
            //       //         Colors.white,
            //       //       ),
            //       //     )
            //     ),
            //     // child: CachedNetworkImage(
            //     //   imageUrl: patient.image,
            //     //   height: 50,
            //     //   width: 50,
            //     //   fit: BoxFit.cover,
            //     // ),
            //   ),
            // ),
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
                        opticalNote.service.priceToCurrency ?? 'Not Set',
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
                        .format(opticalNote.date.toDateTime()!),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Palettes.kcBlueMain1,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.medical_services,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 6),
                        Text(
                          opticalNote.service.serviceName,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: opticalNote.isPaid
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
                          opticalNote.isPaid ? 'Paid' : 'Not Paid',
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
