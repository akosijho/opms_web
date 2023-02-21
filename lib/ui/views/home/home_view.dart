import 'package:opmsapp/app/app.router.dart';
import 'package:opmsapp/constants/styles/palette_color.dart';
import 'package:opmsapp/ui/views/home/home_view_model.dart';
import 'package:opmsapp/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:opmsapp/ui/widgets/home_appointment/home_appointment.dart';
import 'package:opmsapp/ui/widgets/home_shortcut/home_shortcut.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      onModelReady: (model) {
        model.init();
        model.getAppointment();
      },
      viewModelBuilder: () => HomePageViewModel(),
      builder: (context, model, child) => Scaffold(
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
          child: SingleChildScrollView(
            physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                HomeShortcut(
                  // addProcedureOnTap: () => model.navigationService.pushNamed(
                  //   Routes.AddProcedureView,
                  // ),
                  addPatientOnTap: () => model.navigationService.pushNamed(
                    Routes.AddPatientView,
                  ),
                  // addMedicineOnTap: () => model.navigationService.pushNamed(
                  //   Routes.AddMedicineView,
                  // ),
                  // addExpensesOnTap: () => model.navigationService.pushNamed(
                  //   Routes.AddExpenseView,
                  // ),
                  addPaymentOnTap: () => model.navigationService.pushNamed(
                    Routes.PaymentSelectPatientView,
                  ),
                  financeOnTap: () => model.navigationService.pushNamed(
                    Routes.ReportView,
                  ),
                ),
                model.myAppointments.isNotEmpty
                    ? HomeAppointment(
                        myAppointments: model.myAppointments,
                        isBusy: model.isBusy,
                        navigationService: model.navigationService,
                      )
                    : Center(
                        child: Container(
                          height: 100,
                          child: Text('No Appointments for today'),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
