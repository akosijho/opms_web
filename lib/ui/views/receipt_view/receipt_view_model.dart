import 'dart:typed_data';

import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/medicine/medicine.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class ReceiptViewModel extends BaseViewModel {
  final screenShotController = ScreenshotController();
  Uint8List? imageFile;
  final toastService = locator<ToastService>();
  final snackBarService = locator<SnackBarService>();

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

  String computeMedTotal(Medicine medicine) {
    int qty = int.parse(medicine.qty!);
    double price = double.parse(medicine.price!);
    return (qty * price).toString().toCurrency!;
  }
}
