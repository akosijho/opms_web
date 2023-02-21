import 'package:opmsapp/constants/styles/palette_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetService {
  Future<dynamic>? openBottomSheet(Widget bottomChild) {
    return Get.bottomSheet(
      bottomChild,
      elevation: 1,
      barrierColor: Palettes.kcNeutral1.withOpacity(0.3),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
    );
  }

  Future<dynamic>? openFullScreenModal(Widget child) {
    return Get.bottomSheet(child,
        persistent: true,
        elevation: 0,
        isScrollControlled: true,
        ignoreSafeArea: false);
  }
}
