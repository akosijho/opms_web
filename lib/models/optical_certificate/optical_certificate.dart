class OpticalCertificate {
  dynamic id;
  String? dateCreated;
  String service;
  String date;

  OpticalCertificate({
    this.id,
    this.dateCreated,
    required this.service,
    required this.date,
  });

  Map<String, dynamic> toJson(
      {required dynamic id, required String dateCreated}) {
    return {
      'id': id,
      'dateCreated': dateCreated,
      'service': this.service,
      'date': this.date,
    };
  }

  factory OpticalCertificate.fromJson(Map<String, dynamic> map) {
    return OpticalCertificate(
      id: map['id'] as dynamic,
      dateCreated: map['dateCreated'] as String,
      service: map['service'] as String,
      date: map['date'] as String,
    );
  }
}
