import 'package:opmsapp/constants/styles/palette_color.dart';
import 'package:opmsapp/extensions/date_format_extension.dart';
import 'package:opmsapp/extensions/string_extension.dart';
import 'package:opmsapp/ui/views/view_patient_appointment/view_patient_appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../enums/appointment_status.dart';
import '../../../models/patient_model/patient_model.dart';
import '../../widgets/appointment_card/appointment_card.dart';

class ViewPatientAppointment extends StatelessWidget {
  final Patient patient;
  const ViewPatientAppointment({Key? key, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewPatientAppointmentViewModel>.reactive(
      viewModelBuilder: () => ViewPatientAppointmentViewModel(),
      onModelReady: (model) {
        model.init(patientId: patient.id);
        model.listenToAppointmentChanges(patientId: patient.id);
      },
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text("Patient's Appointments"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => model.addAppointment(patient),
            label: Text('Add Appointment')),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'List Of Patient Appointments',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Divider(
                    height: 2,
                    thickness: 2,
                    color: Palettes.kcDarkerBlueMain1,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            model.patientListOfAppointments.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, i) => AppointmentCard(
                          key: ObjectKey(model.patientListOfAppointments[i]),
                          onPatientTap: () {},
                          imageUrl:
                              model.patientListOfAppointments[i].patient.image,
                          serviceTitle: model.patientListOfAppointments[i]
                              .procedures![0].procedureName,
                          doctor: model.patientListOfAppointments[i].dentist,
                          patient: model.patientListOfAppointments[i].patient,
                          appointmentDate: DateFormat.yMMMd().format(model
                              .patientListOfAppointments[i].date
                              .toDateTime()!),
                          time:
                              '${model.patientListOfAppointments[i].startTime.toDateTime()!.toTime()}-${model.patientListOfAppointments[i].endTime.toDateTime()!.toTime()}',
                          appointmentStatus: getAppointmentStatus(model
                              .patientListOfAppointments[i].appointment_status),
                          appointmentId:
                              model.patientListOfAppointments[i].appointment_id,
                        ),
                    separatorBuilder: (context, index) => SizedBox(height: 6),
                    itemCount: model.patientListOfAppointments.length)
                : Container(
                    height: 500,
                    child: Center(
                        child: Text('No Appointments added on this patient ')),
                  ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
