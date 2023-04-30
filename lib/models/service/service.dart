import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Service extends Equatable {
  String? id;
  String serviceName;
  String? price;
  List<dynamic> searchIndex;
  dynamic dateCreated;

  Service(
      {this.id,
      required this.serviceName,
      required this.searchIndex,
      this.price,
      this.dateCreated});

  Map<String, dynamic> toJson({String? id, required dynamic dateCreated}) {
    return {
      'id': id,
      'serviceName': this.serviceName,
      'price': this.price,
      'dateCreated': dateCreated,
      'searchIndex': this.searchIndex,
    };
  }

  factory Service.fromJson(Map<String, dynamic> map) {
    return Service(
        searchIndex: map["searchIndex"] != null
            ? map["searchIndex"] as List<dynamic>
            : [],
        id: map['id'] as String,
        serviceName: map['serviceName'] as String,
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
      [id, serviceName, price, priceToCurrency, dateCreated];
}
