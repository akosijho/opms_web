import 'package:flutter/material.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/models/balance_notes/balance_notes.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class PaymentSelectBalanceNoteViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final opticalFormKey = GlobalKey<FormState>();

  List<BalanceNotes> listOfUnpaidBalanceNotes = [];
  List<BalanceNotes> selectedBalanceNote = [];
  bool selectAll = true;

  Future<void> init(String patientId) async {
    setBusy(true);
    listOfUnpaidBalanceNotes = (await apiService.getBalanceList(
        patientId: patientId, isPaid: false))!;
    notifyListeners();
    selectedBalanceNote.addAll(listOfUnpaidBalanceNotes);
    setBusy(false);
  }

  void returnSelectedBalanceNote() {
    // if (opticalFormKey.currentState!.validate()) {
    navigationService.pop(returnValue: selectedBalanceNote);
    // } else {
    //   snackBarService.showSnackBar(
    //       message: 'Make sure service amounts are valid',
    //       title: 'Invalid Amount');
    // }
  }

  bool balanceNoteExistInSelectedNotes(String balanceNoteId) {
    if ((selectedBalanceNote
        .map((balanceNote) => balanceNote.id)
        .contains(balanceNoteId))) {
      return true;
    } else {
      return false;
    }
  }

  void addToSelectedBalanceNote(BalanceNotes balanceNotes) {
    if ((selectedBalanceNote
        .map((balanceNote) => balanceNote.id)
        .contains(balanceNotes.id))) {
      selectedBalanceNote
          .removeWhere((balanceNote) => balanceNote.id == balanceNotes.id);
      selectAll = false;
      notifyListeners();
    } else {
      selectedBalanceNote.add(balanceNotes);
      if (selectedBalanceNote == listOfUnpaidBalanceNotes) {
        selectAll = true;
      }
      notifyListeners();
    }
  }

  void toogleSelectAll() {
    selectAll = !selectAll;
    notifyListeners();
    if (selectAll) {
      selectedBalanceNote.clear();
      selectedBalanceNote.addAll(listOfUnpaidBalanceNotes);
      notifyListeners();
    } else {
      selectedBalanceNote.clear();
    }
  }
}
