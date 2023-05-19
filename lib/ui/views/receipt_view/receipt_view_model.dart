
import 'dart:io';
import 'dart:typed_data';
// import 'dart:ui';
import 'dart:ui' as ui;
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/pdf_service/pdf_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:opmswebstaff/models/optical_receipt/optical_receipt.dart';
import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:opmswebstaff/models/product/lens.dart';
import 'package:opmswebstaff/models/product/product.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:open_file/open_file.dart';



import '../../../app/app.locator.dart';

class ReceiptViewModel extends BaseViewModel {
  final screenShotController = ScreenshotController();
  Uint8List? imageFile;
  final toastService = locator<ToastService>();
  final snackBarService = locator<SnackBarService>();
  final pdfService = locator<PdfService>();
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();


  GlobalKey globalKey = GlobalKey();

  Future<Uint8List?> captureWidget() async {
    await Future.delayed(Duration(milliseconds: 20)); // Add a small delay
    RenderRepaintBoundary boundary =
    globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image? image = await boundary.toImage(pixelRatio: 2.0);
    if (image != null) {
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      return byteData!.buffer.asUint8List();
    }
    return null;
  }

  Future<File?> saveAsPdf(Uint8List? imageData) async {
    if (imageData == null) return null;

    final pdf = pdfWidgets.Document();

    final image = pdfWidgets.MemoryImage(imageData);
    pdf.addPage(pdfWidgets.Page(build: (pdfWidgets.Context context) {
      return pdfWidgets.Image(image);
    }));

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String pdfPath = '$tempPath/receipt.pdf';

    File pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(await pdf.save());

    return pdfFile;
  }

  void openPdf(File? pdfFile) {
    if (pdfFile != null) {
      OpenFile.open(pdfFile.path);
    }
  }

  // Future<Uint8List?> captureWidget() async {
  //   RenderRepaintBoundary boundary =
  //   globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image? image = await boundary.toImage(pixelRatio: 2.0);
  //   if (image != null) {
  //     ByteData? byteData =
  //     await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  //     return byteData!.buffer.asUint8List();
  //   }
  //   return null;
  // }
  //
  //
  // Future<File?> saveAsPdf(Uint8List? imageData) async {
  //   if (imageData == null) return null;
  //
  //   final pdf = pdfWidgets.Document();
  //
  //   final image = pdfWidgets.MemoryImage(imageData);
  //   pdf.addPage(pdfWidgets.Page(build: (pdfWidgets.Context context) {
  //     return pdfWidgets.Image(image);
  //   }));
  //
  //   Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;
  //   String pdfPath = '$tempPath/receipt.pdf';
  //
  //   File pdfFile = File(pdfPath);
  //   await pdfFile.writeAsBytes(await pdf.save());
  //
  //   return pdfFile;
  // }
  //
  // // void openPdf(File? pdfFile) {
  // //   if (pdfFile != null) {
  // //     OpenFile.open(pdfFile.path);
  // //   }
  // // }
  // void openPdf(globalKey) async {
  //   Uint8List? imageData = await captureWidget();
  //   File? pdfData = await saveAsPdf(imageData);
  //   //
  //   // final blob = html.Blob([byteList], 'application/pdf');
  //   // final url = html.Url.createObjectUrlFromBlob(blob);
  //   //
  //   // final anchor = html.document.createElement('a') as html.AnchorElement;
  //   // anchor.href = url;
  //   // anchor.target = '_blank';
  //   // anchor.click();
  //   final blob = html.Blob([pdfData], 'application/pdf');
  //   final url = html.Url.createObjectUrlFromBlob(blob);
  //   html.window.open(url, '_blank');
  //   html.Url.revokeObjectUrl(url);
  // }

  // void openPdf() async {
  //   final pdf = await pdfService.printOpticalReceipt(
  //       opticalReceipt: null);
  //
  //   pdfService.savePdfFile(
  //     // fileName: patient.fullName + '-Certificate-' + certificate.date,
  //       byteList: pdf);
  // }


  // void downloadReceipt(double pixelRatio, dynamic refNo) async {
  //   screenShotController
  //       .capture(
  //     pixelRatio: pixelRatio,
  //   )
  //       .then(
  //         (image) async {
  //       imageFile = image;
  //       if (imageFile != null) {
  //         if (await Permission.storage.request().isGranted) {
  //           await ImageGallerySaver.saveImage(imageFile!, name: refNo + '.jpg');
  //           snackBarService.showSnackBar(
  //               message: 'Image was saved to Gallery', title: 'Downloaded');
  //         } else if (await Permission.storage.request().isPermanentlyDenied) {
  //           await openAppSettings();
  //         } else if (await Permission.storage.request().isDenied) {
  //           toastService.showToast(message: 'Permission Denied');
  //         }
  //       }
  //     },
  //   );
  // }
  // void getOpticalReceipt({required Patient patient}) async {
  //   final rec = await apiService.getOpticalRec(patient: patient);
  //   dialogService.showDefaultLoadingDialog();
  //   await Future.delayed(Duration(milliseconds: 300));
  //   opticalReceipt.clear();
  //   opticalReceipt.addAll(rec);
  //   navigationService.pop();
  //   notifyListeners();
  // }
  // void downloadReceipt(
  //     {required OpticalReceipt receipt,
  //       required Patient patient}) async {
  //   final pdf = await pdfService.printOpticalReceipt(
  //       opticalReceipt: receipt, patient: patient);
  //
  //   pdfService.savePdfFile(
  //     // fileName: patient.fullName + '-Certificate-' + certificate.date,
  //       byteList: pdf);
  // }

  String computeMedTotal(Product product) {
    int qty = int.parse(product.qty!);
    double price = double.parse(product.price!);
    return (qty * price).toString().toCurrency!;
  }

  String computeLensTotal(Lens lens) {
    int qty = int.parse(lens.qty!);
    double price = double.parse(lens.price!);
    return (qty * price).toString().toCurrency!;
  }
  //
  // void openCertificate(
  //     {required OpticalReceipt opticalReceipt,
  //       required Patient patient}) async {
  //   final pdf = await pdfService.printOpticalReceipt(
  //       opticalReceipt: opticalReceipt, patient: patient);
  //
  //   pdfService.savePdfFile(
  //     // fileName: patient.fullName + '-Certificate-' + certificate.date,
  //       byteList: pdf);
  // }
}
