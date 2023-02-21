import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/api/api_service.dart';
import '../../../models/appointment_model/appointment_model.dart';

class WeekAppointmentViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();

  DateTime selectedDate = DateTime.now();
  final DateTime firstDate = DateTime.now().subtract(Duration(days: 45));
  final DateTime lastDate = DateTime.now().add(Duration(days: 45));
  DatePeriod? selectedPeriod;

  List<AppointmentModel> appointments = [];

  void selectDateChange(DatePeriod newPeriod) {
    selectedDate = newPeriod.start;
    selectedPeriod = newPeriod;
    debugPrint(selectedPeriod?.start.toString());
    debugPrint(selectedPeriod?.end.toString());
    notifyListeners();
  }
}
