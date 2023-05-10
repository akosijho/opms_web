import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/balance_notes/balance_notes.dart';
import 'package:opmswebstaff/models/optical_notes/optical_notes.dart';
import 'package:stacked/stacked.dart';

class ViewOpticalNoteViewModel extends BaseViewModel {
  //
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  List<OpticalNotes> opticalNotes = [];
  List<BalanceNotes> paymentBalance = [];


  void getOpticalNotes(String patientId) async {
    setBusy(true);
    final notes = await apiService.getOpticalNotesList(patientId: patientId);

    await Future.delayed(Duration(milliseconds: 500));

    if (notes != null) {
      opticalNotes.clear();
      opticalNotes.addAll(notes);
      notifyListeners();
    }
    setBusy(false);
  }

  void getPaymentBalance(String patientId) async {
    setBusy(true);
    final balance = await apiService.getBalanceList(patientId: patientId);

    await Future.delayed(Duration(milliseconds: 500));

    if (balance != null) {
      paymentBalance.clear();
      paymentBalance.addAll(balance);
      notifyListeners();
    }
    setBusy(false);
  }
}
