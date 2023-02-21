class Prescription {
  final dynamic id;
  final String date;
  List<dynamic> prescriptionItems;

  Prescription({
    this.id,
    required this.date,
    required this.prescriptionItems,
  });

  Map<String, dynamic> toJson({required dynamic id}) {
    return {
      'id': id,
      'date': this.date,
      'prescriptionItems':
          this.prescriptionItems.map((e) => e.toJson()).toList(),
    };
  }

  factory Prescription.fromJson(Map<String, dynamic> map) {
    return Prescription(
      id: map['id'] as dynamic,
      date: map['date'] as String,
      prescriptionItems: map['prescriptionItems']
          .map((prescriptionItems) =>
              PrescriptionItem.fromJson(prescriptionItems))
          .toList(),
    );
  }
}

//////
//
//
//////
class PrescriptionItem {
  String inscription;
  String subscription;
  String signatura;

  PrescriptionItem({
    required this.inscription,
    required this.subscription,
    required this.signatura,
  });

  Map<String, dynamic> toJson() {
    return {
      'inscription': this.inscription,
      'subscription': this.subscription,
      'signatura': this.signatura,
    };
  }

  factory PrescriptionItem.fromJson(Map<String, dynamic> map) {
    return PrescriptionItem(
      inscription: map['inscription'] as String,
      subscription: map['subscription'] as String,
      signatura: map['signatura'] as String,
    );
  }
}
