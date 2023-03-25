import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/prescription/prescription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PrescriptionCard extends StatelessWidget {
  final Prescription prescription;
  final VoidCallback onViewPrescriptionTap;
  const PrescriptionCard(
      {Key? key,
      required this.prescription,
      required this.onViewPrescriptionTap})
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
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: prescription
                                  .prescriptionItems[index].inscription,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade900,
                              )),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Disp. ',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.grey.shade900,
                              ),
                              children: [
                                TextSpan(
                                  text: prescription
                                      .prescriptionItems[index].subscription,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade900,
                                  ),
                                )
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Sig. ',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.grey.shade900,
                              ),
                              children: [
                                TextSpan(
                                  text: prescription
                                      .prescriptionItems[index].signatura,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade900,
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => Divider(thickness: 1),
                    itemCount: prescription.prescriptionItems.length,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date: ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd()
                            .add_jm()
                            .format(prescription.date.toDateTime()!),
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            InkWell(
              onTap: () => onViewPrescriptionTap(),
              child: Container(
                height: 40,
                padding: EdgeInsets.all(8),
                width: double.maxFinite,
                color: Colors.grey.shade100,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('View Prescription Document'),
                    Icon(
                      Icons.arrow_forward,
                      size: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
