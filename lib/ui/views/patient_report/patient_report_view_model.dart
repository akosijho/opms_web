import 'package:opmsapp/core/service/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import '../../../app/app.locator.dart';

class PatientReportViewModel extends BaseViewModel {
  //

  final apiService = locator<ApiService>();

  int totalPatients = 0;
  int totalMalePatients = 0;
  int totalFemalePatients = 0;

  List<PatientByGender> patientsByGender = [];
  List<charts.Series> seriesList = [];

  Future<void> getTotalMalePatients() async {
    final numMale = await apiService.getTotalMalePatient();
    if (numMale != null) {
      totalMalePatients = numMale;
      notifyListeners();
    }
  }

  Future<void> getTotalFemalePatients() async {
    final numFemale = await apiService.getTotalFeMalePatient();
    if (numFemale != null) {
      totalFemalePatients = numFemale;
      notifyListeners();
    }
  }

  void computeTotalPatient() {
    totalPatients = totalFemalePatients + totalMalePatients;
    notifyListeners();
  }

  setByPatientsByGenderData() async {
    final maleData = PatientByGender(gender: 'Male', total: totalMalePatients);
    final femaleData =
        PatientByGender(gender: 'Female', total: totalFemalePatients);
    patientsByGender.add(maleData);
    patientsByGender.add(femaleData);
    notifyListeners();
  }

  List<charts.Series<PatientByGender, int>> setSeriesList() {
    return [
      new charts.Series<PatientByGender, int>(
        id: 'Patients',
        domainFn: (PatientByGender gender, _) => gender.total,
        measureFn: (PatientByGender gender, _) => gender.total,
        data: patientsByGender,
        colorFn: (PatientByGender gender, _) {
          if (gender.gender == 'Male') {
            return charts.ColorUtil.fromDartColor(Colors.blue);
          } else {
            return charts.ColorUtil.fromDartColor(Colors.pink);
          }
        },
        labelAccessorFn: (PatientByGender row, _) =>
            '${row.gender}: ${row.total}',
      )
    ];
  }

  void init() async {
    setBusy(true);
    await getTotalFemalePatients();
    await getTotalMalePatients();
    computeTotalPatient();
    await setByPatientsByGenderData();
    await setSeriesList();
    setBusy(false);
  }
}

class PatientByGender {
  final String gender;
  final int total;
  const PatientByGender({required this.gender, required this.total});
}
