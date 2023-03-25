import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class SelectPaymentTypeViewModel extends BaseViewModel {
  List<String> paymentTypes = ['Cash On Hand', 'Credit Card'];
  final navigationService = locator<NavigationService>();
  var val = 0;

  void returnPaymentType(String paymentType) {
    navigationService.pop(returnValue: paymentType);
  }
}
