
import 'dart:typed_data';

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



import '../../../app/app.locator.dart';

class ReceiptViewModel extends BaseViewModel {
  final screenShotController = ScreenshotController();
  Uint8List? imageFile;
  final toastService = locator<ToastService>();
  final snackBarService = locator<SnackBarService>();
  final pdfService = locator<PdfService>();

  void downloadReceipt(double pixelRatio, dynamic refNo) async {
    screenShotController
        .capture(
      pixelRatio: pixelRatio,
    )
        .then(
          (image) async {
        imageFile = image;
        if (imageFile != null) {
          if (await Permission.storage.request().isGranted) {
            await ImageGallerySaver.saveImage(imageFile!, name: refNo + '.jpg');
            snackBarService.showSnackBar(
                message: 'Image was saved to Gallery', title: 'Downloaded');
          } else if (await Permission.storage.request().isPermanentlyDenied) {
            await openAppSettings();
          } else if (await Permission.storage.request().isDenied) {
            toastService.showToast(message: 'Permission Denied');
          }
        }
      },
    );
  }

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

  void openCertificate(
      {required OpticalReceipt opticalReceipt,
        required Patient patient}) async {
    final pdf = await pdfService.printOpticalReceipt(
        opticalReceipt: opticalReceipt, patient: patient);

    pdfService.savePdfFile(
      // fileName: patient.fullName + '-Certificate-' + certificate.date,
        byteList: pdf);
  }
}
