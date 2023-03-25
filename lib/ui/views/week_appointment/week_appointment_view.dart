import 'package:opmswebstaff/constants/styles/palette_color.dart';
import 'package:opmswebstaff/extensions/date_format_extension.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../enums/appointment_status.dart';
import '../../widgets/appointment_card/appointment_card.dart';
import 'week_appointment_view_model.dart';

class WeekAppointmentView extends StatelessWidget {
  const WeekAppointmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WeekAppointmentViewModel>.reactive(
      viewModelBuilder: () => WeekAppointmentViewModel(),
      onModelReady: (model) {
        debugPrint(model.selectedPeriod?.start.toString());
        debugPrint(model.selectedPeriod?.end.toString());
      },
      builder: (context, model, widget) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            WeekPicker(
              initiallyShowDate: DateTime.now(),
              selectedDate: model.selectedDate,
              firstDate: model.firstDate,
              lastDate: model.lastDate,

              onChanged: model.selectDateChange,
              datePickerStyles: DatePickerRangeStyles(
                selectedPeriodMiddleDecoration: BoxDecoration(
                    color: Palettes.kcPurpleMain, shape: BoxShape.rectangle),
              ),
              // eventDecorationBuilder: _eventDecorationBuilder,
            ),
            Divider(
              height: 2,
              thickness: 2,
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              // physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(5),
              itemCount: model.appointments.length,
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
                      key: ObjectKey(model.appointments[i]),
                      onPatientTap: () {},
                      // imageUrl: model.appointments[i].patient.image,
                      serviceTitle:
                          model.appointments[i].procedures![0].procedureName,
                      doctor: model.appointments[i].dentist,
                      patient: model.appointments[i].patient,
                      appointmentDate: DateFormat.yMMMd()
                          .format(model.appointments[i].date.toDateTime()!),
                      time:
                          '${model.appointments[i].startTime.toDateTime()!.toTime()}'
                          '-${model.appointments[i].endTime.toDateTime()!.toTime()}',
                      appointmentStatus: getAppointmentStatus(
                          model.appointments[i].appointment_status),
                      appointmentId: model.appointments[i].appointment_id,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
