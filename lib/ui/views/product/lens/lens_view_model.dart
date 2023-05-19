import 'dart:async';
import 'package:flutter/material.dart';
import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/product/lens.dart';
import 'package:opmswebstaff/ui/views/add_product/add_lens/add_lens_view.dart';
import 'package:stacked/stacked.dart';

class LensViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? lensStreamSub;
  List<Lens> lensList = [];

  bool isScrolledUp = true;
  bool searchMode = false;

  @override
  void dispose() {
    lensStreamSub!.cancel();
    super.dispose();
  }

  void setFabSize({required bool isScrolledUp}) {
    this.isScrolledUp = isScrolledUp;
    notifyListeners();
  }

  void getLensList() {
    apiService.getPatients().listen((event) {
      lensStreamSub?.cancel();
      lensStreamSub = apiService.getLensList().listen((lens) {
        lensList = lens;
        notifyListeners();
      });
    });
  }

  void deleteMedicine(String medicineId) {
    //  Todo: logic code to delete product
  }

  void searchLens(String query) {
    if (searchMode == false) {
      searchMode = true;
      notifyListeners();
    }
  }

  void goToAddLens(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 500,
            height: 500,
            child: AddLensView(),
          ),
        );
      },
    );
  }
}
