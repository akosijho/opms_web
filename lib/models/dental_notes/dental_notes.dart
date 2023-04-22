import 'package:opmswebstaff/models/procedure/procedure.dart';

class DentalNotes {
  final String? selectedTooth;
  final String sphere;
  final String cylinder;
  final String axis;
  final String pd;
  final String add;
  final String va;

  //contact lens
  final String sphereCL;
  final String cylinderCL;
  final String axisCL;
  final String bcCL;
  final String diaCL;
  final String tintCL;
  final Procedure procedure;
  final String date;
  String note;
  final dynamic id;
  bool isPaid;



  DentalNotes({
    this.id,
    required this.isPaid,
    this.selectedTooth,
    required this.sphere,
    required this.cylinder,
    required this.axis,
    required this.pd,
    required this.add,
    required this.va,
    required this.sphereCL,
    required this.cylinderCL,
    required this.axisCL,
    required this.bcCL,
    required this.diaCL,
    required this.tintCL,
    required this.procedure,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toJson(
      {required dynamic id, required dynamic procedureId}) {
    return {
      'id': id,
      'selectedTooth': this.sphere,
      'sphere': this.sphere,
      'cylinder': this.cylinder,
      'axis': this.axis,
      'pd': this.pd,
      'add': this.add,
      'va': this.va,
      'sphereCL': this.sphereCL,
      'cylinderCL': this.cylinderCL,
      'axisCL': this.axisCL,
      'bcCL': this.bcCL,
      'diaCL': this.diaCL,
      'tintCL': this.tintCL,
      'procedure': this
          .procedure
          .toJson(dateCreated: DateTime.now().toString(), id: procedureId),
      'date': this.date,
      'note': this.note,
      'isPaid': this.isPaid,
    };
  }

  factory DentalNotes.fromJson(Map<String, dynamic> map) {
    return DentalNotes(
      id: map['id'] as dynamic,
      selectedTooth: map['selectedTooth'],
      // selectedTooth: map['selectedTooth'] as String,
      sphere: map['sphere'] as String,
      cylinder: map['cylinder'] as String,
      axis: map['axis'] as String,
      pd: map['pd'] as String,
      add: map['add'] as String,
      va: map['va'] as String,
      sphereCL: map['sphereCL'] as String,
      cylinderCL: map['cylinderCL'] as String,
      axisCL: map['axisCL'] as String,
      bcCL: map['bcCL'] as String,
      diaCL: map['diaCL'] as String,
      tintCL: map['tintCL'] as String,
      procedure: Procedure.fromJson(map['procedure']),
      date: map['date'] as String,
      // note: map['note'] as String,
      note: map['note'] != null ? map['note'] : '',
      isPaid: map['isPaid'] as bool,
    );
  }
}
