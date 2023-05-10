import 'package:opmswebstaff/models/product/lens.dart';
import 'package:opmswebstaff/models/product/product.dart';

class OpticalReceipt {
  dynamic id;
  String? dateCreated;
  List<dynamic>? product;
  List<dynamic>? lens;
  String opticalNoteSubtotal;
  String balanceNoteSubtotal;
  String productSubtotal;
  String lensSubtotal;
  String totalAmount;
  String deposit;
  String balance;
  String paymentDate;
  String patient_id;
  String patient_name;

  OpticalReceipt({
    this.id,
    this.dateCreated,
    this.product,
    this.lens,
    required this.opticalNoteSubtotal,
    required this.balanceNoteSubtotal,
    required this.productSubtotal,
    required this.lensSubtotal,
    required this.totalAmount,
    required this.deposit,
    required this.balance,
    required this.paymentDate,
    required this.patient_id,
    required this.patient_name,

  });

  Map<String, dynamic> toJson(
      {required dynamic id, required String dateCreated}) {
    return {
      'id': id,
      'dateCreated': dateCreated,
    'productList': product
        ?.map((e) =>
    e.toJson(dateCreated: e.dateCreated, id: e.id, image: e.image))
        .toList(),
    'lensList': lens
        ?.map((e) =>
    e.toJson(dateCreated: e.dateCreated, id: e.id, image: e.image))
        .toList(),
    'opticalNoteSubTotal': this.opticalNoteSubtotal,
    'balanceNoteSubTotal': this.balanceNoteSubtotal,
    'productSubTotal': this.productSubtotal,
    'lensSubTotal': this.lensSubtotal,
    'totalAmount': this.totalAmount,
    'deposit': this.deposit,
    'balance': this.balance,
    'patient_id': this.patient_id,
    'patient_name': this.patient_name,
    'paymentDate': this.paymentDate,
    };
  }

  factory OpticalReceipt.fromJson(Map<String, dynamic> map) {
    return OpticalReceipt(
      id: map['id'] as dynamic,
      dateCreated: map['dateCreated'] as String,
      product: map['productList'] != null
          ? map['productList']
          .map((product) => Product.fromJson(product))
          .toList()
          : [],
      lens: map['lensList'] != null
          ? map['lensList']
          .map((lens) => Lens.fromJson(lens))
          .toList()
          : [],
      opticalNoteSubtotal: map['opticalNoteSubTotal'] as String,
      balanceNoteSubtotal: map['balanceNoteSubTotal'] as String,
      productSubtotal: map['productSubTotal'] as String,
      lensSubtotal: map['lensSubTotal'] as String,
      totalAmount: map['totalAmount'] as String,
      deposit: map['deposit'] as String,
      balance: map['balance'] as String,
      patient_id: map['patient_id'] as String,
      patient_name: map['patient_name'],
      paymentDate: map['paymentDate'],
    );
  }
}
