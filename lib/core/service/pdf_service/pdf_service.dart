import 'dart:typed_data';

import 'package:opmswebstaff/models/optical_certificate/optical_certificate.dart';
import 'package:opmswebstaff/models/payment/payment.dart';
import 'package:opmswebstaff/models/prescription/prescription.dart';

import '../../../models/patient_model/patient_model.dart';

abstract class PdfService {
//
  Future<Uint8List> printReceipt({required Payment payment});

  Future<Uint8List> printPrescription(
      {required Prescription prescription, required Patient patient});

  Future<Uint8List> printOpticalCertificate(
      {required OpticalCertificate opticalCertificate, required Patient patient});

  Future<void> savePdfFile2(
      {required String fileName, required Uint8List byteList});

  Future<void> savePdfFile(
      {required Uint8List byteList});
}
