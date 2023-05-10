import 'package:opmswebstaff/models/optical_notes/optical_notes.dart';
import 'package:opmswebstaff/models/product/lens.dart';
import 'package:opmswebstaff/models/product/product.dart';


// class Payment {
//   final String? payment_id;
//   final String patient_id;
//   final String patient_name;
//   final String optometrist;
//   final List<dynamic>? opticalNote;
//   final List<dynamic>? productList;
//   final String opticalNoteSubTotal;
//   final String productSubTotal;
//   final String totalAmount;
//   final String payment_type;
//   String paymentDate;
//   String remarks;
//
//   Payment({
//     this.payment_id,
//     required this.patient_name,
//     this.productList,
//     required this.patient_id,
//     required this.optometrist,
//     this.opticalNote,
//     required this.opticalNoteSubTotal,
//     required this.productSubTotal,
//     required this.totalAmount,
//     required this.payment_type,
//     required this.paymentDate,
//     required this.remarks,
//   });
//
//   Map<String, dynamic> toJson(dynamic id) {
//     return {
//       'payment_id': id,
//       'optometrist': this.optometrist,
//       'opticallNote': this
//           .opticalNote
//           ?.map((e) => e.toJson(id: e.id, procedureId: e.service.id))
//           .toList(),
//       'productList': productList
//           ?.map((e) =>
//               e.toJson(dateCreated: e.dateCreated, id: e.id, image: e.image))
//           .toList(),
//       'opticalNoteSubTotal': this.opticalNoteSubTotal,
//       'productSubTotal': this.productSubTotal,
//       'totalAmount': this.totalAmount,
//       'payment_type': this.payment_type,
//       'patient_id': this.patient_id,
//       'patient_name': this.patient_name,
//       'paymentDate': this.paymentDate,
//       'remarks': this.remarks,
//     };
//   }
//
//   factory Payment.fromJson(Map<String, dynamic> map) {
//     return Payment(
//       payment_id: map['payment_id'] as String,
//       optometrist: map['optometrist'] as String,
//       opticalNote: map['opticalNote'] != null
//           ? map['opticalNote']
//               .map((dentalNote) => OpticalNotes.fromJson(dentalNote))
//               .toList()
//           : [],
//       productList: map['productList'] != null
//           ? map['productList']
//               .map((medicine) => Product.fromJson(medicine))
//               .toList()
//           : [],
//       opticalNoteSubTotal: map['opticalNoteSubTotal'] as String,
//       productSubTotal: map['productSubTotal'] as String,
//       totalAmount: map['totalAmount'] as String,
//       payment_type: map['payment_type'] as String,
//       patient_id: map['patient_id'] as String,
//       patient_name: map['patient_name'],
//       paymentDate: map['paymentDate'],
//       remarks: map['remarks'] != null ? map['remarks'] : '',
//     );
//   }
// }

class Payment {
  final String? payment_id;
  final String patient_id;
  final String patient_name;
  final String optometrist;
  final List<dynamic>? opticalNote;
  final List<dynamic>? productList;
  final List<dynamic>? lensList;
  final String opticalNoteSubTotal;
  final String balanceNoteSubTotal;
  final String productSubTotal;
  final String lensSubTotal;
  final String totalAmount;
  final String deposit;
  final String balance;
  final String payment_type;
  String paymentDate;
  String remarks;

  Payment({
    this.payment_id,
    required this.patient_name,
    this.productList,
    this.lensList,
    required this.patient_id,
    required this.optometrist,
    this.opticalNote,
    required this.opticalNoteSubTotal,
    required this.balanceNoteSubTotal,
    required this.productSubTotal,
    required this.lensSubTotal,
    required this.totalAmount,
    required this.deposit,
    required this.balance,
    required this.payment_type,
    required this.paymentDate,
    required this.remarks,
  });

  Map<String, dynamic> toJson(dynamic id) {
    return {
      'payment_id': id,
      'optometrist': this.optometrist,
      'opticalNote': this
          .opticalNote
          ?.map((e) => e.toJson(id: e.id, serviceId: e.service.id))
          .toList(),
      'productList': productList
          ?.map((e) =>
          e.toJson(dateCreated: e.dateCreated, id: e.id, image: e.image))
          .toList(),
      'lensList': lensList
          ?.map((e) =>
          e.toJson(dateCreated: e.dateCreated, id: e.id, image: e.image))
          .toList(),
      'opticalNoteSubTotal': this.opticalNoteSubTotal,
      'balanceNoteSubTotal': this.balanceNoteSubTotal,
      'productSubTotal': this.productSubTotal,
      'lensSubTotal': this.lensSubTotal,
      'totalAmount': this.totalAmount,
      'deposit': this.deposit,
      'balance': this.balance,
      'payment_type': this.payment_type,
      'patient_id': this.patient_id,
      'patient_name': this.patient_name,
      'paymentDate': this.paymentDate,
      'remarks': this.remarks,
    };
  }

  factory Payment.fromJson(Map<String, dynamic> map) {
    return Payment(
      payment_id: map['payment_id'] as String,
      optometrist: map['optometrist'] as String,
      opticalNote: map['opticalNote'] != null
          ? map['opticalNote']
          .map((opticalNote) => OpticalNotes.fromJson(opticalNote))
          .toList()
          : [],
      productList: map['productList'] != null
          ? map['productList']
          .map((product) => Product.fromJson(product))
          .toList()
          : [],
      lensList: map['lensList'] != null
          ? map['lensList']
          .map((lens) => Lens.fromJson(lens))
          .toList()
          : [],
      opticalNoteSubTotal: map['opticalNoteSubTotal'] as String,
      balanceNoteSubTotal: map['balanceNoteSubTotal'] as String,
      productSubTotal: map['productSubTotal'] as String,
      lensSubTotal: map['lensSubTotal'] as String,
      totalAmount: map['totalAmount'] as String,
      deposit: map['deposit'] as String,
      balance: map['balance'] as String,
      payment_type: map['payment_type'] as String,
      patient_id: map['patient_id'] as String,
      patient_name: map['patient_name'],
      paymentDate: map['paymentDate'],
      remarks: map['remarks'] != null ? map['remarks'] : '',
    );
  }
}