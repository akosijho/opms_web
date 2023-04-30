import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:opmswebstaff/models/service/service.dart';

class AppointmentModel {
  final String? appointment_id;
  final Patient patient;
  final String date;
  final String startTime;
  final String endTime;
  final String optometrist;
  final String appointment_status;

  final List<dynamic>? services;
  final String? dateCreated;
  final bool? isAccepted;

  const AppointmentModel({
    this.appointment_id,
    required this.patient,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.optometrist,
    required this.appointment_status,
    this.services,
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
      'optometrist': this.optometrist,
      'appointment_status': this.appointment_status,
      'services': this
          .services
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
        optometrist: map['optometrist'] as String,
        isAccepted: map['isAccepted,'],
        appointment_status: map['appointment_status'] as String,
        services: map['services']
            .map((services) => Service.fromJson(services))
            .toList(),
        dateCreated: map['dateCreated'].toString());
  }

}
