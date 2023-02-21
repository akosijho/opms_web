import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityStateCheck {
  bool isConnected = false;
  Future<bool> checkConnectivity() async {
    var connectivityRes = await Connectivity().checkConnectivity();

    if (connectivityRes != ConnectivityResult.none) {
      isConnected = true;
    } else {
      isConnected = false;
    }
    return isConnected;
  }
}
