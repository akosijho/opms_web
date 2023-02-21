import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  Future<bool> checkConnectivity() async {
    return await InternetConnectionChecker().hasConnection;
  }

  Stream<InternetConnectionStatus> checkInternetStatus() {
    return InternetConnectionChecker().onStatusChange;
  }
}
