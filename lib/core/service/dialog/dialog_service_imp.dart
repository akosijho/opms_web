import 'package:opmsapp/constants/styles/palette_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'dialog_service.dart';

class DialogServiceImpl extends DialogService {
  @override
  Future showLoadingDialog({required String message, required bool willPop}) {
    return Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async {
          return willPop;
        },
        title: message,
        content: Center(
          child: Container(
            height: 50,
            width: 50,
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Future showConfirmationDialog({
    required String title,
    required String middleText,
    required Function onCancel,
    required Function onContinue,
    required String textConfirm,
    required bool willPop,
  }) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      onWillPop: () async {
        return willPop;
      },
      middleText: middleText,
      onCancel: () => onCancel(),
      onConfirm: () => onContinue(),
      textCancel: 'Cancel',
      textConfirm: textConfirm,
      confirmTextColor: Colors.white,
    );
  }

  @override
  Future<T?> showDefaultLoadingDialog<T>(
      {bool? barrierDismissible, bool? willPop}) {
    return Get.dialog(
      WillPopScope(
        onWillPop: () async {
          if (willPop != null) {
            if (willPop) {
              return true;
            } else {
              return false;
            }
          } else {
            return true;
          }
        },
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Palettes.kcNeutral1,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8.sp),
            height: 75.sp,
            width: 70.sp,
            child: Center(
                child: LoadingAnimationWidget.flickr(
              size: 30,
              rightDotColor: Colors.white,
              leftDotColor: Palettes.kcBlueMain2,
              time: 1000,
            )),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: Palettes.kcBlueMain1.withOpacity(0.2),
    );
  }

  @override
  Future? showConfirmDialog(
      {required String title,
      required String middleText,
      String? mainOptionTxt,
      Color? mainOptionColor,
      required Function onCancel,
      required Function onContinue,
      bool? barrierDismissible,
      bool? willPop}) {
    return Get.dialog(
      WillPopScope(
        onWillPop: () async {
          if (willPop != null) {
            if (willPop) {
              return true;
            } else {
              return false;
            }
          } else {
            return true;
          }
        },
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8.sp),
            height: 260.sp,
            width: 250.sp,
            child: Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 25, left: 20, right: 20, bottom: 0),
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 18),
                          Text(
                            middleText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 1),
                  TextButton(
                    onPressed: () => onContinue(),
                    child: mainOptionTxt == null
                        ? Text('Confirm')
                        : Text(mainOptionTxt),
                    style: TextButton.styleFrom(
                      primary: mainOptionColor,
                      minimumSize: Size(double.maxFinite, 40),
                    ),
                  ),
                  Divider(height: 1),
                  TextButton(
                    onPressed: () => onCancel(),
                    child: Text('Cancel'),
                    style: TextButton.styleFrom(
                      primary: Colors.grey.shade900,
                      minimumSize: Size(double.maxFinite, 40),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible ?? true,
    );
  }
}
