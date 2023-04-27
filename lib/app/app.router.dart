// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../models/appointment_model/appointment_model.dart';
import '../models/medical_history/medical_history.dart';
import '../models/medicine/medicine.dart';
import '../models/patient_model/patient_model.dart';
import '../models/payment/payment.dart';
import '../models/procedure/procedure.dart';
import '../models/user_model/user_model.dart';
import '../ui/views/add%20rx/rx_view.dart';
import '../ui/views/add_dental_certificate/add_certificate_view.dart';
import '../ui/views/add_expense_item/add_expense_item_view.dart';
import '../ui/views/add_expenses/add_expenses_view.dart';
import '../ui/views/add_medicine/add_medicine_view.dart';
import '../ui/views/add_patient/add_patient_view.dart';
import '../ui/views/add_payment/add_payment_view.dart';
import '../ui/views/add_prescription/add_prescription_view.dart';
import '../ui/views/add_prescription_item/add_prescription_item_view.dart';
import '../ui/views/add_procedure/add_procedure_view.dart';
import '../ui/views/appointment/appointment_view.dart';
import '../ui/views/appointment_select_patient/appointment_select_patient_view.dart';
import '../ui/views/appoitment_yearly_monthly/appointment_year_month_view.dart';
import '../ui/views/create_appointment/create_appointment_view.dart';
import '../ui/views/dental_certification/dental_certification_view.dart';
import '../ui/views/dental_chart_legend/dental_chart_legend.dart';
import '../ui/views/edit_patient/edit_patient_view.dart';
import '../ui/views/finance/reports_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/main_body/main_body_view.dart';
import '../ui/views/medical_history/medical_history_view.dart';
import '../ui/views/medical_history_photo_view/med_history_photo_view.dart';
import '../ui/views/medicine/medicine_view.dart';
import '../ui/views/notification/notification_view.dart';
import '../ui/views/patient_dental_chart/patient_dental_chart_view.dart';
import '../ui/views/patient_info/patient_info_view.dart';
import '../ui/views/patients/patients_view.dart';
import '../ui/views/payment_select_dental_note/payment_select_dental_note_view.dart';
import '../ui/views/payment_select_patient/payment_select_patient_view.dart';
import '../ui/views/prescription_view/prescription_view.dart';
import '../ui/views/procedures/procedure_view.dart';
import '../ui/views/receipt_view/receipt_view.dart';
import '../ui/views/register/register_view.dart';
import '../ui/views/select_medicine_view/select_medicine_view.dart';
import '../ui/views/selection_tooth_condition/selection_tooth_condition_view.dart';
import '../ui/views/set_dental_note/set_dental_note_view.dart';
import '../ui/views/set_tooth_condition/set_tooth_condition_view.dart';
import '../ui/views/update_procedure/update_procedure_view.dart';
import '../ui/views/update_product/update_product_view.dart';
import '../ui/views/update_user_info/setup_user_view.dart';
import '../ui/views/user_view/user_view.dart';
import '../ui/views/verify_email/verify_email_view.dart';
import '../ui/views/view_dental_note/view_dental_note.dart';
import '../ui/views/view_dental_notes_by_tooth/view_dental_note_by_tooth_view.dart';
import '../ui/views/view_patient_appointment/view_patient_appointment_view.dart';
import '../ui/views/view_patient_payments/view_patient_payment.dart';
import '../ui/widgets/selection_dentist/selection_dentist.dart';
import '../ui/widgets/selection_procedure/selection_procedure.dart';

