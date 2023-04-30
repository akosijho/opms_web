import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/optical_notes/optical_notes.dart';
import 'package:stacked/stacked.dart';

class ViewDentalNoteByToothViewModel extends BaseViewModel {
//
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();

  List<OpticalNotes> dentalNotes = [];
  Future<void> getDentalNoteByID(
    String selectedTooth,
    String patientId,
  ) async {
    setBusy(true);
    final notes = await apiService.getOpticalNotesList(
        patientId: patientId, toothId: selectedTooth);
    await Future.delayed(Duration(seconds: 1));
    if (notes != null) {
      dentalNotes.clear();
      dentalNotes = notes;
      notifyListeners();
    }

    setBusy(false);
  }
}
