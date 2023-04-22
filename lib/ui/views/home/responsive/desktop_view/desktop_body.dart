import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/ui/views/home/home_view_model.dart';
import 'package:opmswebstaff/ui/views/patient_report/patient_report_view.dart';
import 'package:opmswebstaff/ui/views/sales_report/sales_report_view.dart';
import 'package:opmswebstaff/ui/widgets/home_appointment/home_appointment.dart';
import 'package:stacked/stacked.dart';

class MyDesktopBody extends StatelessWidget {
  const MyDesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
        onModelReady: (model) {
          model.init();
          model.getAppointment();
        },
        viewModelBuilder: () => HomePageViewModel(),
        builder: (context, model, child) => Scaffold(
          // backgroundColor: Colors.green[200],
          body: RefreshIndicator(
            color: Palettes.kcBlueMain1,
            onRefresh: () async {
              model.init();
            },
            child: SingleChildScrollView(
              physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(height: 40),
                    // HomeShortcut(
                    //   addProcedureOnTap: () => model.navigationService.pushNamed(
                    //     Routes.AddProcedureView,
                    //   ),
                    //   addPatientOnTap: () => model.navigationService.pushNamed(
                    //     Routes.AddPatientView,
                    //   ),
                    //   addMedicineOnTap: () => model.navigationService.pushNamed(
                    //     Routes.AddMedicineView,
                    //   ),
                    //   addExpensesOnTap: () => model.navigationService.pushNamed(
                    //     Routes.AddExpenseView,
                    //   ),
                    //   addPaymentOnTap: () => model.navigationService.pushNamed(
                    //     Routes.PaymentSelectPatientView,
                    //   ),
                    //   financeOnTap: () => model.navigationService.pushNamed(
                    //     Routes.ReportView,
                    //   ),
                    // ),
                    // model.myAppointments.isNotEmpty
                    //     ? HomeAppointment(
                    //         myAppointments: model.myAppointments,
                    //         isBusy: model.isBusy,
                    //         navigationService: model.navigationService,
                    //       )
                    //     : Center(
                    //         child: Container(
                    //           height: 100,
                    //           child: Text('No Appointments for today'),
                    //         ),
                    //       ),
                    SizedBox(height: 40),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 250,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.green[200],
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child:  Center(
                              child: Text(
                                'Clients: \n' + model.totalPatients.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            height: 250,
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[100],
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: model.myAppointments.isNotEmpty
                                  ? HomeAppointment(
                                myAppointments: model.myAppointments,
                                isBusy: model.isBusy,
                                navigationService: model.navigationService,
                              )
                                  : Center(
                                child: Container(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Text('Appointments'),
                                      Text('No Appointments for today'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 500,
                      width: 740,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent[100],
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SalesReportsView(),
                      ),
                      // child: PatientReportView(showAppBar: false),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
