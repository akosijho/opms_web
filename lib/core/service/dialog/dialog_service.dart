import 'package:flutter/material.dart';

abstract class DialogService {
  Future<dynamic>? showConfirmationDialog({
    required String title,
    required String middleText,
    required Function onCancel,
    required Function onContinue,
    required String textConfirm,
    required bool willPop,
  });

  Future<dynamic>? showLoadingDialog({
    required String message,
    required bool willPop,
  });

  Future<T?>? showDefaultLoadingDialog<T>(
      {bool? barrierDismissible, bool? willPop});

  Future<dynamic>? showConfirmDialog({
    required String title,
    required String middleText,
    required Function onCancel,
    required Function onContinue,
    String? mainOptionTxt,
    Color? mainOptionColor,
    bool? willPop,
    bool? barrierDismissible,
  });
}
