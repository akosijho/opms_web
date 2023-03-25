import 'package:opmswebstaff/core/service/session_service/session_service.dart';
import 'package:opmswebstaff/models/session/session_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class SessionServiceImpl extends SessionService {
  final _myStorage = GetStorage('MyLocalDB');

  @override
  Future<void> saveSession({
    bool? isRunFirstTime,
    bool? isLoggedIn,
    bool? isAccountSetupDone,
    AuthCredential? authCredential,
  }) async {
    _myStorage.write('isRunFirstTime', isRunFirstTime ?? true);
    _myStorage.write('isLoggedIn', isLoggedIn ?? false);
    _myStorage.write('isAccountSetupDone', isAccountSetupDone ?? false);
    _myStorage.write('authCredential', authCredential);
  }

  @override
  Future<SessionModel> getSession() async {
    bool isRunFirstTime = await _myStorage.read('isRunFirstTime') ?? true;
    bool isLoggedIn = await _myStorage.read('isLoggedIn') ?? true;
    bool isAccountSetupDone =
        await _myStorage.read('isAccountSetupDone') ?? false;
    AuthCredential? authCredential = await _myStorage.read('userCredential');

    return SessionModel(
        isRunFirstTime: isRunFirstTime,
        isLoggedIn: isLoggedIn,
        isAccountSetupDone: isAccountSetupDone,
        authCredential: authCredential);
  }

  @override
  Future<void> clearSession() async {
    _myStorage.write('isRunFirstTime', false);
    _myStorage.write('isLoggedIn', false);
    _myStorage.write('isAccountSetupDone', false);
    _myStorage.write('authCredential', null);
  }
}
