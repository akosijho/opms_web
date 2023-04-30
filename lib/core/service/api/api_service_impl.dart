import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/models/appointment_model/appointment_model.dart';
import 'package:opmswebstaff/models/optical_certificate/optical_certificate.dart';
import 'package:opmswebstaff/models/expense/expense.dart';
import 'package:opmswebstaff/models/medical_history/medical_history.dart';
import 'package:opmswebstaff/models/medicine/medicine.dart';
import 'package:opmswebstaff/models/notification/notification_model.dart';
import 'package:opmswebstaff/models/notification_token/notification_token_model.dart';
import 'package:opmswebstaff/models/optical_notes/optical_notes.dart';
import 'package:opmswebstaff/models/patient_model/patient_model.dart';
import 'package:opmswebstaff/models/prescription/prescription.dart';
import 'package:opmswebstaff/models/query_result/query_result.dart';
import 'package:opmswebstaff/models/service/service.dart';
import 'package:opmswebstaff/models/tooth_condition/tooth_condition.dart';
import 'package:opmswebstaff/models/upload_results/image_upload_result.dart';
import 'package:opmswebstaff/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../app/app.locator.dart';
import '../../../models/payment/payment.dart';

class ApiServiceImpl extends ApiService {
  final userReference = FirebaseFirestore.instance.collection('users');
  // final connectivityService = locator<ConnectivityService>();

  final appointmentReference =
      FirebaseFirestore.instance.collection('appointments');

  final patientReference = FirebaseFirestore.instance.collection('patients');

  final medicineReference = FirebaseFirestore.instance.collection('products');

  final procedureReference =
      FirebaseFirestore.instance.collection('services');

  final paymentReference = FirebaseFirestore.instance.collection('payments');

  final expenseReference = FirebaseFirestore.instance.collection('expenses');

  final notificationTokensRef =
      FirebaseFirestore.instance.collection('notificationTokens');

  final notificationReference =
      FirebaseFirestore.instance.collection('notifications');

  @override
  User? get currentFirebaseUser => FirebaseAuth.instance.currentUser;

