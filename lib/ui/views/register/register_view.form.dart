// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String EmailValueKey = 'email';
const String PasswordValueKey = 'password';
const String ConfirmPassValueKey = 'confirmPass';

mixin $RegisterView on StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPassFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    confirmPassController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            EmailValueKey: emailController.text,
            PasswordValueKey: passwordController.text,
            ConfirmPassValueKey: confirmPassController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    emailController.dispose();
    emailFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    confirmPassController.dispose();
    confirmPassFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get emailValue => this.formValueMap[EmailValueKey] as String?;
  String? get passwordValue => this.formValueMap[PasswordValueKey] as String?;
  String? get confirmPassValue =>
      this.formValueMap[ConfirmPassValueKey] as String?;

  bool get hasEmail => this.formValueMap.containsKey(EmailValueKey);
  bool get hasPassword => this.formValueMap.containsKey(PasswordValueKey);
  bool get hasConfirmPass => this.formValueMap.containsKey(ConfirmPassValueKey);

  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;
  bool get hasPasswordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey]?.isNotEmpty ?? false;
  bool get hasConfirmPassValidationMessage =>
      this.fieldsValidationMessages[ConfirmPassValueKey]?.isNotEmpty ?? false;

  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
  String? get passwordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey];
  String? get confirmPassValidationMessage =>
      this.fieldsValidationMessages[ConfirmPassValueKey];
}

extension Methods on FormViewModel {
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;
  setPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PasswordValueKey] = validationMessage;
  setConfirmPassValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ConfirmPassValueKey] = validationMessage;
}
