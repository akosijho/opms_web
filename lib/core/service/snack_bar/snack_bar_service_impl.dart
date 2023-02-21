import 'package:opmsapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarServiceImpl extends SnackBarService {
  @override
  Future<dynamic>? showSnackBar(
      {String? title, required String message, TextButton? mainButton}) {
    if (!Get.isSnackbarOpen)
      GetSnackBar(
        title: title,
        message: message,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        backgroundColor: Colors.grey[800]!,
        snackStyle: SnackStyle.FLOATING,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        animationDuration: Duration(milliseconds: 300),
        borderRadius: 12,
        snackPosition: SnackPosition.TOP,
        mainButton: mainButton,
      ).show();
  }

  void open() {
    Get.snackbar('title', 'message');
  }
}
