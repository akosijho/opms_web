class MedicalHistory {
  final dynamic id;
  final String date;
  final String? image;

  const MedicalHistory({
    required this.id,
    required this.date,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'date': this.date,
      'file': this.image,
    };
  }

  factory MedicalHistory.fromJson(Map<String, dynamic> map) {
    return MedicalHistory(
      id: map['id'] as dynamic,
      date: map['date'] as String,
      image: map['file'] as String,
    );
  }
}
