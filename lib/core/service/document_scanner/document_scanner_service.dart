// import 'dart:io';
//
// import 'package:document_scanner_flutter/configs/configs.dart';
// import 'package:document_scanner_flutter/document_scanner_flutter.dart';
// import 'package:flutter/material.dart';
//
// class DocumentScannerService {
//   Future<File?> scanImageToPDF(
//     BuildContext context,
//   ) async {
//     try {
//       var androidLabelsConfigs = {
//         ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next",
//         ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_SINGLE: "Only 1 Page",
//         ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_MULTIPLE:
//             "Only {PAGES_COUNT} Page"
//       };
//
//       return await DocumentScannerFlutter.launchForPdf(context,
//           labelsConfig: androidLabelsConfigs);
//     } catch (e) {
//       return null;
//     }
//   }
// }
