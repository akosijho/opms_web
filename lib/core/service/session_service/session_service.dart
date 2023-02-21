import 'package:opmsapp/models/session/session_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SessionService {
  Future<void> saveSession(
      {bool? isRunFirstTime,
      bool? isLoggedIn,
      bool? isAccountSetupDone,
      AuthCredential? authCredential});

  Future<SessionModel> getSession();

  Future<void> clearSession();
}
