import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_border_styles.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String value) validator;
  final String hintText;
  final String labelText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final VoidCallback? onEditingComplete;
  final int? maxLines;
  final List<TextInputFormatter>? textFormatter;
  final bool? autoFocus;
  final bool? isEnabled;
  final String? initialValue;
  final bool? obscureText;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.labelText,
    this.textInputAction,
    this.textInputType,
    this.focusNode,
    this.onEditingComplete,
    this.maxLines,
    this.textFormatter,
    this.autoFocus,
    this.isEnabled,
    this.initialValue,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: key,
        controller: controller,
        focusNode: focusNode ?? null,
        validator: (value) => validator(value ?? ''),
        textInputAction: textInputAction,
        keyboardType: textInputType ?? TextInputType.text,
        onEditingComplete: () => onEditingComplete,
        maxLines: maxLines,
        autofocus: autoFocus ?? false,
        enabled: isEnabled ?? true,
        initialValue: initialValue,
        obscureText: obscureText ?? false,
        inputFormatters: textFormatter,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
          enabledBorder: TextBorderStyles.normalBorder,
          focusedBorder: TextBorderStyles.focusedBorder,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }
}
