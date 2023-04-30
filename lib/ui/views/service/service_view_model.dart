import 'dart:async';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:stacked/stacked.dart';

class ServiceViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? serviceStreamSub;
  List<Service> serviceList = [];
  List<Service> tempService = [];
  bool isScrolledUp = true;

  void setFabSize({required bool isScrolledUp}) {
    this.isScrolledUp = isScrolledUp;
    notifyListeners();
  }

  Future<void> getServices() async {
    final procedures = await apiService.getService();
    if (procedures != null) {
      serviceList.clear();
      serviceList.addAll(procedures);
      tempService.clear();
      tempService.addAll(procedures);

      notifyListeners();
    }
    notifyListeners();
  }

  void init() async {
    setBusy(true);
    await getServices();
    await Future.delayed(Duration(seconds: 1));
    setBusy(false);
    getProcedureList();
  }

  Future<void> searchService(String query) async {
    if (query.trimLeft().trimRight() != "") {
      final procedure = await apiService.searchService(query);
      if (procedure != null) {
        serviceList.clear();
        serviceList.addAll(procedure);
        notifyListeners();
      }
    } else {
      serviceList.clear();
      serviceList.addAll(tempService);
      notifyListeners();
    }
  }

  void getProcedureList() {
    apiService.getServiceList().listen((event) {
      serviceStreamSub?.cancel();
      serviceStreamSub = apiService.getServiceList().listen((procedures) {
        getServices();
      });
    });
  }

  void deleteService() {
    //  Todo: logic code to delete service
  }
}
