import 'dart:async';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:stacked/stacked.dart';

class SelectionServiceViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  List<Service> serviceList = [];
  List<Service> tempService = [];
  StreamSubscription? serviceStreamSub;

  @override
  void dispose() {
    serviceStreamSub?.cancel();
    super.dispose();
  }

  void getListOfService() async {
    setBusy(true);
    apiService.getServiceList().listen((event) {
      serviceStreamSub?.cancel();
      serviceStreamSub = apiService.getServiceList().listen((event) async {
        tempService.clear();
        tempService.addAll(event);
        serviceList.clear();
        serviceList.addAll(event);
        notifyListeners();
      });
    });
    await Future.delayed(Duration(milliseconds: 500));
    setBusy(false);
  }

  // Future<void> searchService(String query) async {
  //   if (query.trimLeft().trimRight() != "") {
  //     final service = await apiService.searchService(query);
  //     if (service != null) {
  //       serviceList.clear();
  //       serviceList.addAll(service);
  //       notifyListeners();
  //     }
  //   } else {
  //     serviceList.clear();
  //     serviceList.addAll(tempService);
  //     notifyListeners();
  //   }
  // }
  Future<void> searchService(String query) async {
    if (query.trimLeft().trimRight() != "") {
      final service = await apiService.searchService(query);
      serviceList.clear();
      serviceList.addAll(service);
      notifyListeners();
    } else {
      serviceList.clear();
      serviceList.addAll(tempService);
      notifyListeners();
    }
  }

  void returnService({required Service procedure}) {
    navigationService.pop(returnValue: procedure);
  }
}
