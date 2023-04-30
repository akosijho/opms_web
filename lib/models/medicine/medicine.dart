import 'package:intl/intl.dart';

class Product {
  final String? id;
  final String productName;
  final String? brandName;
  final String? price;
  final String? image;
  final dynamic dateCreated;
  String? qty;

  Product(
      {this.id,
      required this.productName,
      required this.price,
      this.brandName,
      this.image,
      this.qty,
      this.dateCreated});

  Map<String, dynamic> toJson(
      {String? id, String? image, required dynamic dateCreated, String? qty}) {
    return {
      'id': id,
      'productName': this.productName,
      'price': this.price,
      'image': image ?? '',
      'brandName': this.brandName ?? 'Not Set',
      'dateCreated': dateCreated,
      'qty': this.qty ?? '1',
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      image: map['image'],
      productName: map['productName'] as String,
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
