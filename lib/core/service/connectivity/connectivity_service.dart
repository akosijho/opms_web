import 'dart:async';
import 'dart:io';
// import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';


class ConnectivityService {
  Future<bool> checkConnectivity() async {
    return await InternetConnectionChecker().hasConnection;
  }

  Stream<InternetConnectionStatus> checkInternetStatus() {
    return InternetConnectionChecker().onStatusChange;
  }
}

// class ConnectivityService {
//   Future<bool> checkConnectivity() async {
//     try {
//       final response = await http.get(Uri.parse('http://example.com'));
//       return response.statusCode == 200;
//     } catch (e) {
//       return false;
//     }
//   }
//   Stream<bool> checkInternetStatus() {
//     return Stream.periodic(Duration(seconds: 1), (_) async {
//       final result = await checkConnectivity();
//       return result;
//     }).asyncMap((event) => event);
//   }
// }

// class ConnectivityService {
//   Future<bool> checkConnectivity() async {
//     try {
//       final response = await InternetAddress.lookup('example.com');
//       return response.isNotEmpty && response[0].rawAddress.isNotEmpty;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   Stream<bool> checkInternetStatus() {
//     return Stream.periodic(Duration(seconds: 1), (_) async {
//       final result = await checkConnectivity();
//       return result;
//     }).asyncMap((event) => event);
//   }
// }

