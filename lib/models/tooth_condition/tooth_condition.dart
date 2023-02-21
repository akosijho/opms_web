class ToothCondition {
  final dynamic id;
  final String toothCondition;
  final String date;
  final String selectedTooth;

  const ToothCondition({
    this.id,
    required this.selectedTooth,
    required this.toothCondition,
    required this.date,
  });

  Map<String, dynamic> toJson({required id}) {
    return {
      'id': id,
      'toothCondition': this.toothCondition,
      'date': this.date,
      'selectedTooth': this.selectedTooth,
    };
  }

  factory ToothCondition.fromJson(Map<String, dynamic> map) {
    return ToothCondition(
      id: map['id'] as dynamic,
      toothCondition: map['toothCondition'] as String,
      date: map['date'] as String,
      selectedTooth: map['selectedTooth'] as String,
    );
  }
}
