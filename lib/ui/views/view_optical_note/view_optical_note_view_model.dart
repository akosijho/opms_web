import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/optical_notes/optical_notes.dart';
import 'package:stacked/stacked.dart';

class ViewOpticalNoteViewModel extends BaseViewModel {
  //
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  List<OpticalNotes> opticalNotes = [];

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
}
