import 'dart:async';

import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/core/service/api/api_service.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:opmsapp/models/procedure/procedure.dart';
import 'package:stacked/stacked.dart';

class ProcedureViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? procedureStreamSub;
  List<Procedure> procedureList = [];
  List<Procedure> tempProcedure = [];
  bool isScrolledUp = true;

  void setFabSize({required bool isScrolledUp}) {
    this.isScrolledUp = isScrolledUp;
    notifyListeners();
  }

  Future<void> getProcedures() async {
    final procedures = await apiService.getProcedures();
    if (procedures != null) {
      procedureList.clear();
      procedureList.addAll(procedures);
      tempProcedure.clear();
      tempProcedure.addAll(procedures);

      notifyListeners();
    }
    notifyListeners();
  }

  void init() async {
    setBusy(true);
    await getProcedures();
    await Future.delayed(Duration(seconds: 1));
    setBusy(false);
    getProcedureList();
  }

  Future<void> searchProcedure(String query) async {
    if (query.trimLeft().trimRight() != "") {
      final procedure = await apiService.searchProcedure(query);
      if (procedure != null) {
        procedureList.clear();
        procedureList.addAll(procedure);
        notifyListeners();
      }
    } else {
      procedureList.clear();
      procedureList.addAll(tempProcedure);
      notifyListeners();
    }
  }

  void getProcedureList() {
    apiService.getProcedureList().listen((event) {
      procedureStreamSub?.cancel();
      procedureStreamSub = apiService.getProcedureList().listen((procedures) {
        getProcedures();
      });
    });
  }

  void deleteProcedure() {
    //  Todo: logic code to delete procedure
  }
}
