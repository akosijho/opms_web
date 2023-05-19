import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:opmswebstaff/ui/views/add_service/add_service_view.dart';
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
    final service = await apiService.getService();
    if (service != null) {
      serviceList.clear();
      serviceList.addAll(service);
      tempService.clear();
      tempService.addAll(service);

      notifyListeners();
    }
    notifyListeners();
  }

  void init() async {
    setBusy(true);
    await getServices();
    await Future.delayed(Duration(seconds: 1));
    setBusy(false);
    getServiceList();
  }

  Future<void> searchService(String query) async {
    if (query.trimLeft().trimRight() != "") {
      final service = await apiService.searchService(query);
      if (service != null) {
        serviceList.clear();
        serviceList.addAll(service);
        notifyListeners();
      }
    } else {
      serviceList.clear();
      serviceList.addAll(tempService);
      notifyListeners();
    }
  }

  void getServiceList() {
    apiService.getServiceList().listen((event) {
      serviceStreamSub?.cancel();
      serviceStreamSub = apiService.getServiceList().listen((procedures) {
        getServices();
      });
    });
  }

  void goToAddService(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: AddServiceView(),
          ),
        );
      },
    );
  }

  void deleteService() {
    //  Todo: logic code to delete service
  }
}
