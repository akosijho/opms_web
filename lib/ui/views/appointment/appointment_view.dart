import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/enums/appointment_status.dart';
import 'package:opmswebstaff/extensions/date_format_extension.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/appointment_model/appointment_model.dart';
import 'package:opmswebstaff/ui/views/appointment/appointment_view_model.dart';
import 'package:opmswebstaff/ui/widgets/appointment_card/appointment_card.dart';
import 'package:opmswebstaff/ui/widgets/custom_shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';

class AppointmentView extends StatelessWidget {
  final AppointmentModel? appointment;
  const AppointmentView({Key? key, this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentViewModel>.reactive(
      viewModelBuilder: () => AppointmentViewModel(),
      onModelReady: (model) async {
        final dateToday =
            DateFormat('yyyy-MM-dd 00:00:00.000').format(DateTime.now()).toDateTime();
            model.getAppointmentByDate(dateToday);
      },
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Clinic Appointments',
              style: TextStyles.tsHeading3(color: Colors.white),
            ),
            // actions: [
            //   TextButton(
            //     onPressed: () => model.goToViewAppointmentByPeriod(),
            //     child: Text('View By Period'),
            //     style: TextButton.styleFrom(
            //       primary: Colors.white,
            //     ),
            //   ),
            // ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          // floatingActionButton: FloatingActionButton.extended(
          //   heroTag: null,
          //   onPressed: model.goToSelectPatient(context),
          //   label: Text('Add Appointment'),
          // ),
          floatingActionButton: FloatingActionButton.extended(
            heroTag: null,
            onPressed: () => model.goToSelectPatient(context),
            label: Text('Add Appointment'),
          ),

          body: Container(
            color: Colors.grey.shade50,
            child: ListView(
              primary: true,
              children: [
                Container(
                  color: Palettes.kcBlueMain1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 4, right: 4, bottom: 4),
                    child: CalendarTimeline(
                      key: ObjectKey(model.appointmentList),
                      initialDate: model.selectedDate,
                      firstDate: DateTime.utc(2021, 12),
                      lastDate: DateTime(2026, 12),
                      onDateSelected: (date) {
                        model.getAppointmentByDate(date);
                        // model.getAppointmentByDate(date!);
                      },
                      monthColor: Colors.white,
                      activeBackgroundDayColor: Colors.white,
                      dayColor: Colors.white,
                      activeDayColor: Palettes.kcBlueMain1,
                      // selectableDayPredicate: ,
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey),
                Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 4,
                    children: [
                      FilterChip(
                        label: Text('All',
                            style: TextStyle(
                                color: model.filter == 'ALL'
                                    ? Colors.white
                                    : Colors.black)),
                        selected: model.filter == 'ALL',
                        onSelected: (bool) => model.getAppointmentByAll(),
                        selectedColor: Palettes.kcBlueMain1,
                        checkmarkColor: Colors.white,
                      ),
                      FilterChip(
                        label: Text(
                          'Completed',
                          style: TextStyle(
                              color: model.filter ==
                                      AppointmentStatus.Completed.name
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        selected:
                            model.filter == AppointmentStatus.Completed.name,
                        onSelected: (bool) => model.getAppointmentByCompleted(),
                        selectedColor: Palettes.kcCompleteColor,
                        checkmarkColor: Colors.white,
                      ),
                      FilterChip(
                        label: Text('Pending',
                            style: TextStyle(
                                color: model.filter ==
                                        AppointmentStatus.Pending.name
                                    ? Colors.white
                                    : Colors.black)),
                        selected:
                            model.filter == AppointmentStatus.Pending.name,
                        onSelected: (bool) => model.getAppointmentByPending(),
                        selectedColor: Palettes.kcPendingColor,
                        checkmarkColor: Colors.white,
                      ),
                      FilterChip(
                        label: Text('Request',
                            style: TextStyle(
                                color: model.filter ==
                                        AppointmentStatus.OnRequest.name
                                    ? Colors.white
                                    : Colors.black)),
                        selected:
                            model.filter == AppointmentStatus.OnRequest.name,
                        onSelected: (bool) => model.getAppointmentByRequest(),
                        selectedColor: Colors.brown,
                        checkmarkColor: Colors.white,
                      ),
                      FilterChip(
                        label: Text(
                          'Declined',
                          style: TextStyle(
                              color: model.filter ==
                                      AppointmentStatus.Declined.name
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        selected:
                            model.filter == AppointmentStatus.Declined.name,
                        onSelected: (bool) => model.getAppointmentByDeclined(),
                        selectedColor: Colors.red,
                        checkmarkColor: Colors.white,
                      ),
                      FilterChip(
                        label: Text('Cancelled',
                            style: TextStyle(
                                color: model.filter ==
                                        AppointmentStatus.Cancelled.name
                                    ? Colors.white
                                    : Colors.black)),
                        selected:
                            model.filter == AppointmentStatus.Cancelled.name,
                        onSelected: (bool) => model.getAppointmentByCancelled(),
                        selectedColor: Palettes.kcCancelledColor,
                        checkmarkColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey),
                Container(
                  color: Colors.grey.shade50,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: model.appointmentList.isNotEmpty
                      ? appointmentCardHelper(
                          appointmentList: model.appointmentList,
                          isBusy: model.isBusy,
                          onDeleteItem: (index) =>
                              model.deleteAppointment(index),
                          navigator: model.navigationService)
                      : Container(
                          height: 500,
                          child: Center(
                              child: Text('No Appointment for this date.'))),
                ),
                SizedBox(height: 100),
              ],
            ),
          )),
    );
  }

  Widget appointmentCardHelper(
      {required List<AppointmentModel> appointmentList,
      required bool isBusy,
      required NavigationService navigator,
      required Function(int index) onDeleteItem}) {
    if (isBusy) {
      return MyShimmer();
    } else {
      return ListView.builder(
        shrinkWrap: true,
        primary: false,
        // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(5),
        itemCount: appointmentList.length,
        itemBuilder: (context, i) => AnimationConfiguration.staggeredList(
          position: i,
          duration: Duration(milliseconds: 500),
          child: SlideAnimation(
            verticalOffset: 90.0,
            // horizontalOffset: 300,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 850),
            child: FadeInAnimation(
              curve: Curves.easeInOut,
              delay: Duration(milliseconds: 350),
              duration: Duration(milliseconds: 1000),
              child: AppointmentCard(
                key: ObjectKey(appointmentList[i]),
                onPatientTap: () => navigator.pushNamed(
                    Routes.PatientInfoView,
                    arguments: PatientInfoViewArguments(
                        patient: appointmentList[i].patient)),
                // imageUrl: appointmentList[i].patient.image,
                serviceTitle: appointmentList[i].services![0].serviceName,
                doctor: appointmentList[i].optometrist,
                patient: appointmentList[i].patient,
                appointmentDate: DateFormat.yMMMd()
                    .format(appointmentList[i].date.toDateTime()!),
                time:
                    '${appointmentList[i].startTime.toDateTime()!.toTime()}-${appointmentList[i].endTime.toDateTime()!.toTime()}',
                appointmentStatus: getAppointmentStatus(
                    appointmentList[i].appointment_status),
                appointmentId: appointmentList[i].appointment_id,
              ),
            ),
          ),
        ),
      );
    }
  }
}
