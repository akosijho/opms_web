

class BalanceNotes {
  String balance;
  final String date;
  // String note;
  final dynamic id;
  bool isPaid;



  BalanceNotes({
    this.id,
    required this.isPaid,
    required this.date,
    required this.balance,
  });

  Map<String, dynamic> toJson(
      {required dynamic id}) {
    return {
      'id': id,
      'balance': this.balance,
      'date': this.date,
      'isPaid': this.isPaid,
    };
  }

  factory BalanceNotes.fromJson(Map<String, dynamic> map) {
    return BalanceNotes(
      id: map['id'] as dynamic,
      balance: map['balance'] as String,
      date: map['date'] as String,
      // note: map['note'] as String,
      isPaid: map['isPaid'] as bool,
    );
  }

  // final currency = NumberFormat("#,##0.00", "en_PH");
  // String? get priceToCurrency {
  //   if (this.balance != '') {
  //     return ' ₱${currency.format(double.tryParse(this.balance ?? '0'))}';
  //   } else {
  //     return null;
  //   }
  // }
}
