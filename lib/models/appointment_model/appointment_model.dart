import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:opmswebstaff/models/procedure/procedure.dart';

class AppointmentModel {
  final String? appointment_id;
  final Patient patient;
  final String date;
  final String startTime;
  final String endTime;
  final String dentist;
  final String appointment_status;

  final List<dynamic>? procedures;
  final String? dateCreated;
  final bool? isAccepted;

  const AppointmentModel({
    this.appointment_id,
    required this.patient,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.dentist,
    required this.appointment_status,
    this.procedures,
    this.dateCreated,
    this.isAccepted,
  });

  Map<String, dynamic> toJson(
      {required String appointment_id,
      required dynamic dateCreated,
      required String patientId}) {
    return {
      'appointment_id': appointment_id,
      'patient':
          this.patient.toJson(patientId: patientId, dateCreated: dateCreated),
      'date': this.date,
      'startTime': this.startTime,
      'endTime': this.endTime,
      'dentist': this.dentist,
      'appointment_status': this.appointment_status,
      'procedures': this
          .procedures
          ?.map((e) => e.toJson(dateCreated: e.dateCreated, id: e.id))
          .toList(),
      // ?.map((e) => e?.toJson(dateCreated: this.date)),
      'dateCreated': dateCreated,
      'isAccepted': isAccepted ?? true,
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> map) {
    final patient = map['patient'];
    return AppointmentModel(
        appointment_id: map['appointment_id'] as String,
        patient: Patient.fromJson(patient),
        date: map['date'] as String,
        startTime: map['startTime'] as String,
        endTime: map['endTime'] as String,
        dentist: map['dentist'] as String,
        isAccepted: map['isAccepted,'],
        appointment_status: map['appointment_status'] as String,
        procedures: map['procedures']
            .map((procedure) => Procedure.fromJson(procedure))
            .toList(),
        dateCreated: map['dateCreated'].toString());
  }
}
