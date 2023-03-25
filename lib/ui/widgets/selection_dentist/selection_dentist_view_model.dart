import 'dart:async';

import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/user_model/user_model.dart';
import 'package:stacked/stacked.dart';

import '../../../core/service/snack_bar/snack_bar_service.dart';

class SelectionDentistViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackBarService>();
  List<UserModel> dentistList = [];
  StreamSubscription? dentistStreamSub;

  @override
  void dispose() {
    dentistStreamSub?.cancel();
    super.dispose();
  }

  Future<void> searchDentist(String query) async {
    setBusy(true);
    dentistList = await apiService.searchDentist(query: query);
    notifyListeners();
    setBusy(false);
  }

  setReturnDentist(UserModel user) {
    if (user.active_status == 'active')
      navigationService.pop(returnValue: user);
    else
      snackBarService.showSnackBar(
          message: 'Doctor is on Leave', title: 'Cannot be selected');
  }
}
