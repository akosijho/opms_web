import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:opmsapp/core/service/session_service/session_service.dart';
import 'package:opmsapp/models/response_model/auth_response_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServiceImpl extends FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final sessionService = locator<SessionService>();
  String errorMessage = '';

  @override
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return AuthResponse.success(authResult.user!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Not A Valid Email Acct.";
          break;
        case "weak-password":
          errorMessage = "Password should be minimum of 8 characters.";
          break;
        case "email-already-in-use":
          errorMessage = "Email is already in use. Try logging in.";
          break;
        default:
          errorMessage = "There's an error encountered on our end. "
              "Please try again later.";
          break;
      }
      return AuthResponse.error(errorMessage);
    }
  }

  @override
  Future<AuthResponse> loginWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential? authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        return AuthResponse.success(authResult.user!);
      } else {
        return AuthResponse.error('Unknown error');
      }
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "unknown":
          errorMessage = e.message!;
          break;
        case "invalid-email":
          errorMessage = "Invalid Email Account. Please try again.";
          break;
        case "user-not-found":
          errorMessage =
              "No account associated with this email. Please try again.";
          break;
        case "wrong-password":
          errorMessage = "Incorrect password. Please try again.";
          break;
        default:
          errorMessage = 'Network Error';
          break;
      }
      return AuthResponse.error(errorMessage);
    }
  }

  @override
  Future<bool> sendEmailVerification() async {
    final currentUser = await _firebaseAuth.currentUser;
    if (currentUser != null && !currentUser.emailVerified) {
      await currentUser.sendEmailVerification();
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<AuthResponse> loginWithGoogle() async {
    final GoogleSignIn _googleSignIn = await GoogleSignIn(scopes: ['profile']);
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final authCredential = await GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      UserCredential authResult =
          await _firebaseAuth.signInWithCredential(authCredential);
      sendEmailVerification();
      return AuthResponse.success(authResult.user!);
    } else {
      return AuthResponse.error('Error Signing In');
    }
  }

  @override
  Future<AuthResponse> loginWithFacebook() async {
    throw Exception();
  }

  @override
  Future<void> logOut() async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.signOut();

      sessionService.clearSession();
    }
  }

  @override
  Future<bool> reLoad() async {
    try {
      await _firebaseAuth.currentUser?.reload();
      debugPrint(_firebaseAuth.currentUser?.email);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }
}
