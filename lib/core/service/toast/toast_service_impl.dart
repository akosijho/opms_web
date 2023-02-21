import 'package:opmsapp/core/service/toast/toast_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastServiceImpl extends ToastService {
  @override
  Future<void> showToast({required String message}) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
