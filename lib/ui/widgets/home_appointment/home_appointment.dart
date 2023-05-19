import 'package:opmswebstaff/app/app.router.dart';
import 'package:opmswebstaff/constants/font_name/font_name.dart';
import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:opmswebstaff/enums/appointment_status.dart';
import 'package:opmswebstaff/extensions/date_format_extension.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/appointment_model/appointment_model.dart';
import 'package:opmswebstaff/ui/views/patient_info/patient_info_view.dart';
import 'package:opmswebstaff/ui/widgets/appointment_card/appointment_card.dart';
import 'package:opmswebstaff/ui/widgets/custom_shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../core/service/navigation/navigation_service.dart';

class HomeAppointment extends StatelessWidget {
  final List<AppointmentModel> myAppointments;
  final bool isBusy;
  final NavigationService navigationService;
  const HomeAppointment(
      {Key? key,
      required this.myAppointments,
      required this.isBusy,
      required this.navigationService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          color: Colors.grey.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 5),
                  SvgPicture.asset('assets/icons/Calendar.svg'),
                  SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      height: 22,
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Appointments Today",
                        style: TextStyles.tsHeading5(color: Palettes.kcNeutral1),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Routes.AppointmentView,
                    child: Container(
                      height: 22,
                      alignment: Alignment.bottomLeft,
                      // child: Row(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Text(
                      //       'View All',
                      //       style: TextStyle(
                      //           fontFamily: FontNames.gilRoy,
                      //           fontWeight: FontWeight.w600,
                      //           fontSize: kfsHeading5,
                      //           color: Palettes.kcBlueMain2),
                      //     ),
                      //     SvgPicture.asset(
                      //       'assets/icons/arrow-right.svg',
                      //       height: 20,
                      //       width: 20,
                      //       color: Palettes.kcBlueMain1,
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
              this.isBusy
                  ? MyShimmer()
                  : AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(5),
                        itemCount:
                            myAppointments.length > 1 ? 1 : myAppointments.length,
                        itemBuilder: (context, i) =>
                            AnimationConfiguration.staggeredList(
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
                                key: ObjectKey(myAppointments[i]),
                                onPatientTap: () =>
                                    // navigationService.pushNamed(
                                    //     Routes.PatientInfoView,
                                    //     arguments: PatientInfoViewArguments(
                                    //         patient: myAppointments[i].patient)),
                                // imageUrl: myAppointments[i].patient.image,
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: Container(
                                        width: 800,
                                        height: 800,
                                        child: PatientInfoView(patient: myAppointments[i].patient),
                                      ),
                                    );
                                  },
                                ),

                                serviceTitle:
                                    myAppointments[i].services![0].serviceName,
                                doctor: myAppointments[i].optometrist,
                                patient: myAppointments[i].patient,
                                appointmentDate: DateFormat.yMMMd()
                                    .format(myAppointments[i].date.toDateTime()!),
                                time:
                                    '${myAppointments[i].startTime.toDateTime()!.toTime()}-'
                                    '${myAppointments[i].endTime.toDateTime()!.toTime()}',
                                appointmentStatus: getAppointmentStatus(
                                    myAppointments[i].appointment_status),
                                appointmentId: myAppointments[i].appointment_id,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
