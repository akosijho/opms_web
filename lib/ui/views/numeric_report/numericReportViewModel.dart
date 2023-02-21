import 'package:opmsapp/core/service/api/api_service.dart';
import 'package:opmsapp/core/service/dialog/dialog_service.dart';
import 'package:opmsapp/extensions/date_format_extension.dart';
import 'package:opmsapp/extensions/string_extension.dart';
import 'package:opmsapp/models/payment/payment.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/expense/expense.dart';

class NumericReportViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();

  List<Payment> paymentList = [];
  List<Expense> expenseList = [];
  double totalRevenue = 0;
  double totalExpenses = 0;
  double revMonth = 0;
  double revDay = 0;
  double revYear = 0;
  double expMonth = 0;
  double expDay = 0;
  double expYear = 0;

  void init() async {
    await getAllPayments();
    await getAllExpense();
    computeTotalRevenueByMonth();
    computeTotalRevenueByYear(DateTime.now().year.toString());
    computeTotalRevenueByDay();
    computeTotalExpensesByDay();
    computeTotalExpensesByMonth();
    computeTotalExpensesByYear();
  }

  Future<void> getAllPayments() async {
    paymentList = await apiService.getAllPayments();
    notifyListeners();
    computeAllTimeRevenue();
  }

  Future<void> getAllExpense() async {
    expenseList = await apiService.getExpenseList();
    notifyListeners();
    computeAllTimeExpenses();
  }

  void computeAllTimeRevenue() async {
    for (Payment payment in paymentList) {
      totalRevenue += double.parse(payment.totalAmount);
      notifyListeners();
    }
  }

  void computeTotalRevenueByYear(String date) {
    for (Payment payment in paymentList) {
      if (payment.paymentDate.toDateTime()?.year.toString == date) ;
      revYear += double.parse(payment.totalAmount);
      notifyListeners();
    }
  }

  void computeTotalRevenueByMonth() {
    for (Payment payment in paymentList) {
      if (DateTime.now().isSameDateMonth(payment.paymentDate.toDateTime()!)) ;
      revMonth += double.parse(payment.totalAmount);
      notifyListeners();
    }
  }

  void computeTotalRevenueByDay() {
    for (Payment payment in paymentList) {
      if (DateTime.now().isSameDate(payment.paymentDate.toDateTime()!)) {
        revDay += double.parse(payment.totalAmount);
        notifyListeners();
      }
    }
  }

  void computeAllTimeExpenses() async {
    for (Expense expense in expenseList) {
      totalExpenses += expense.totalAmount;
      notifyListeners();
    }
  }

  void computeTotalExpensesByYear() async {
    for (Expense expense in expenseList) {
      if (DateTime.now().isSameYear(expense.date.toDateTime()!)) {
        expYear += expense.totalAmount;
        notifyListeners();
      }
    }
  }

  void computeTotalExpensesByMonth() async {
    for (Expense expense in expenseList) {
      if (DateTime.now().isSameDateMonth(expense.date.toDateTime()!)) {
        expMonth += expense.totalAmount;
        notifyListeners();
      }
    }
  }

  void computeTotalExpensesByDay() async {
    for (Expense expense in expenseList) {
      if (DateTime.now().isSameDate(expense.date.toDateTime()!)) {
        expDay += expense.totalAmount;
        notifyListeners();
      }
    }
  }
}
