import 'package:opmswebstaff/ui/views/expenses_report/expenses_report_view.dart';
import 'package:opmswebstaff/ui/views/finance/reports_view_model.dart';
import 'package:opmswebstaff/ui/views/patient_report/patient_report_view.dart';
import 'package:opmswebstaff/ui/views/sales_report/sales_report_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ReportView extends StatelessWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportsViewModel>.reactive(
      viewModelBuilder: () => ReportsViewModel(),
      builder: (context, model, widget) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: model.currentIndex,
          onTap: (index) => model.changeIndex(index),
          iconSize: 28,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Patients',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded), label: 'Sales'),
            BottomNavigationBarItem(
                icon: Icon(Icons.stacked_line_chart), label: 'Expenses'),
          ],
        ),
        body: IndexedStack(
          index: model.currentIndex,
          children: [
            PatientReportView(showAppBar: true),
            SalesReportsView(),
            ExpensesReportView(),
          ],
        ),
      ),
    );
  }
}
