import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Procedure extends Equatable {
  String? id;
  String procedureName;
  String? price;
  List<dynamic> searchIndex;
  dynamic dateCreated;

  Procedure(
      {this.id,
      required this.procedureName,
      required this.searchIndex,
      this.price,
      this.dateCreated});

  Map<String, dynamic> toJson({String? id, required dynamic dateCreated}) {
    return {
      'id': id,
      'procedureName': this.procedureName,
      'price': this.price,
      'dateCreated': dateCreated,
      'searchIndex': this.searchIndex,
    };
  }

  factory Procedure.fromJson(Map<String, dynamic> map) {
    return Procedure(
        searchIndex: map["searchIndex"] != null
            ? map["searchIndex"] as List<dynamic>
            : [],
        id: map['id'] as String,
        procedureName: map['procedureName'] as String,
        price: (map['price']) != null ? map['price'] : '',
        dateCreated: map['dateCreated']);
  }

  final currency = NumberFormat("#,##0.00", "en_PH");
  String? get priceToCurrency {
    if (this.price != '') {
      return ' ₱${currency.format(double.tryParse(this.price ?? '0'))}';
    } else {
      return null;
    }
  }

  @override
  List<Object?> get props =>
      [id, procedureName, price, priceToCurrency, dateCreated];
}
