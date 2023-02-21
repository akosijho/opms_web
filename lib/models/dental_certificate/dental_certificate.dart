class DentalCertificate {
  dynamic id;
  String? dateCreated;
  String procedure;
  String date;

  DentalCertificate({
    this.id,
    this.dateCreated,
    required this.procedure,
    required this.date,
  });

  Map<String, dynamic> toJson(
      {required dynamic id, required String dateCreated}) {
    return {
      'id': id,
      'dateCreated': dateCreated,
      'procedure': this.procedure,
      'date': this.date,
    };
  }

  factory DentalCertificate.fromJson(Map<String, dynamic> map) {
    return DentalCertificate(
      id: map['id'] as dynamic,
      dateCreated: map['dateCreated'] as String,
      procedure: map['procedure'] as String,
      date: map['date'] as String,
    );
  }
}
