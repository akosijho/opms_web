import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/models/dental_notes/dental_notes.dart';
import 'package:opmswebstaff/ui/widgets/selection_date/selection_date.dart';


class RxViewModel extends ChangeNotifier {
  final toastService = locator<ToastService>();
  final snackBarService = locator<SnackBarService>();
  final setDentalNoteFormKey = GlobalKey<FormState>();
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();
  final procedureTxtController = TextEditingController();
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();
  DateTime selectedDate = DateTime.now();
  final dateTextController =
  TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));

  TextEditingController note = TextEditingController();
  DentalNotes? currentDentalNote;


  void init(DentalNotes dentalNote) {
    currentDentalNote = dentalNote;
    note.text = currentDentalNote!.note;
    // firstNameController.text = currentUser!.firstName;
    // lastNameController.text = currentUser!.lastName;
    // phoneNumController.text = currentUser!.phoneNum;
    // dateOfBirthController.text =
    //     currentUser!.dateOfBirth.toDateTime()!.toStringDateFormat();
    // birthDate = currentUser!.dateOfBirth.toDateTime()!;
    // genderController.text = currentUser!.gender;
    // positionController.text = currentUser!.position;

    notifyListeners();
    // listenToUserChange();
    // status = currentUser!.active_status;
  }
  void selectDate() async {
    final DateTime date =
    await bottomSheetService.openBottomSheet(SelectionDate(
      title: 'Set date',
      initialDate: DateTime.now(),
      maxDate: DateTime.now(),
    ));
    if (date != null) {
      selectedDate = date;
      notifyListeners();
      dateTextController.text = DateFormat.yMMMd().format(selectedDate);
    }
  }
}
