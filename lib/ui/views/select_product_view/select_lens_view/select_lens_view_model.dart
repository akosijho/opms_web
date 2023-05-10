import 'dart:async';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/product/lens.dart';
import 'package:stacked/stacked.dart';



class SelectLensViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? lensSub;

  List<Lens> lensList = [];
  List<Lens> selectedLens = [];

  void init() async {
    getLens();
  }

  @override
  void dispose() {
    lensSub?.cancel();
    super.dispose();
  }

  void getLens() {
    apiService.getPatients().listen((event) {
      lensSub?.cancel();
      lensSub = apiService.getLensList().listen((lens) {
        lensList = lens;
        notifyListeners();
      });
    });
  }

  bool lensExistInSelectedLens(String lensId) {
    if ((selectedLens
        .map((lens) => lens.id)
        .contains(lensId))) {
      return true;
    } else {
      return false;
    }
  }

  void returnSelectedLens() {
    navigationService.pop(returnValue: selectedLens);
  }
}
