import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opmsapp/models/appointment_model/appointment_model.dart';
import 'package:opmsapp/models/dental_notes/dental_notes.dart';
import 'package:opmsapp/models/expense/expense.dart';
import 'package:opmsapp/models/medical_history/medical_history.dart';
import 'package:opmsapp/models/medicine/medicine.dart';
import 'package:opmsapp/models/notification/notification_model.dart';
import 'package:opmsapp/models/notification_token/notification_token_model.dart';
import 'package:opmsapp/models/patient_model/patient_model.dart';
import 'package:opmsapp/models/prescription/prescription.dart';
import 'package:opmsapp/models/procedure/procedure.dart';
import 'package:opmsapp/models/query_result/query_result.dart';
import 'package:opmsapp/models/tooth_condition/tooth_condition.dart';
import 'package:opmsapp/models/upload_results/image_upload_result.dart';
import 'package:opmsapp/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/dental_certificate/dental_certificate.dart';
import '../../../models/payment/payment.dart';

abstract class ApiService {
  User? get currentFirebaseUser;

  Future<bool> checkUserStatus();

  Future<void> createUser(UserModel user);

  Future<void> saveFCMToken();

  Future<void> updateUser();

  Future<ImageUploadResult> uploadProfileImage(
      {required File imageToUpload, required String imageFileName});

  Future<ImageUploadResult> uploadPatientProfileImage(
      {required File imageToUpload, required String patientId});

  Future<DocumentReference> createPatientID();

  Future<dynamic> addPatient(
      {required Patient patient, required DocumentReference patientRef});

  Stream<UserModel> getUserAccountDetails();

  Stream<List<Patient>> getPatients();

  Future<List<Patient>> searchPatient(String query);

  Future<dynamic>? addMedicine({required Medicine medicine, String? image});

  Future<List<Medicine>> searchMedicine(String query);

  Stream<List<Medicine>> getMedicineList();

  Future<dynamic>? addProcedure({required Procedure procedure});

  Future<List<Procedure>> searchProcedure(String query);

  Stream<List<Procedure>> getProcedureList();

  Future<String> createAppointment(AppointmentModel appointment);

  Future<ImageUploadResult> uploadMedicineImage(
      {required File imageToUpload, required String genericName});

  Future<List<UserModel>> searchDentist({required String query});

  Stream<List<AppointmentModel>> getAppointmentToday();

  Future<List<AppointmentModel>> getAppointmentAccordingToDate(
      {DateTime? date});

  Future<void> deleteAppointment({required String appointmentId});

  Future<void> deleteProcedure({required String procedureId});

  Future<void> deleteMedicine({required String medicineId});

  Future<void> deleteUser({required String userId});

  Stream listenToAppointmentChanges();

  Future<ImageUploadResult> uploadMedicalHistoryPhoto(
      {required File imageToUpload,
      required String patientId,
      required String fileName});

  Future<List<MedicalHistory>?> getPatientMedicalRecord(
      {required dynamic patientId});

  Future<void> addToothCondition(
      {required String toothId,
      required dynamic patientId,
      required ToothCondition toothCondition});

  Future<void> addToothDentalNotes(
      {required String toothId,
      required dynamic patientId,
      required DentalNotes dentalNotes,
      required dynamic procedureId});

  Future<List<ToothCondition>?> getDentalConditionList(
      {required dynamic patientId, String? toothId});

  Future<List<DentalNotes>?> getDentalNotesList(
      {required dynamic patientId, String? toothId, bool? isPaid});

  Stream<List<Patient>> getPatientDentalCondition(String patientId);

  Future<void> updateDentalAmountField(
      {required dynamic patientId,
      String? toothId,
      required dental_noteId,
      required dynamic procedureId,
      required String price});

  Future<QueryResult> addPayment({required Payment payment});

  Future<void> updateDentalANotePaidStatus(
      {required dynamic patientId,
      String? toothId,
      required dental_noteId,
      required bool isPaid});

  Future<Payment> getPaymentInfo({required String paymentId});

  Future<QueryResult> addExpense({required Expense expense});

  Future<List<Expense>> getExpenseList({String? date});

  Future<List<Payment>> getPaymentByPatient({dynamic patientId});

  Future<List<AppointmentModel>> getAppointmentsByPatient({dynamic patientId});

  Future<QueryResult> updateAppointmentStatus(
      {required dynamic appointmentId, required String appointmentStatus});

  Future<List<Payment>> getAllPayments();

  Stream listenToPaymentChanges();

  Stream listenToExpenseChanges();

  Stream listenToPrescription(dynamic patientId);

  Future<QueryResult> addPrescription(
      {required Prescription prescription, required dynamic patientId});

  Future<List<Prescription>> getPatientPrescription(
      {required dynamic patientId});

  Future<QueryResult> addDentalCertificate(
      {required DentalCertificate dentalCertificate, required Patient patient});

  Stream listenToDentalCertChanges({required Patient patient});

  Future<List<DentalCertificate>> getDentalCert({required Patient patient});

  Future<QueryResult> updatePatientInfo({required Patient patient});

  Stream listenToPatientChanges({required String patientId});

  Future<Patient> getPatientInfo({required String patientId});

  Future<int> getAllPatientCount();

  Future<void> saveUserFcmToken(NotificationToken notificationToken);

  Future<QueryResult> updateUserStatus(
      {required String userId, required String status});

  Future<QueryResult> updateUserInfo({required UserModel user});

  Future<QueryResult> updateUserPhoto(
      {required String image, required String userId});

  Future<QueryResult> updatePatientPhoto(
      {required String image, required String patientID});

  Future<void> saveNotification(
      {required NotificationModel notification, required String typeId});

  Future<void> deleteNotification({required String notificationId});

  Future<void> markReadNotification({required String notificationId});

  Future<List<NotificationModel>> getNotification({required String userId});

  Stream listenToNotificationChanges({required String userId});

  Future<int> getTotalMalePatient();

  Future<int> getTotalFeMalePatient();

  Future<AppointmentModel> getAppointmentById(String id);

  Future<List<Procedure>> getProcedures();

  Future<QueryResult> updateProcedure(Procedure procedure);
}
