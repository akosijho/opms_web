import 'package:opmsapp/ui/views/appoitment_yearly_monthly/appointment_year_month_view_model.dart';
import 'package:opmsapp/ui/views/week_appointment/week_appointment_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ViewAppointmentByPeriod extends StatelessWidget {
  const ViewAppointmentByPeriod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentYearMonthViewModel>.reactive(
      viewModelBuilder: () => AppointmentYearMonthViewModel(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('View Appointments By Period'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: model.index,
          onTap: (index) => model.changeIndex(index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.date_range),
              label: 'WeekLy',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: 'Monthly'),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: 'Yearly'),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: AppointmentIndexStackBody(
              index: model.index,
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentIndexStackBody extends StatelessWidget {
  final index;
  AppointmentIndexStackBody({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        WeekAppointmentView(),

        // PatientsView(),
        // ProceduresView(),
        // MedicineView(),
      ],
    );
  }
}
