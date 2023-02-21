import 'package:opmsapp/models/medical_history/medical_history.dart';

class MedHistoryUploadResult {
  final List<MedicalHistory>? medHistory;
  final bool isUploaded;
  final String? message;

  MedHistoryUploadResult._(
      {this.medHistory, this.message, required this.isUploaded});

  factory MedHistoryUploadResult.success(
          {required List<MedicalHistory> medHistory}) =>
      MedHistoryUploadResult._(medHistory: medHistory, isUploaded: true);

  factory MedHistoryUploadResult.failed({required String message}) =>
      MedHistoryUploadResult._(message: message, isUploaded: false);
}
