class Expense {
  final dynamic id;
  final double totalAmount;
  List<dynamic> items;
  final String date;
  final String note;

  Expense({
    this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toJson(dynamic id) {
    return {
      'id': id,
      'amount': this.totalAmount,
      'date': this.date,
      'note': this.note,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  factory Expense.fromJson(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as dynamic,
      totalAmount: map['amount'] as double,
      date: map['date'] as String,
      note: map['note'] as String,
      items: map['items']
          .map((medicine) => ExpenseItem.fromJson(medicine))
          .toList(),
    );
  }
}

class ExpenseItem {
  dynamic id;
  String itemName;
  int itemQty;
  double amount;

  ExpenseItem({
    required this.id,
    required this.itemName,
    required this.itemQty,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'itemName': this.itemName,
      'itemQty': this.itemQty,
      'amount': this.amount,
    };
  }

  factory ExpenseItem.fromJson(Map<String, dynamic> map) {
    return ExpenseItem(
      id: map['id'],
      itemName: map['itemName'] as String,
      itemQty: map['itemQty'] as int,
      amount: map['amount'] as double,
    );
  }
}