class Routes {
  static const String Login = '/login-view';
  static const String Register = '/register-view';
  static const String VerifyEmail = '/verify-email-view';
  static const String SetUpUserView = '/set-up-user-view';
  static const String MainBodyView = '/main-body-view';
  static const String HomePageView = '/home-page-view';
  static const String AppointmentView = '/appointment-view';
  static const String MedicineView = '/medicine-view';
  static const String PatientsView = '/patients-view';
  static const String ProceduresView = '/procedures-view';
  static const String AddPatientView = '/add-patient-view';
  static const String AppointmentSelectPatientView =
      '/appointment-select-patient-view';
  static const String CreateAppointmentView = '/create-appointment-view';
  static const String AddMedicineView = '/add-medicine-view';
  static const String AddProcedureView = '/add-procedure-view';
  static const String PatientInfoView = '/patient-info-view';
  static const String MedicalHistoryView = '/medical-history-view';
  static const String MedHistoryPhotoView = '/med-history-photo-view';
  static const String PatientDentalChartView = '/patient-dental-chart-view';
  static const String SetToothConditionView = '/set-tooth-condition-view';
  static const String SetDentalNoteView = '/set-dental-note-view';
  static const String AddPaymentView = '/add-payment-view';
  static const String NotificationView = '/notification-view';
  static const String AddExpenseView = '/add-expense-view';
  static const String ReportView = '/report-view';
  static const String ViewPatientAppointment = '/view-patient-appointment';
  static const String ViewPatientPayment = '/view-patient-payment';
  static const String AddPrescriptionView = '/add-prescription-view';
  static const String PrescriptionView = '/prescription-view';
  static const String EditPatientView = '/edit-patient-view';
  static const String DentalChartLegend = '/dental-chart-legend';
  static const String ViewAppointmentByPeriod = '/view-appointment-by-period';
  static const String DentalCertificationView = '/dental-certification-view';
  static const String PaymentSelectPatientView = '/payment-select-patient-view';
  static const String SelectionDentist = '/selection-dentist';
  static const String SelectionProcedure = '/selection-procedure';
  static const String SelectionToothCondition = '/selection-tooth-condition';
  static const String UserView = '/user-view';
  static const String PaymentSelectDentalNoteView =
      '/payment-select-dental-note-view';
  static const String SelectMedicineView = '/select-medicine-view';
  static const String ReceiptView = '/receipt-view';
  static const String RxView = '/rx-view';
  static const String AddExpenseItemView = '/add-expense-item-view';
  static const String AddPrescriptionItemView = '/add-prescription-item-view';
  static const String AddCertificateView = '/add-certificate-view';
  static const String ViewDentalNote = '/view-dental-note';
  static const String ViewDentalNoteByToothView =
      '/view-dental-note-by-tooth-view';
  static const String UpdateProcedureViews = '/update-procedure-view';
  static const String UpdateProductViews = '/update-product-view';
  static const all = <String>{
    Login,
    Register,
    VerifyEmail,
    SetUpUserView,
    MainBodyView,
    HomePageView,
    AppointmentView,
    MedicineView,
    PatientsView,
    ProceduresView,
    AddPatientView,
    AppointmentSelectPatientView,
    CreateAppointmentView,
    AddMedicineView,
    AddProcedureView,
    PatientInfoView,
    MedicalHistoryView,
    MedHistoryPhotoView,
    PatientDentalChartView,
    SetToothConditionView,
    SetDentalNoteView,
    AddPaymentView,
    NotificationView,
    AddExpenseView,
    ReportView,
    ViewPatientAppointment,
    ViewPatientPayment,
    AddPrescriptionView,
    PrescriptionView,
    EditPatientView,
    DentalChartLegend,
    ViewAppointmentByPeriod,
    DentalCertificationView,
    PaymentSelectPatientView,
    SelectionDentist,
    SelectionProcedure,
    SelectionToothCondition,
    UserView,
    PaymentSelectDentalNoteView,
    SelectMedicineView,
    ReceiptView,
    RxView,
    AddExpenseItemView,
    AddPrescriptionItemView,
    AddCertificateView,
    ViewDentalNote,
    ViewDentalNoteByToothView,
    UpdateProcedureViews,
    UpdateProductViews,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.Login, page: LoginView),
    RouteDef(Routes.Register, page: RegisterView),
    RouteDef(Routes.VerifyEmail, page: VerifyEmailView),
    RouteDef(Routes.SetUpUserView, page: SetUpUserView),
    RouteDef(Routes.MainBodyView, page: MainBodyView),
    RouteDef(Routes.HomePageView, page: HomePageView),
    RouteDef(Routes.AppointmentView, page: AppointmentView),
    RouteDef(Routes.MedicineView, page: MedicineView),
    RouteDef(Routes.PatientsView, page: PatientsView),
    RouteDef(Routes.ProceduresView, page: ProceduresView),
    RouteDef(Routes.AddPatientView, page: AddPatientView),
    RouteDef(Routes.AppointmentSelectPatientView,
        page: AppointmentSelectPatientView),
    RouteDef(Routes.CreateAppointmentView, page: CreateAppointmentView),
    RouteDef(Routes.AddMedicineView, page: AddMedicineView),
    RouteDef(Routes.AddProcedureView, page: AddProcedureView),
    RouteDef(Routes.PatientInfoView, page: PatientInfoView),
    RouteDef(Routes.MedicalHistoryView, page: MedicalHistoryView),
    RouteDef(Routes.MedHistoryPhotoView, page: MedHistoryPhotoView),
    RouteDef(Routes.PatientDentalChartView, page: PatientDentalChartView),
    RouteDef(Routes.SetToothConditionView, page: SetToothConditionView),
    RouteDef(Routes.SetDentalNoteView, page: SetDentalNoteView),
    RouteDef(Routes.AddPaymentView, page: AddPaymentView),
    RouteDef(Routes.NotificationView, page: NotificationView),
    RouteDef(Routes.AddExpenseView, page: AddExpenseView),
    RouteDef(Routes.ReportView, page: ReportView),
    RouteDef(Routes.ViewPatientAppointment, page: ViewPatientAppointment),
    RouteDef(Routes.ViewPatientPayment, page: ViewPatientPayment),
    RouteDef(Routes.AddPrescriptionView, page: AddPrescriptionView),
    RouteDef(Routes.PrescriptionView, page: PrescriptionView),
    RouteDef(Routes.EditPatientView, page: EditPatientView),
    RouteDef(Routes.DentalChartLegend, page: DentalChartLegend),
    RouteDef(Routes.ViewAppointmentByPeriod, page: ViewAppointmentByPeriod),
    RouteDef(Routes.DentalCertificationView, page: DentalCertificationView),
    RouteDef(Routes.PaymentSelectPatientView, page: PaymentSelectPatientView),
    RouteDef(Routes.SelectionDentist, page: SelectionDentist),
    RouteDef(Routes.SelectionProcedure, page: SelectionProcedure),
    RouteDef(Routes.SelectionToothCondition, page: SelectionToothCondition),
    RouteDef(Routes.UserView, page: UserView),
    RouteDef(Routes.PaymentSelectDentalNoteView,
        page: PaymentSelectDentalNoteView),
    RouteDef(Routes.SelectMedicineView, page: SelectMedicineView),
    RouteDef(Routes.ReceiptView, page: ReceiptView),
    RouteDef(Routes.RxView, page: RxView),
    RouteDef(Routes.AddExpenseItemView, page: AddExpenseItemView),
    RouteDef(Routes.AddPrescriptionItemView, page: AddPrescriptionItemView),
    RouteDef(Routes.AddCertificateView, page: AddCertificateView),
    RouteDef(Routes.ViewDentalNote, page: ViewDentalNote),
    RouteDef(Routes.ViewDentalNoteByToothView, page: ViewDentalNoteByToothView),
    RouteDef(Routes.UpdateProcedureViews, page: UpdateProcedureView),
    RouteDef(Routes.UpdateProductViews, page: UpdateProductView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(key: args.key),
        settings: data,
      );
    },
    RegisterView: (data) {
      var args = data.getArgs<RegisterViewArguments>(
        orElse: () => RegisterViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterView(key: args.key),
        settings: data,
      );
    },
    VerifyEmailView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const VerifyEmailView(),
        settings: data,
      );
    },
    SetUpUserView: (data) {
      var args = data.getArgs<SetUpUserViewArguments>(
        orElse: () => SetUpUserViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SetUpUserView(
          key: args.key,
          firstName: args.firstName,
          lastName: args.lastName,
          userPhoto: args.userPhoto,
        ),
        settings: data,
      );
    },
    MainBodyView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const MainBodyView(),
        settings: data,
      );
    },
    HomePageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomePageView(),
        settings: data,
      );
    },
    AppointmentView: (data) {
      var args = data.getArgs<AppointmentViewArguments>(
        orElse: () => AppointmentViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AppointmentView(
          key: args.key,
          appointment: args.appointment,
        ),
        settings: data,
      );
    },
    MedicineView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const MedicineView(),
        settings: data,
      );
    },
    PatientsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PatientsView(),
        settings: data,
      );
    },
    ProceduresView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProceduresView(),
        settings: data,
      );
    },
    AddPatientView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddPatientView(),
        settings: data,
      );
    },
    AppointmentSelectPatientView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AppointmentSelectPatientView(),
        settings: data,
      );
    },
    CreateAppointmentView: (data) {
      var args = data.getArgs<CreateAppointmentViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateAppointmentView(
          patient: args.patient,
          popTimes: args.popTimes,
          key: args.key,
        ),
        settings: data,
      );
    },
    AddMedicineView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddMedicineView(),
        settings: data,
      );
    },
    AddProcedureView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddProcedureView(),
        settings: data,
      );
    },
    PatientInfoView: (data) {
      var args = data.getArgs<PatientInfoViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PatientInfoView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    MedicalHistoryView: (data) {
      var args = data.getArgs<MedicalHistoryViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => MedicalHistoryView(
          key: args.key,
          patientId: args.patientId,
        ),
        settings: data,
      );
    },
    MedHistoryPhotoView: (data) {
      var args = data.getArgs<MedHistoryPhotoViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => MedHistoryPhotoView(
          key: args.key,
          medHistory: args.medHistory,
          initialIndex: args.initialIndex,
        ),
        settings: data,
      );
    },
    PatientDentalChartView: (data) {
      var args = data.getArgs<PatientDentalChartViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PatientDentalChartView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    SetToothConditionView: (data) {
      var args = data.getArgs<SetToothConditionViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SetToothConditionView(
          key: args.key,
          selectedTeeth: args.selectedTeeth,
          patientId: args.patientId,
        ),
        settings: data,
      );
    },
    SetDentalNoteView: (data) {
      var args = data.getArgs<SetDentalNoteViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SetDentalNoteView(
          key: args.key,
          selectedTeeth: args.selectedTeeth,
          patientId: args.patientId,
        ),
        settings: data,
      );
    },
    AddPaymentView: (data) {
      var args = data.getArgs<AddPaymentViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddPaymentView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    NotificationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const NotificationView(),
        settings: data,
      );
    },
    AddExpenseView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddExpenseView(),
        settings: data,
      );
    },
    ReportView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ReportView(),
        settings: data,
      );
    },
    ViewPatientAppointment: (data) {
      var args = data.getArgs<ViewPatientAppointmentArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ViewPatientAppointment(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    ViewPatientPayment: (data) {
      var args = data.getArgs<ViewPatientPaymentArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ViewPatientPayment(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    AddPrescriptionView: (data) {
      var args = data.getArgs<AddPrescriptionViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddPrescriptionView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    PrescriptionView: (data) {
      var args = data.getArgs<PrescriptionViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PrescriptionView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    EditPatientView: (data) {
      var args = data.getArgs<EditPatientViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditPatientView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    DentalChartLegend: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DentalChartLegend(),
        settings: data,
      );
    },
    ViewAppointmentByPeriod: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ViewAppointmentByPeriod(),
        settings: data,
      );
    },
    DentalCertificationView: (data) {
      var args = data.getArgs<DentalCertificationViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DentalCertificationView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    PaymentSelectPatientView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PaymentSelectPatientView(),
        settings: data,
      );
    },
    SelectionDentist: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SelectionDentist(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    SelectionProcedure: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SelectionProcedure(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    SelectionToothCondition: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SelectionToothCondition(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    UserView: (data) {
      var args = data.getArgs<UserViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => UserView(
          key: args.key,
          user: args.user,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    PaymentSelectDentalNoteView: (data) {
      var args =
          data.getArgs<PaymentSelectDentalNoteViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PaymentSelectDentalNoteView(
          key: args.key,
          patientId: args.patientId,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    SelectMedicineView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SelectMedicineView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    ReceiptView: (data) {
      var args = data.getArgs<ReceiptViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => ReceiptView(
          key: args.key,
          payment: args.payment,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    RxView: (data) {
      var args = data.getArgs<RxViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => RxView(
          key: args.key,
          payment: args.payment,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    AddExpenseItemView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddExpenseItemView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    AddPrescriptionItemView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddPrescriptionItemView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    AddCertificateView: (data) {
      var args = data.getArgs<AddCertificateViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AddCertificateView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    ViewDentalNote: (data) {
      var args = data.getArgs<ViewDentalNoteArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => ViewDentalNote(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    ViewDentalNoteByToothView: (data) {
      var args =
          data.getArgs<ViewDentalNoteByToothViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ViewDentalNoteByToothView(
          key: args.key,
          patient: args.patient,
          selectedTooth: args.selectedTooth,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    UpdateProcedureView: (data) {
      var args = data.getArgs<UpdateProcedureViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            UpdateProcedureView(
          key: args.key,
          procedure: args.procedure,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    UpdateProductView: (data) {
      var args = data.getArgs<UpdateProductViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            UpdateProductView(
          key: args.key,
          medicine: args.medicine,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LoginView arguments holder class
class LoginViewArguments {
  final Key? key;
  LoginViewArguments({this.key});
}

/// RegisterView arguments holder class
class RegisterViewArguments {
  final Key? key;
  RegisterViewArguments({this.key});
}

/// SetUpUserView arguments holder class
class SetUpUserViewArguments {
  final Key? key;
  final String? firstName;
  final String? lastName;
  final String? userPhoto;
  SetUpUserViewArguments(
      {this.key, this.firstName, this.lastName, this.userPhoto});
}

/// AppointmentView arguments holder class
class AppointmentViewArguments {
  final Key? key;
  final AppointmentModel? appointment;
  AppointmentViewArguments({this.key, this.appointment});
}

/// CreateAppointmentView arguments holder class
class CreateAppointmentViewArguments {
  final Patient patient;
  final int popTimes;
  final Key? key;
  CreateAppointmentViewArguments(
      {required this.patient, required this.popTimes, this.key});
}

/// PatientInfoView arguments holder class
class PatientInfoViewArguments {
  final Key? key;
  final Patient patient;
  PatientInfoViewArguments({this.key, required this.patient});
}

/// MedicalHistoryView arguments holder class
class MedicalHistoryViewArguments {
  final Key? key;
  final dynamic patientId;
  MedicalHistoryViewArguments({this.key, required this.patientId});
}

/// MedHistoryPhotoView arguments holder class
class MedHistoryPhotoViewArguments {
  final Key? key;
  final List<MedicalHistory> medHistory;
  final int initialIndex;
  MedHistoryPhotoViewArguments(
      {this.key, required this.medHistory, required this.initialIndex});
}

/// PatientDentalChartView arguments holder class
class PatientDentalChartViewArguments {
  final Key? key;
  final Patient patient;
  PatientDentalChartViewArguments({this.key, required this.patient});
}

/// SetToothConditionView arguments holder class
class SetToothConditionViewArguments {
  final Key? key;
  final List<String> selectedTeeth;
  final dynamic patientId;
  SetToothConditionViewArguments(
      {this.key, required this.selectedTeeth, required this.patientId});
}

/// SetDentalNoteView arguments holder class
class SetDentalNoteViewArguments {
  final Key? key;
  final List<String> selectedTeeth;
  final dynamic patientId;
  SetDentalNoteViewArguments(
      {this.key, required this.selectedTeeth, required this.patientId});
}

/// AddPaymentView arguments holder class
class AddPaymentViewArguments {
  final Key? key;
  final Patient patient;
  AddPaymentViewArguments({this.key, required this.patient});
}

/// ViewPatientAppointment arguments holder class
class ViewPatientAppointmentArguments {
  final Key? key;
  final Patient patient;
  ViewPatientAppointmentArguments({this.key, required this.patient});
}

/// ViewPatientPayment arguments holder class
class ViewPatientPaymentArguments {
  final Key? key;
  final Patient patient;
  ViewPatientPaymentArguments({this.key, required this.patient});
}

/// AddPrescriptionView arguments holder class
class AddPrescriptionViewArguments {
  final Key? key;
  final Patient patient;
  AddPrescriptionViewArguments({this.key, required this.patient});
}

/// PrescriptionView arguments holder class
class PrescriptionViewArguments {
  final Key? key;
  final Patient patient;
  PrescriptionViewArguments({this.key, required this.patient});
}

/// EditPatientView arguments holder class
class EditPatientViewArguments {
  final Key? key;
  final Patient patient;
  EditPatientViewArguments({this.key, required this.patient});
}

/// DentalCertificationView arguments holder class
class DentalCertificationViewArguments {
  final Key? key;
  final Patient patient;
  DentalCertificationViewArguments({this.key, required this.patient});
}

/// UserView arguments holder class
class UserViewArguments {
  final Key? key;
  final UserModel user;
  UserViewArguments({this.key, required this.user});
}

/// PaymentSelectDentalNoteView arguments holder class
class PaymentSelectDentalNoteViewArguments {
  final Key? key;
  final String patientId;
  PaymentSelectDentalNoteViewArguments({this.key, required this.patientId});
}

/// ReceiptView arguments holder class
class ReceiptViewArguments {
  final Key? key;
  final Payment payment;
  ReceiptViewArguments({this.key, required this.payment});
}

/// RxView arguments holder class
class RxViewArguments {
  final Key? key;
  final Payment payment;
  RxViewArguments({this.key, required this.payment});
}

/// AddCertificateView arguments holder class
class AddCertificateViewArguments {
  final Key? key;
  final Patient patient;
  AddCertificateViewArguments({this.key, required this.patient});
}

/// ViewDentalNote arguments holder class
class ViewDentalNoteArguments {
  final Key? key;
  final Patient patient;
  ViewDentalNoteArguments({this.key, required this.patient});
}

/// ViewDentalNoteByToothView arguments holder class
class ViewDentalNoteByToothViewArguments {
  final Key? key;
  final Patient patient;
  final String selectedTooth;
  ViewDentalNoteByToothViewArguments(
      {this.key, required this.patient, required this.selectedTooth});
}

/// UpdateProcedureView arguments holder class
class UpdateProcedureViewArguments {
  final Key? key;
  final Procedure procedure;
  UpdateProcedureViewArguments({this.key, required this.procedure});
}

/// UpdateProductView arguments holder class
class UpdateProductViewArguments {
  final Key? key;
  final Medicine medicine;
  UpdateProductViewArguments({this.key, required this.medicine});
}