  @override
  Future<bool> checkUserStatus() async {
    final userDoc = await userReference.doc(currentFirebaseUser!.uid).get();
    if (!userDoc.exists) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> createUser(UserModel user) async {
    var userRef = userReference.doc(currentFirebaseUser!.uid);
    userRef.set(user.toJson());
  }

  @override
  Future<void> saveFCMToken() {
    // TODO: implement saveFCMToken
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<ImageUploadResult> uploadProfileImage(
      {required File imageToUpload, required String imageFileName}) async {
    try {
      final profileImageRef = await FirebaseStorage.instance
          .ref('users/${currentFirebaseUser!.uid}/profile-image/profile.jpg');
      final uploadTask = profileImageRef.putFile(imageToUpload);
      await uploadTask;
      final imageUrl = await uploadTask.snapshot.ref.getDownloadURL();

      return ImageUploadResult.success(imageFileName, imageUrl);
    } on FirebaseException catch (e) {
      return ImageUploadResult.error('Image Upload Failed: ${e.message}');
    }
  }

  @override
  Future<DocumentReference> createPatientID() async {
    return await patientReference.doc();
  }

  @override
  Future<dynamic> addPatient(
      {required Patient patient, required DocumentReference patientRef}) async {
    return patientRef.set(patient.toJson(
        patientId: patientRef.id, dateCreated: FieldValue.serverTimestamp()));
  }

  @override
  Future<ImageUploadResult> uploadPatientProfileImage(
      {required File imageToUpload, required String patientId}) async {
    try {
      final patientProfileImage = await FirebaseStorage.instance
          .ref('patients/$patientId'
              '/profile-image/profile.jpg')
          .putFile(imageToUpload);

      final imageUrl = await patientProfileImage.ref.getDownloadURL();

      return ImageUploadResult.success('profile.jpg', imageUrl);
    } on FirebaseException catch (e) {
      return ImageUploadResult.error('Image Upload Failed: ${e.message}');
    }
  }

  @override
  Stream<UserModel> getUserAccountDetails() {
    return userReference
        .doc(currentFirebaseUser!.uid)
        .snapshots()
        .map((data) => UserModel.fromJson(data.data()!));
  }

  @override
  Stream<List<Patient>> getPatients() {
    return patientReference
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((value) => value.docs
            .map((patient) => Patient.fromJson(patient.data()))
            .toList());
  }

  @override
  Future<List<Patient>> searchPatient(String query) async {
    return await patientReference
        .where("searchIndex", arrayContains: query)
        .get()
        .then((value) => value.docs
            .map((patient) => Patient.fromJson(patient.data()))
            .toList());
  }

  @override
  Future? addProduct({required Product product, String? image}) async {
    final medicineRef = await medicineReference.doc();
    return medicineRef.set(product.toJson(
        id: medicineRef.id,
        image: image ?? '',
        dateCreated: FieldValue.serverTimestamp()));
  }

  @override
  Future? addService({required Service service}) async {
    final procedureRef = await procedureReference.doc();
    return procedureRef.set(service.toJson(
        id: procedureRef.id, dateCreated: FieldValue.serverTimestamp()));
  }

  @override
  Stream<List<Product>> getProductList() {
    return medicineReference
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((value) => value.docs
            .map((medicine) => Product.fromJson(medicine.data()))
            .toList());
  }

  @override
  Stream<List<Service>> getServiceList() {
    return procedureReference
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((value) => value.docs
            .map((procedure) => Service.fromJson(procedure.data()))
            .toList());
  }

  @override
  Future<List<Product>> searchProduct(String query) async {
    return await medicineReference
        .where('medicineName', isGreaterThanOrEqualTo: query.toTitleCase())
        .where('medicineName',
            isLessThanOrEqualTo: query.toTitleCase() + '\uf8ff')
        .orderBy('medicineName', descending: true)
        .get()
        .then((value) => value.docs
            .map((medicine) => Product.fromJson(medicine.data()))
            .toList());
  }

  @override
  Future<List<Service>> searchService(String query) async {
    return await procedureReference
        .where("searchIndex", arrayContains: query)
        .get()
        .then((value) => value.docs
            .map((procedure) => Service.fromJson(procedure.data()))
            .toList());
  }

  @override
  Future<String> createAppointment(AppointmentModel appointment) async {
    final appointmentRef = await appointmentReference.doc();

    await appointmentRef.set(appointment.toJson(
        patientId: appointment.patient.id,
        appointment_id: appointmentRef.id,
        dateCreated: FieldValue.serverTimestamp()));
    return appointmentRef.id;
  }

  @override
  Future<ImageUploadResult> uploadProductImage(
      {required File imageToUpload, required String genericName}) async {
    try {
      final profileImageRef =
          await FirebaseStorage.instance.ref('medicines/').child(genericName);
      final uploadTask = profileImageRef.putFile(imageToUpload);
      await uploadTask;
      final imageUrl = await uploadTask.snapshot.ref.getDownloadURL();

      return ImageUploadResult.success('imageFileName', imageUrl);
    } on FirebaseException catch (e) {
      return ImageUploadResult.error('Image Upload Failed: ${e.code}');
    }
  }

  @override
  Future<List<UserModel>> searchOptometrist({required String query}) async {
    if (query != '') {
      return await userReference
          .where("searchIndex", arrayContains: query)
          .where('position', isNotEqualTo: 'Staff')
          .orderBy('position', descending: true)
          .get()
          .then((value) => value.docs
              .map((patient) => UserModel.fromJson(patient.data()))
              .toList());
    } else {
      return await userReference
          .where('position', isNotEqualTo: 'Staff')
          .orderBy('position', descending: true)
          .get()
          .then((value) => value.docs
              .map((patient) => UserModel.fromJson(patient.data()))
              .toList());
    }
  }

  @override
  Stream<List<AppointmentModel>> getAppointmentToday() {
    final dateToday =
        DateFormat('yyyy-MM-dd').format(DateTime.now()).toDateTime().toString();
    return appointmentReference
        .where('date', isEqualTo: dateToday)
        .orderBy('startTime', descending: false)
        .orderBy('appointment_status', descending: false)
        .snapshots()
        .map((event) => event.docs
            .map((value) => AppointmentModel.fromJson(value.data()))
            .toList());
  }

  @override
  Future<void> deleteAppointment({required String appointmentId}) async {
    return await appointmentReference.doc(appointmentId).delete();
  }

  @override
  Future<void> deleteProduct({required String medicineId}) async {
    return await medicineReference.doc(medicineId).delete();
  }

  @override
  Future<void> deleteService({required String procedureId}) async {
    return await procedureReference.doc(procedureId).delete();
  }

  @override
  Future<void> deleteUser({required String userId}) async {
    return await userReference.doc(userId).delete();
  }

  @override
  Future<List<AppointmentModel>> getAppointmentAccordingToDate(
      {DateTime? date}) async {
    if (date == null) {
      return await appointmentReference
          .orderBy('startTime', descending: false)
          .orderBy('appointment_status', descending: true)
          .get()
          .then((value) => value.docs
              .map((appointment) =>
                  AppointmentModel.fromJson(appointment.data()))
              .toList());
    } else {
      return await appointmentReference
          .where('date', isEqualTo: date.toString())
          .orderBy('startTime', descending: false)
          .orderBy('appointment_status', descending: true)
          .get()
          .then((value) => value.docs
              .map((appointment) =>
                  AppointmentModel.fromJson(appointment.data()))
              .toList());
    }
  }

  @override
  Stream listenToAppointmentChanges() {
    return appointmentReference.snapshots();
  }

  @override
  Future<ImageUploadResult> uploadMedicalHistoryPhoto(
      {required File imageToUpload,
      required String patientId,
      required String fileName}) async {
    try {
      final profileImageRef = await FirebaseStorage.instance
          .ref('patients/${patientId}/medical-history/')
          .child(fileName);
      final uploadTask = profileImageRef.putFile(imageToUpload);
      await uploadTask;
      final imageUrl = await uploadTask.snapshot.ref.getDownloadURL();

      return ImageUploadResult.success(patientId, imageUrl);
    } on FirebaseException catch (e) {
      return ImageUploadResult.error('Image Upload Failed: ${e.message}');
    }
  }

  @override
  Future<List<MedicalHistory>?> getPatientMedicalRecord(
      {required dynamic patientId}) async {
    throw UnimplementedError();
  }

  @override
  Future<void> addToothCondition(
      {required String toothId,
      required dynamic patientId,
      required ToothCondition toothCondition}) async {
    final toothDoc = await patientReference
        .doc(patientId)
        .collection('dental_conditions')
        .doc();
    return await toothDoc.set(toothCondition.toJson(id: toothDoc.id));
  }

  @override
  Future<void> addOpticalNotes(
      {required String toothId,
      required dynamic patientId,
      required OpticalNotes opticalNotes,
      required dynamic procedureId}) async {
    final toothDoc =
        await patientReference.doc(patientId).collection('optical_notes').doc();
    return await toothDoc
        .set(opticalNotes.toJson(id: toothDoc.id, procedureId: procedureId));
  }

  @override
  Future<List<ToothCondition>?> getDentalConditionList(
      {required patientId, String? toothId}) async {
    return await patientReference
        .doc(patientId)
        .collection('dental_conditions')
        .where('selectedTooth', isEqualTo: toothId)
        .get()
        .then((value) =>
            value.docs.map((e) => ToothCondition.fromJson(e.data())).toList());
  }

  @override
  Future<List<OpticalNotes>?> getOpticalNotesList(
      {required patientId, String? toothId, bool? isPaid}) async {
    if (toothId == null) {
      if (isPaid == null) {
        return await patientReference
            .doc(patientId)
            .collection('optical_notes')
            .orderBy("selectedTooth")
            .orderBy('date', descending: true)
            .get()
            .then((value) =>
                value.docs.map((e) => OpticalNotes.fromJson(e.data())).toList());
      } else {
        return await patientReference
            .doc(patientId)
            .collection('optical_notes')
            .orderBy('date')
            .where('isPaid', isEqualTo: isPaid)
            .orderBy('selectedTooth')
            .get()
            .then((value) =>
                value.docs.map((e) => OpticalNotes.fromJson(e.data())).toList());
      }
    } else {
      if (isPaid == null) {
        return await patientReference
            .doc(patientId)
            .collection('optical_notes')
            .where('selectedTooth', isEqualTo: toothId)
            .get()
            .then((value) =>
                value.docs.map((e) => OpticalNotes.fromJson(e.data())).toList());
      } else {
        return await patientReference
            .doc(patientId)
            .collection('optical_notes')
            .where('selectedTooth', isEqualTo: toothId)
            .where('isPaid', isEqualTo: isPaid)
            .get()
            .then((value) =>
                value.docs.map((e) => OpticalNotes.fromJson(e.data())).toList());
      }
    }
  }

  @override
  Stream<List<Patient>> getPatientDentalCondition(String patientId) {
    // TODO: implement getPatientDentalCondition

    throw UnimplementedError();
  }

  @override
  Future<void> updateOpticalAmountField(
      {required patientId,
      String? toothId,
      required dental_noteId,
      required procedureId,
      required String price}) async {
    final queryRes = await patientReference
        .doc(patientId)
        .collection('optical_notes')
        .doc(dental_noteId)
        .update({'service.price': "$price"});
  }

  @override
  Future<QueryResult> addPayment({required Payment payment}) async {
    // if (await connectivityService.checkConnectivity()) {
      final paymentDoc = await paymentReference.doc();
      final paymentRes = await paymentDoc.set(payment.toJson(paymentDoc.id));
      return QueryResult.success(returnValue: paymentDoc.id);
    // } else {
    //   return QueryResult.error('Check your network and try again!');
    // }
  }

  @override
  Future<void> updateOpticalANotePaidStatus(
      {required patientId,
      String? toothId,
      required dental_noteId,
      required bool isPaid}) async {
    final queryRes = await patientReference
        .doc(patientId)
        .collection('optical_notes')
        .doc(dental_noteId)
        .update({'isPaid': isPaid});
  }

  @override
  Future<Payment> getPaymentInfo({required String paymentId}) async {
    return await paymentReference
        .doc(paymentId)
        .get()
        .then((value) => Payment.fromJson(value.data()!));
  }

  @override
  Future<QueryResult> addExpense({required Expense expense}) async {
    // if (await connectivityService.checkConnectivity()) {
      final expenseDoc = await expenseReference.doc();

      await expenseDoc.set(expense.toJson(expenseDoc.id));
      return QueryResult.success();
    // } else {
    //   return QueryResult.error('Check your network and try again!');
    // }
  }

  @override
  Future<List<Expense>> getExpenseList({String? date}) async {
    if (date != null) {
      return await expenseReference.orderBy('date').get().then((value) =>
          value.docs.map((e) => Expense.fromJson(e.data())).toList());
    } else {
      return await expenseReference
          .orderBy('date')
          .where('date', isEqualTo: date)
          .get()
          .then((value) =>
              value.docs.map((e) => Expense.fromJson(e.data())).toList());
    }
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByPatient({patientId}) async {
    return await appointmentReference
        .where('patient.id', isEqualTo: patientId)
        .orderBy('date', descending: true)
        .get()
        .then((value) => value.docs
            .map((e) => AppointmentModel.fromJson(e.data()))
            .toList());
  }

  @override
  Future<List<Payment>> getPaymentByPatient({patientId}) async {
    return await paymentReference
        .where('patient_id', isEqualTo: patientId)
        .orderBy("paymentDate", descending: true)
        .get()
        .then((value) =>
            value.docs.map((e) => Payment.fromJson(e.data())).toList());

  }

  @override
  Future<QueryResult> updateAppointmentStatus(
      {required dynamic appointmentId,
      required String appointmentStatus}) async {
    try {
      // if (await connectivityService.checkConnectivity()) {
        final queryRes = await appointmentReference
            .doc(appointmentId)
            .update({'appointment_status': appointmentStatus});
        return QueryResult.success();
      // } else {
      //   return QueryResult.error('Check your network connection and try again');
      // }
    } catch (e) {
      return QueryResult.error('Something went wrong');
    }
  }

  @override
  Future<List<Payment>> getAllPayments() async {
    return await paymentReference.get().then(
        (value) => value.docs.map((e) => Payment.fromJson(e.data())).toList());
  }

  @override
  Stream listenToPaymentChanges() {
    return paymentReference.snapshots();
  }

  @override
  Stream listenToExpenseChanges() {
    return expenseReference.snapshots();
  }

  @override
  Future<QueryResult> addPrescription(
      {required Prescription prescription, required patientId}) async {
    // if (await connectivityService.checkConnectivity()) {
      final prescriptionDoc = await patientReference
          .doc(patientId)
          .collection('prescription')
          .doc();
      await prescriptionDoc.set(prescription.toJson(id: prescriptionDoc.id));
      return QueryResult.success();
    // } else {
    //   return QueryResult.error("Check your network connection and try again");
    // }
  }

  @override
  Stream listenToPrescription(dynamic patientId) {
    return patientReference
        .doc(patientId)
        .collection('prescription')
        .snapshots();
  }

  @override
  Future<List<Prescription>> getPatientPrescription({required patientId}) {
    return patientReference
        .doc(patientId)
        .collection('prescription')
        .orderBy('date', descending: true)
        .get()
        .then((value) =>
            value.docs.map((e) => Prescription.fromJson(e.data())).toList());
  }

  @override
  Future<QueryResult> addOpticalCertificate(
      {required OpticalCertificate opticalCertificate,
      required Patient patient}) async {
    // if (await connectivityService.checkConnectivity()) {
      final certDoc = await patientReference
          .doc(patient.id)
          .collection('optical_certificate')
          .doc();
      await certDoc.set(opticalCertificate.toJson(
          id: certDoc.id,
          dateCreated: FieldValue.serverTimestamp().toString()));
      return QueryResult.success();
    // } else {
    //   return QueryResult.error("Check your network connection and try again");
    // }
  }

  @override
  Stream listenToOpticalCertChanges({required Patient patient}) {
    return patientReference
        .doc(patient.id)
        .collection('optical_certificate')
        .snapshots();
  }

  @override
  Future<List<OpticalCertificate>> getOpticalCert({required Patient patient}) {
    return patientReference
        .doc(patient.id)
        .collection('optical_certificate')
        .orderBy('date', descending: true)
        .get()
        .then((value) => value.docs
            .map((e) => OpticalCertificate.fromJson(e.data()))
            .toList());
  }

  @override
  Future<QueryResult> updatePatientInfo({required Patient patient}) async {
    // if (await connectivityService.checkConnectivity()) {
      patientReference.doc(patient.id).set(patient.toJson(
          patientId: patient.id, dateCreated: FieldValue.serverTimestamp()));
      return QueryResult.success();
    // } else {
    //   return QueryResult.error('Check your network connection and try again');
    // }
  }

  @override
  Future<Patient> getPatientInfo({required String patientId}) async {
    return await patientReference
        .doc(patientId)
        .get()
        .then((value) => Patient.fromJson(value.data()!));
  }

  @override
  Stream listenToPatientChanges({required String patientId}) {
    return patientReference.doc(patientId).snapshots();
  }

  @override
  Future<int> getAllPatientCount() {
    // TODO: implement getAllPatientCount
    throw UnimplementedError();
  }

  @override
  Future<void> saveUserFcmToken(NotificationToken notificationToken) async {
    notificationTokensRef
        .doc(notificationToken.uid)
        .set(notificationToken.toJson());
    debugPrint('Notification Token added: ${notificationToken.tokenId}');
  }

  @override
  Future<QueryResult> updateUserStatus(
      {required String userId, required String status}) async {
    // if (await connectivityService.checkConnectivity()) {
      await userReference.doc(userId).update({'active_status': status});
      return QueryResult.success();
    // } else {
    //   return QueryResult.error(
    //       'Unable To Update Status. No Internet Connection.');
    // }
  }

  @override
  Future<QueryResult> updateUserInfo({required UserModel user}) async {
    // if (await connectivityService.checkConnectivity()) {
      await userReference.doc(user.userId).set(user.toJson());
      return QueryResult.success();
    // } else {
    //   return QueryResult.error(
    //       'Unable To Update Status. No Internet Connection.');
    // }
  }

  @override
  Future<QueryResult> updatePatientPhoto(
      {required String image, required String patientID}) async {
    // if (await connectivityService.checkConnectivity()) {
      await patientReference.doc(patientID).update({'image': image});
      return QueryResult.success();
    // } else {
    //   return QueryResult.error(
    //       'Unable To Update Image. No Internet Connection.');
    // }
  }

  @override
  Future<QueryResult> updateUserPhoto(
      {required String image, required String userId}) async {
    // if (await connectivityService.checkConnectivity()) {
      await userReference.doc(userId).update({'image': image});
      return QueryResult.success();
    // } else {
    //   return QueryResult.error(
    //       'Unable To Update Image. No Internet Connection.');
    // }
  }

  @override
  Future<void> saveNotification(
      {required NotificationModel notification, required String typeId}) async {
    final notDoc = await notificationReference.doc(typeId);

    await notDoc.set(
      notification.toJson(id: typeId, timestamp: DateTime.now()),
    );

    debugPrint('notification sent');
  }

  @override
  Future<void> deleteNotification({required String notificationId}) {
    return notificationReference.doc(notificationId).delete();
  }

  @override
  Future<void> markReadNotification({required String notificationId}) async {
    return await notificationReference
        .doc(notificationId)
        .update({'isRead': true});
  }

  @override
  Future<List<NotificationModel>> getNotification(
      {required String userId}) async {
    return notificationReference
        .where('user_id', isEqualTo: userId)
        .orderBy('date_created', descending: true)
        .get()
        .then((value) => value.docs
            .map((e) => NotificationModel.fromMap(e.data()))
            .toList());
  }

  @override
  Stream listenToNotificationChanges({required String userId}) {
    return notificationReference
        .where("user_id", isEqualTo: userId)
        .snapshots();
  }

  @override
  Future<int> getTotalMalePatient() async {
    final malePatients = await patientReference
        .where('gender', isEqualTo: 'Male')
        .get()
        .then((value) => value.docs.map((e) => e).toList());
    return malePatients.length;
  }

  @override
  Future<int> getTotalFeMalePatient() async {
    final femalePatients = await patientReference
        .where('gender', isEqualTo: 'Female')
        .get()
        .then((value) => value.docs.map((e) => e).toList());
    return femalePatients.length;
  }

  @override
  Future<AppointmentModel> getAppointmentById(String id) {
    return appointmentReference
        .doc(id)
        .get()
        .then((value) => AppointmentModel.fromJson(value.data()!));
  }

  @override
  Future<List<Service>> getService() {
    return procedureReference
        .orderBy('dateCreated', descending: true)
        .get()
        .then((value) =>
            value.docs.map((e) => Service.fromJson(e.data())).toList());
  }

  @override
  // Future<QueryResult> updateProcedure(Procedure service) async {
  //   if (await connectivityService.checkConnectivity()) {
  //     procedureReference.doc(service.id).set(service.toJson(
  //         dateCreated: FieldValue.serverTimestamp(), id: service.id));
  //     return QueryResult.success();
  //   } else {
  //     return QueryResult.error(
  //         'No Internet Connection. Check your connection and try again');
  //   }
  // }
  Future<QueryResult> updateService(Service procedure) async {
    // if (await connectivityService.checkConnectivity()) {
      try {
        await procedureReference.doc(procedure.id).set(procedure.toJson(
            dateCreated: FieldValue.serverTimestamp(), id: procedure.id));
        return QueryResult.success();
      } catch (e) {
        return QueryResult.error('Failed to update service');
      }
    // } else {
    //   return QueryResult.error(
    //       'No Internet Connection. Check your connection and try again');
    // }
  }

  @override
  Future<List<Product>> getProducts() {
    return medicineReference
        .orderBy('dateCreated', descending: true)
        .get()
        .then((value) =>
        value.docs.map((e) => Product.fromJson(e.data())).toList());
  }

  @override
  // Future<QueryResult> updateProduct(Medicine product) async {
  //   if (await connectivityService.checkConnectivity()) {
  //   medicineReference.doc(product.id).set(product.toJson(
  //   dateCreated: FieldValue.serverTimestamp(), id: product.id));
  //   return QueryResult.success();
  //   } else {
  //   return QueryResult.error(
  //   'No Internet Connection. Check your connection and try again');
  //   }
  // }
  Future<QueryResult> updateProduct(Product medicine) async {
    // if (await connectivityService.checkConnectivity()) {
      try {
        await medicineReference.doc(medicine.id).set(medicine.toJson(
            dateCreated: FieldValue.serverTimestamp(), id: medicine.id));
        return QueryResult.success();
      } catch (e) {
        return QueryResult.error('Failed to update product');
      }
    // } else {
    //   return QueryResult.error(
    //       'No Internet Connection. Check your connection and try again');
    // }
  }
}
