import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opmswebstaff/models/appointment_model/appointment_model.dart';
import 'package:opmswebstaff/models/balance_notes/balance_notes.dart';
import 'package:opmswebstaff/models/expense/expense.dart';
import 'package:opmswebstaff/models/medical_history/medical_history.dart';
import 'package:opmswebstaff/models/notification/notification_model.dart';
import 'package:opmswebstaff/models/notification_token/notification_token_model.dart';
import 'package:opmswebstaff/models/optical_certificate/optical_certificate.dart';
import 'package:opmswebstaff/models/optical_notes/optical_notes.dart';
import 'package:opmswebstaff/models/optical_receipt/optical_receipt.dart';
import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:opmswebstaff/models/prescription/prescription.dart';
import 'package:opmswebstaff/models/product/lens.dart';
import 'package:opmswebstaff/models/product/product.dart';
import 'package:opmswebstaff/models/query_result/query_result.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:opmswebstaff/models/tooth_condition/tooth_condition.dart';
import 'package:opmswebstaff/models/upload_results/image_upload_result.dart';
import 'package:opmswebstaff/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<dynamic>? addProduct({required Product product, String? image});

  Future<List<Product>> searchProduct(String query);

  Stream<List<Product>> getProductList();

  Future<dynamic>? addService({required Service service});

  Future<List<Service>> searchService(String query);

  Stream<List<Service>> getServiceList();

  Future<String> createAppointment(AppointmentModel appointment);

  Future<ImageUploadResult> uploadProductImage(
      {required File imageToUpload, required String genericName});

  Future<List<UserModel>> searchOptometrist({required String query});

  Stream<List<AppointmentModel>> getAppointmentToday();

  Future<List<AppointmentModel>> getAppointmentAccordingToDate(
      {DateTime? date});

  Future<void> deleteAppointment({required String appointmentId});

  Future<void> deleteService({required String procedureId});

  Future<void> deleteProduct({required String medicineId});

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

  Future<void> addOpticalNotes(
      {required String toothId,
      required dynamic patientId,
      required OpticalNotes opticalNotes,
      required dynamic serviceId});

  Future<List<ToothCondition>?> getDentalConditionList(
      {required dynamic patientId, String? toothId});

  Future<List<OpticalNotes>?> getOpticalNotesList(
      {required dynamic patientId, String? toothId, bool? isPaid});

  Stream<List<Patient>> getPatientDentalCondition(String patientId);

  Future<void> updateOpticalAmountField(
      {required dynamic patientId,
      String? toothId,
      required dental_noteId,
      required dynamic procedureId,
      required String price});

  Future<QueryResult> addPayment({required Payment payment});

  Future<void> updateOpticalANotePaidStatus(
      {required dynamic patientId,
        String? toothId,
        required optical_noteId,
        required bool isPaid});

  Future<Payment> getPaymentInfo({required String paymentId});

  Future<QueryResult> addExpense({required Expense expense});

  Future<List<Expense>> getExpenseList({String? date});

  Future<List<Payment>> getPaymentByPatient({required dynamic patientId});

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

  Future<QueryResult> addOpticalCertificate(
      {required OpticalCertificate opticalCertificate, required Patient patient});

  Stream listenToOpticalCertChanges({required Patient patient});

  Future<List<OpticalCertificate>> getOpticalCert({required Patient patient});

  Future<List<OpticalReceipt>> getOpticalRec({required Patient patient});

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

  Future<List<Service>> getService();

  Future<List<Product>> getProducts();

  Future<QueryResult> updateService(Service service);

  Future<QueryResult> updateProduct(Product product);

  Future<void> deleteLens({required String lensId});

  Future<dynamic>? addLens({required Lens lens, String? image});

  Stream<List<Lens>> getLensList();

  Future<QueryResult> updateLens(Lens lens);

  Future<List<BalanceNotes>?> getBalanceList(
      {required dynamic patientId, bool? isPaid});

  Future<void> updateBalanceAmountField(
      {required dynamic patientId,
        required balance_noteId,
        required String price
      });
  Future<void> updateBalanceANotePaidStatus(
      {required dynamic patientId,
        required balance_noteId,
        required bool isPaid});
}
