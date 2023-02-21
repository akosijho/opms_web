import 'package:opmsapp/ui/views/appointment/appointment_view.dart';
import 'package:opmsapp/ui/views/home/home_view.dart';
import 'package:opmsapp/ui/views/main_body/main_body_view_model.dart';
import 'package:opmsapp/ui/views/medicine/medicine_view.dart';
import 'package:opmsapp/ui/views/patients/patients_view.dart';
import 'package:opmsapp/ui/views/procedures/procedure_view.dart';
import 'package:opmsapp/ui/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainBodyView extends StatelessWidget {
  const MainBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainBodyViewModel>.reactive(
      viewModelBuilder: () => MainBodyViewModel(),
      builder: (context, model, child) => Scaffold(
          extendBody: true,
          bottomNavigationBar: CustomBottomNavigation(
            setSelectedIndex: (index) => model.setSelectedIndex(index),
            selectedIndex: model.selectedIndex,
          ),
          body: DoubleBackToCloseApp(
            snackBar: SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 1),
            ),
            child: SafeArea(
              child: IndexStackBody(
                index: model.selectedIndex,
              ),
            ),
          )),
    );
  }
}

class IndexStackBody extends StatelessWidget {
  final index;
  IndexStackBody({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        HomePageView(),
        AppointmentView(),
        PatientsView(),
        ProceduresView(),
        MedicineView(),
      ],
    );
  }
}
