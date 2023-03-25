import 'dart:async';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/procedure/procedure.dart';
import 'package:stacked/stacked.dart';

class SelectionProcedureViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  List<Procedure> procedureList = [];
  List<Procedure> tempProcedure = [];
  StreamSubscription? procedureStreamSub;

  @override
  void dispose() {
    procedureStreamSub?.cancel();
    super.dispose();
  }

  void getListOfProcedure() async {
    setBusy(true);
    apiService.getProcedureList().listen((event) {
      procedureStreamSub?.cancel();
      procedureStreamSub = apiService.getProcedureList().listen((event) async {
        tempProcedure.clear();
        tempProcedure.addAll(event);
        procedureList.clear();
        procedureList.addAll(event);
        notifyListeners();
      });
    });
    await Future.delayed(Duration(milliseconds: 500));
    setBusy(false);
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

  void returnProcedure({required Procedure procedure}) {
    navigationService.pop(returnValue: procedure);
  }
}
