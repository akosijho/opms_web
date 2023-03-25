import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/models/dental_notes/dental_notes.dart';
import 'package:stacked/stacked.dart';

class ViewDentalNoteViewModel extends BaseViewModel {
  //
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  List<DentalNotes> dentalNotes = [];

  void getDentalNotes(String patientId) async {
    setBusy(true);
    final notes = await apiService.getDentalNotesList(patientId: patientId);

    await Future.delayed(Duration(milliseconds: 500));

    if (notes != null) {
      dentalNotes.clear();
      dentalNotes.addAll(notes);
      notifyListeners();
    }
    setBusy(false);
  }
}
