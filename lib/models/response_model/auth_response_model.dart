import 'package:firebase_auth/firebase_auth.dart';

class AuthResponse {
  final User? user;
  final bool success;
  final String? errorMessage;

  AuthResponse._({this.user, required this.success, this.errorMessage});

  factory AuthResponse.success(User user) =>
      AuthResponse._(success: true, user: user);

  factory AuthResponse.error(String message) =>
      AuthResponse._(success: false, errorMessage: message);
}
