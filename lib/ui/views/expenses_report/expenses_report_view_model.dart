import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/extensions/date_format_extension.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/expense/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpensesReportViewModel extends BaseViewModel {
  //

  final apiService = locator<ApiService>();

  List<Expense> expenses = [];

  List<ExpenseReport> data = [];

  List<charts.Series<ExpenseReport, String>> setSeriesList() {
    return [
      new charts.Series<ExpenseReport, String>(
        id: 'Patients',
        data: data,
        measureFn: (ExpenseReport expense, _) => expense.expenses,
        domainFn: (ExpenseReport expense, _) => expense.month,
        colorFn: (ExpenseReport expense, _) =>
            charts.ColorUtil.fromDartColor(Colors.deepOrange),
        outsideLabelStyleAccessorFn: (ExpenseReport row, _) =>
            charts.TextStyleSpec(fontSize: 9),
        labelAccessorFn: (ExpenseReport row, _) =>
            '${row.expenses.toString().toCurrency!}',
      )
    ];
  }

  void init() async {
    setBusy(true);
    await getAllExpense();
    computeJan();
    computeFeb();
    computeMar();
    computeApr();
    computeMay();
    computeJun();
    computeJul();
    computeAug();
    computeSep();
    computeOct();
    computeNov();
    computeDec();
    await Future.delayed(Duration(seconds: 1));
    setBusy(false);
  }

  Future<void> getAllExpense() async {
    expenses = await apiService.getExpenseList();
    notifyListeners();
  }

  void computeJan() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 1);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeFeb() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 2);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeMar() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 3);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeApr() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 4);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeMay() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 5);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeJun() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 6);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeJul() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 7);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeAug() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 8);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeSep() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 9);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeOct() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 10);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeNov() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 11);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeDec() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 12);
    for (Expense expense in expenses) {
      if (date.isSameDateMonth(expense.date.toDateTime()!))
        total += expense.totalAmount;
    }
    final data =
        ExpenseReport(month: DateFormat.MMM().format(date), expenses: total);
    this.data.add(data);
    notifyListeners();
  }
}

class ExpenseReport {
  final String month;
  final double expenses;

  const ExpenseReport({required this.month, required this.expenses});
}
