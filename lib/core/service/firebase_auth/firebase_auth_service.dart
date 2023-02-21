import 'package:opmsapp/models/response_model/auth_response_model.dart';

abstract class FirebaseAuthService {
  Future<AuthResponse> loginWithEmail(
      {required String email, required String password});

  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<AuthResponse> loginWithGoogle();

  Future<AuthResponse> loginWithFacebook();

  Future<void> logOut();

  Future<bool> sendEmailVerification();

  Future<bool> reLoad();
}
