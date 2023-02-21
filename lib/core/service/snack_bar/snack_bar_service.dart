import 'package:flutter/material.dart';

abstract class SnackBarService {
  Future<dynamic>? showSnackBar(
      {String? title, required String message, TextButton? mainButton});
}
