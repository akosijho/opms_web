import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/dental_notes/dental_notes.dart';

class PaymentSelectDentalNoteViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dentalFormKey = GlobalKey<FormState>();

  List<DentalNotes> listOfUnpaidDentalNotes = [];
  List<DentalNotes> selectedDentalNote = [];
  bool selectAll = true;

  Future<void> init(String patientId) async {
    setBusy(true);
    listOfUnpaidDentalNotes = (await apiService.getDentalNotesList(
        patientId: patientId, isPaid: false))!;
    notifyListeners();
    selectedDentalNote.addAll(listOfUnpaidDentalNotes);
    setBusy(false);
  }

  void returnSelectedDentalNote() {
    if (dentalFormKey.currentState!.validate()) {
      navigationService.pop(returnValue: selectedDentalNote);
    } else {
      snackBarService.showSnackBar(
          message: 'Make sure procedure amounts are valid',
          title: 'Invalid Amount');
    }
  }

  bool dentalNoteExistInSelectedNotes(String dentalNoteId) {
    if ((selectedDentalNote
        .map((dentalNote) => dentalNote.id)
        .contains(dentalNoteId))) {
      return true;
    } else {
      return false;
    }
  }

  void addToSelectedDentalNote(DentalNotes dentalNotes) {
    if ((selectedDentalNote
        .map((dentalNote) => dentalNote.id)
        .contains(dentalNotes.id))) {
      selectedDentalNote
          .removeWhere((dentalNote) => dentalNote.id == dentalNotes.id);
      selectAll = false;
      notifyListeners();
    } else {
      selectedDentalNote.add(dentalNotes);
      if (selectedDentalNote == listOfUnpaidDentalNotes) {
        selectAll = true;
      }
      notifyListeners();
    }
  }

  void toogleSelectAll() {
    selectAll = !selectAll;
    notifyListeners();
    if (selectAll) {
      selectedDentalNote.clear();
      selectedDentalNote.addAll(listOfUnpaidDentalNotes);
      notifyListeners();
    } else {
      selectedDentalNote.clear();
    }
  }
}
