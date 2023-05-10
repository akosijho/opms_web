import 'package:intl/intl.dart';

class Lens {
  final String? id;
  final String lensName;
  final String? brandName;
  final String? price;
  final String? image;
  final dynamic dateCreated;
  String? qty;

  Lens(
      {this.id,
        required this.lensName,
        required this.price,
        this.brandName,
        this.image,
        this.qty,
        this.dateCreated});

  Map<String, dynamic> toJson(
      {String? id, String? image, required dynamic dateCreated, String? qty}) {
    return {
      'id': id,
      'lensName': this.lensName,
      'price': this.price,
      'image': image ?? '',
      'brandName': this.brandName ?? 'Not Set',
      'dateCreated': dateCreated,
      'qty': this.qty ?? '1',
    };
  }

  factory Lens.fromJson(Map<String, dynamic> map) {
    return Lens(
      id: map['id'],
      image: map['image'],
      lensName: map['lensName'] as String,
      price: map['price'] as String,
      brandName: map['brandName'],
      dateCreated: map['dateCreated'],
      qty: map['qty'].toString(),
    );
  }

  final currency = NumberFormat("#,##0.00", "en_PH");
  String? get priceToCurrency {
    if (this.price != '') {
      return ' ₱${currency.format(double.tryParse(this.price ?? '0'))}';
    } else {
      return null;
    }
  }
}
