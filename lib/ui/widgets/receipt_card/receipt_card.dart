// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:opmswebstaff/extensions/string_extension.dart';
// import 'package:opmswebstaff/models/optical_certificate/optical_certificate.dart';
// import 'package:opmswebstaff/models/optical_receipt/optical_receipt.dart';
//
// class ReceiptCard extends StatelessWidget {
//   final OpticalReceipt opticalReceipt;
//   final VoidCallback onViewRecTap;
//   const ReceiptCard(
//       {Key? key, required this.opticalReceipt, required this.onViewRecTap})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.zero,
//       ),
//       child: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Optical Receipt on: ',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.grey.shade900,
//                     ),
//                   ),
//                   Text(
//                     '${opticalCertificate.service}',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey.shade900,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   Divider(
//                     thickness: 1,
//                     height: 1,
//                     color: Colors.grey,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Date: ',
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           color: Colors.grey.shade900,
//                         ),
//                       ),
//                       Text(
//                         DateFormat.yMMMd()
//                             .add_jm()
//                             .format(opticalCertificate.date.toDateTime()!),
//                         style: GoogleFonts.robotoCondensed(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey.shade900,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Divider(
//               height: 1,
//               thickness: 1,
//               color: Colors.grey.shade300,
//             ),
//             InkWell(
//               onTap: () => onViewCertTap(),
//               child: Container(
//                 height: 40,
//                 padding: EdgeInsets.all(8),
//                 width: double.maxFinite,
//                 color: Colors.grey.shade100,
//                 alignment: Alignment.centerRight,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text('View Certificate Document'),
//                     Icon(
//                       Icons.arrow_forward,
//                       size: 20,
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
