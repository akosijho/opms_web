import 'dart:async';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/user_model/user_model.dart';
import 'package:stacked/stacked.dart';

import '../../../core/service/snack_bar/snack_bar_service.dart';

class SelectionOptometristViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackBarService>();
  List<UserModel> optometristList = [];
  StreamSubscription? optometristStreamSub;

  @override
  void dispose() {
    optometristStreamSub?.cancel();
    super.dispose();
  }

  Future<void> searchOptometrist(String query) async {
    setBusy(true);
    optometristList = await apiService.searchOptometrist(query: query);
    notifyListeners();
    setBusy(false);
  }

  setReturnOptometrist(UserModel user) {
    if (user.active_status == 'active')
      navigationService.pop(returnValue: user);
    else
      snackBarService.showSnackBar(
          message: 'Doctor is on Leave', title: 'Cannot be selected');
  }
}
