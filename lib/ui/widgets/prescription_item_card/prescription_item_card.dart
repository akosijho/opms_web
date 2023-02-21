import 'package:opmsapp/models/prescription/prescription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrescriptionItemCard extends StatelessWidget {
  final PrescriptionItem prescriptionItem;
  const PrescriptionItemCard({Key? key, required this.prescriptionItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prescriptionItem.inscription,
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 17,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Disp.  ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        prescriptionItem.subscription,
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 17,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sig. ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        prescriptionItem.signatura,
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 17,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
