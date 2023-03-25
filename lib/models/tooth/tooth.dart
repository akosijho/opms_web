import 'package:opmswebstaff/models/procedure/procedure.dart';
import 'package:opmswebstaff/models/tooth_condition/tooth_condition.dart';

class Tooth {
  final dynamic id;
  final int index;
  final List<ToothCondition> toothCondition;
  final List<Procedure> procedures;
  final String payment_status;
  final dynamic payment_id;

  const Tooth({
    this.id,
    required this.index,
    required this.toothCondition,
    required this.procedures,
    required this.payment_status,
    required this.payment_id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'index': this.index,
      'toothStatus': this.toothCondition,
      'procedures': this.procedures,
      'payment_status': this.payment_status,
      'payment_id': this.payment_id,
    };
  }

  factory Tooth.fromJson(Map<String, dynamic> map) {
    return Tooth(
      id: map['id'] as dynamic,
      index: map['index'] as int,
      toothCondition: map['toothStatus'] as List<ToothCondition>,
      procedures: map['procedures'] as List<Procedure>,
      payment_status: map['payment_status'] as String,
      payment_id: map['payment_id'] as dynamic,
    );
  }
}
