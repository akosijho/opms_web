import 'package:firebase_auth/firebase_auth.dart';

class SessionModel {
  final bool isRunFirstTime;
  final bool isLoggedIn;
  final bool isAccountSetupDone;
  final AuthCredential? authCredential;
  SessionModel({
    required this.isRunFirstTime,
    required this.isLoggedIn,
    required this.isAccountSetupDone,
    required this.authCredential,
  });
}
