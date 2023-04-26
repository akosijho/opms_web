import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/ui/views/add_expenses/add_expenses_view.dart';
import 'package:opmswebstaff/ui/views/appointment/appointment_view.dart';
import 'package:opmswebstaff/ui/views/finance/reports_view.dart';
import 'package:opmswebstaff/ui/views/home/home_view.dart';
import 'package:opmswebstaff/ui/views/main_body/main_body_view_model.dart';
import 'package:opmswebstaff/ui/views/medicine/medicine_view.dart';
import 'package:opmswebstaff/ui/views/patient_report/patient_report_view.dart';
import 'package:opmswebstaff/ui/views/patients/patients_view.dart';
import 'package:opmswebstaff/ui/views/payment_select_patient/payment_select_patient_view.dart';
import 'package:opmswebstaff/ui/views/procedures/procedure_view.dart';
import 'package:opmswebstaff/ui/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:opmswebstaff/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

import '../../../main.dart';

class MainBodyView extends StatelessWidget {
  const MainBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainBodyViewModel>.reactive(
      onModelReady: (model) {
        model.init();
        model.getAppointment();
      },
      viewModelBuilder: () => MainBodyViewModel(),
      builder: (context, model, child) => Scaffold(
          extendBody: true,
          drawer: CustomBottomNavigation(
            setSelectedIndex: (index) => model.setSelectedIndex(index),
            selectedIndex: model.selectedIndex,
          ),
          backgroundColor: Colors.grey.shade50,
          appBar: CustomHomePageAppBar(
            image: model.currentUser?.image ?? '',
            name: model.currentUser?.fullName ?? '',
            position: model.currentUser?.position ?? '',
            onTapUser: () => model.goToUserView(model.currentUser!),
            onNotificationTap: () => model.goToNotificationView(),
            onLogOutTap: () => model.logOut(),
            hasNotification: model.notificationCount > 0,
          ),

          body: RefreshIndicator(
            color: Palettes.kcBlueMain1,
            onRefresh: () async {
              model.init();
            },
            child: Row(
              children: [
                CustomBottomNavigation(
                  setSelectedIndex: (index) => model.setSelectedIndex(index),
                  selectedIndex: model.selectedIndex,
                ),
                Expanded(
                  child: IndexStackBody(
                    // index: model.selectedIndex,
                  ),
                )
              ],
            ),
          )


          ),
    );
  }
}

class IndexStackBody extends ViewModelWidget<MainBodyViewModel> {

  IndexStackBody({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context, MainBodyViewModel viewModel) {
    return IndexedStack(
      index: viewModel.selectedIndex,
      children: viewModel.widget
    );
  }
}
