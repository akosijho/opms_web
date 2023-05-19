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
import '../models/patient_model/patient_model.dart';
import '../models/payment/payment.dart';
import '../models/product/lens.dart';
import '../models/product/product.dart';
import '../models/service/service.dart';
import '../models/user_model/user_model.dart';
import '../ui/views/add%20rx/rx_view.dart';
import '../ui/views/add_expense_item/add_expense_item_view.dart';
import '../ui/views/add_expenses/add_expenses_view.dart';
import '../ui/views/add_optical_certificate/add_certificate_view.dart';
import '../ui/views/add_patient/add_patient_view.dart';
import '../ui/views/add_payment/add_payment_view.dart';
import '../ui/views/add_prescription/add_prescription_view.dart';
import '../ui/views/add_prescription_item/add_prescription_item_view.dart';
import '../ui/views/add_product/add_lens/add_lens_view.dart';
import '../ui/views/add_product/add_product_view.dart';
import '../ui/views/add_service/add_service_view.dart';
import '../ui/views/appointment/appointment_view.dart';
import '../ui/views/appointment_select_patient/appointment_select_patient_view.dart';
import '../ui/views/appoitment_yearly_monthly/appointment_year_month_view.dart';
import '../ui/views/create_appointment/create_appointment_view.dart';
import '../ui/views/edit_patient/edit_patient_view.dart';
import '../ui/views/finance/reports_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/home/responsive/desktop_view/desktop_body.dart';
import '../ui/views/home/responsive/mobile_view/mobile_body.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/main_body/main_body_view.dart';
import '../ui/views/medical_history/medical_history_view.dart';
import '../ui/views/medical_history_photo_view/med_history_photo_view.dart';
import '../ui/views/notification/notification_view.dart';
import '../ui/views/optical_certification/optical_certification_view.dart';
import '../ui/views/patient_info/patient_info_view.dart';
import '../ui/views/patient_optical_chart/patient_optical_chart_view.dart';
import '../ui/views/patients/patients_view.dart';
import '../ui/views/payment_select_balance_note/payment_select_balance_note_view.dart';
import '../ui/views/payment_select_optical_note/payment_select_optical_note_view.dart';
import '../ui/views/payment_select_patient/payment_select_patient_view.dart';
import '../ui/views/prescription_view/prescription_view.dart';
import '../ui/views/product/frame_lens/frame_lens_view.dart';
import '../ui/views/product/product_view.dart';
import '../ui/views/receipt_view/receipt_view.dart';
import '../ui/views/register/register_view.dart';
import '../ui/views/select_product_view/select_lens_view/select_lens_view.dart';
import '../ui/views/select_product_view/select_product_view.dart';
import '../ui/views/service/service_view.dart';
import '../ui/views/set_optical_note/set_optical_note_view.dart';
import '../ui/views/update_product/update_lens/update_lens.dart';
import '../ui/views/update_product/update_product_view.dart';
import '../ui/views/update_service/update_service_view.dart';
import '../ui/views/update_user_info/setup_user_view.dart';
import '../ui/views/user_view/user_view.dart';
import '../ui/views/verify_email/verify_email_view.dart';
import '../ui/views/view_optical_note/view_optical_note.dart';
import '../ui/views/view_patient_appointment/view_patient_appointment_view.dart';
import '../ui/views/view_patient_payments/view_patient_payment.dart';
import '../ui/widgets/selection_optometrist/selection_optometrist.dart';
import '../ui/widgets/selection_service/selection_service.dart';

class Routes {
  static const String Login = '/login-view';
  static const String Register = '/register-view';
  static const String VerifyEmail = '/verify-email-view';
  static const String SetUpUserView = '/set-up-user-view';
  static const String MainBodyView = '/main-body-view';
  static const String HomePageView = '/home-page-view';
  static const String DesktopView = '/my-desktop-body';
  static const String MobileView = '/my-mobile-body';
  static const String AppointmentView = '/appointment-view';
  static const String ProductView = '/product-view';
  static const String PatientsView = '/patients-view';
  static const String ServicesView = '/services-view';
  static const String FrameLensView = '/frame-lens-view';
  static const String AddPatientView = '/add-patient-view';
  static const String AppointmentSelectPatientView =
      '/appointment-select-patient-view';
  static const String CreateAppointmentView = '/create-appointment-view';
  static const String AddProductView = '/add-product-view';
  static const String AddServiceView = '/add-service-view';
  static const String AddLensView = '/add-lens-view';
  static const String PatientInfoView = '/patient-info-view';
  static const String MedicalHistoryView = '/medical-history-view';
  static const String MedHistoryPhotoView = '/med-history-photo-view';
  static const String PatientOpticalChartView = '/patient-optical-chart-view';
  static const String SetOpticalNoteView = '/set-optical-note-view';
  static const String AddPaymentView = '/add-payment-view';
  static const String NotificationView = '/notification-view';
  static const String AddExpenseView = '/add-expense-view';
  static const String ReportView = '/report-view';
  static const String ViewPatientAppointment = '/view-patient-appointment';
  static const String ViewPatientPayment = '/view-patient-payment';
  static const String AddPrescriptionView = '/add-prescription-view';
  static const String PrescriptionView = '/prescription-view';
  static const String EditPatientView = '/edit-patient-view';
  static const String ViewAppointmentByPeriod = '/view-appointment-by-period';
  static const String OpticalCertificationView = '/optical-certification-view';
  static const String PaymentSelectPatientView = '/payment-select-patient-view';
  static const String SelectionOptometrist = '/selection-optometrist';
  static const String SelectionService = '/selection-service';
  static const String UserView = '/user-view';
  static const String PaymentSelectOpticalNoteView =
      '/payment-select-optical-note-view';
  static const String SelectProductView = '/select-product-view';
  static const String ReceiptView = '/receipt-view';
  static const String RxView = '/rx-view';
  static const String AddExpenseItemView = '/add-expense-item-view';
  static const String AddPrescriptionItemView = '/add-prescription-item-view';
  static const String AddCertificateView = '/add-certificate-view';
  static const String ViewOpticalNote = '/view-optical-note';
  static const String UpdateServiceViews = '/update-service-view';
  static const String UpdateProductViews = '/update-product-view';
  static const String UpdateLensViews = '/update-lens-view';
  static const String PaymentSelectBalanceNoteView =
      '/payment-select-balance-note-view';
  static const String SelectLensView = '/select-lens-view';
  static const all = <String>{
    Login,
    Register,
    VerifyEmail,
    SetUpUserView,
    MainBodyView,
    HomePageView,
    DesktopView,
    MobileView,
    AppointmentView,
    ProductView,
    PatientsView,
    ServicesView,
    FrameLensView,
    AddPatientView,
    AppointmentSelectPatientView,
    CreateAppointmentView,
    AddProductView,
    AddServiceView,
    AddLensView,
    PatientInfoView,
    MedicalHistoryView,
    MedHistoryPhotoView,
    PatientOpticalChartView,
    SetOpticalNoteView,
    AddPaymentView,
    NotificationView,
    AddExpenseView,
    ReportView,
    ViewPatientAppointment,
    ViewPatientPayment,
    AddPrescriptionView,
    PrescriptionView,
    EditPatientView,
    ViewAppointmentByPeriod,
    OpticalCertificationView,
    PaymentSelectPatientView,
    SelectionOptometrist,
    SelectionService,
    UserView,
    PaymentSelectOpticalNoteView,
    SelectProductView,
    ReceiptView,
    RxView,
    AddExpenseItemView,
    AddPrescriptionItemView,
    AddCertificateView,
    ViewOpticalNote,
    UpdateServiceViews,
    UpdateProductViews,
    UpdateLensViews,
    PaymentSelectBalanceNoteView,
    SelectLensView,
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
    RouteDef(Routes.DesktopView, page: MyDesktopBody),
    RouteDef(Routes.MobileView, page: MyMobileBody),
    RouteDef(Routes.AppointmentView, page: AppointmentView),
    RouteDef(Routes.ProductView, page: ProductView),
    RouteDef(Routes.PatientsView, page: PatientsView),
    RouteDef(Routes.ServicesView, page: ServicesView),
    RouteDef(Routes.FrameLensView, page: FrameLensView),
    RouteDef(Routes.AddPatientView, page: AddPatientView),
    RouteDef(Routes.AppointmentSelectPatientView,
        page: AppointmentSelectPatientView),
    RouteDef(Routes.CreateAppointmentView, page: CreateAppointmentView),
    RouteDef(Routes.AddProductView, page: AddProductView),
    RouteDef(Routes.AddServiceView, page: AddServiceView),
    RouteDef(Routes.AddLensView, page: AddLensView),
    RouteDef(Routes.PatientInfoView, page: PatientInfoView),
    RouteDef(Routes.MedicalHistoryView, page: MedicalHistoryView),
    RouteDef(Routes.MedHistoryPhotoView, page: MedHistoryPhotoView),
    RouteDef(Routes.PatientOpticalChartView, page: PatientOpticalChartView),
    RouteDef(Routes.SetOpticalNoteView, page: SetOpticalNoteView),
    RouteDef(Routes.AddPaymentView, page: AddPaymentView),
    RouteDef(Routes.NotificationView, page: NotificationView),
    RouteDef(Routes.AddExpenseView, page: AddExpenseView),
    RouteDef(Routes.ReportView, page: ReportView),
    RouteDef(Routes.ViewPatientAppointment, page: ViewPatientAppointment),
    RouteDef(Routes.ViewPatientPayment, page: ViewPatientPayment),
    RouteDef(Routes.AddPrescriptionView, page: AddPrescriptionView),
    RouteDef(Routes.PrescriptionView, page: PrescriptionView),
    RouteDef(Routes.EditPatientView, page: EditPatientView),
    RouteDef(Routes.ViewAppointmentByPeriod, page: ViewAppointmentByPeriod),
    RouteDef(Routes.OpticalCertificationView, page: OpticalCertificationView),
    RouteDef(Routes.PaymentSelectPatientView, page: PaymentSelectPatientView),
    RouteDef(Routes.SelectionOptometrist, page: SelectionOptometrist),
    RouteDef(Routes.SelectionService, page: SelectionService),
    RouteDef(Routes.UserView, page: UserView),
    RouteDef(Routes.PaymentSelectOpticalNoteView,
        page: PaymentSelectOpticalNoteView),
    RouteDef(Routes.SelectProductView, page: SelectProductView),
    RouteDef(Routes.ReceiptView, page: ReceiptView),
    RouteDef(Routes.RxView, page: RxView),
    RouteDef(Routes.AddExpenseItemView, page: AddExpenseItemView),
    RouteDef(Routes.AddPrescriptionItemView, page: AddPrescriptionItemView),
    RouteDef(Routes.AddCertificateView, page: AddCertificateView),
    RouteDef(Routes.ViewOpticalNote, page: ViewOpticalNote),
    RouteDef(Routes.UpdateServiceViews, page: UpdateServiceView),
    RouteDef(Routes.UpdateProductViews, page: UpdateProductView),
    RouteDef(Routes.UpdateLensViews, page: UpdateLensView),
    RouteDef(Routes.PaymentSelectBalanceNoteView,
        page: PaymentSelectBalanceNoteView),
    RouteDef(Routes.SelectLensView, page: SelectLensView),
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
    MyDesktopBody: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const MyDesktopBody(),
        settings: data,
      );
    },
    MyMobileBody: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const MyMobileBody(),
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
    ProductView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProductView(),
        settings: data,
      );
    },
    PatientsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PatientsView(),
        settings: data,
      );
    },
    ServicesView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ServicesView(),
        settings: data,
      );
    },
    FrameLensView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const FrameLensView(),
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
    AddProductView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddProductView(),
        settings: data,
      );
    },
    AddServiceView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddServiceView(),
        settings: data,
      );
    },
    AddLensView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddLensView(),
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
    PatientOpticalChartView: (data) {
      var args = data.getArgs<PatientOpticalChartViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PatientOpticalChartView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    SetOpticalNoteView: (data) {
      var args = data.getArgs<SetOpticalNoteViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SetOpticalNoteView(
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
    ViewAppointmentByPeriod: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ViewAppointmentByPeriod(),
        settings: data,
      );
    },
    OpticalCertificationView: (data) {
      var args = data.getArgs<OpticalCertificationViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => OpticalCertificationView(
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
    SelectionOptometrist: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SelectionOptometrist(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    SelectionService: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SelectionService(),
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
    PaymentSelectOpticalNoteView: (data) {
      var args =
          data.getArgs<PaymentSelectOpticalNoteViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PaymentSelectOpticalNoteView(
          key: args.key,
          patientId: args.patientId,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    SelectProductView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SelectProductView(),
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
          showAppBar: args.showAppBar,
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
    ViewOpticalNote: (data) {
      var args = data.getArgs<ViewOpticalNoteArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ViewOpticalNote(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    UpdateServiceView: (data) {
      var args = data.getArgs<UpdateServiceViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            UpdateServiceView(
          key: args.key,
          service: args.service,
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
    UpdateLensView: (data) {
      var args = data.getArgs<UpdateLensViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => UpdateLensView(
          key: args.key,
          lens: args.lens,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    PaymentSelectBalanceNoteView: (data) {
      var args =
          data.getArgs<PaymentSelectBalanceNoteViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PaymentSelectBalanceNoteView(
          key: args.key,
          patientId: args.patientId,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    SelectLensView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SelectLensView(),
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

/// PatientOpticalChartView arguments holder class
class PatientOpticalChartViewArguments {
  final Key? key;
  final Patient patient;
  PatientOpticalChartViewArguments({this.key, required this.patient});
}

/// SetOpticalNoteView arguments holder class
class SetOpticalNoteViewArguments {
  final Key? key;
  final List<String> selectedTeeth;
  final dynamic patientId;
  SetOpticalNoteViewArguments(
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

/// OpticalCertificationView arguments holder class
class OpticalCertificationViewArguments {
  final Key? key;
  final Patient patient;
  OpticalCertificationViewArguments({this.key, required this.patient});
}

/// UserView arguments holder class
class UserViewArguments {
  final Key? key;
  final UserModel user;
  UserViewArguments({this.key, required this.user});
}

/// PaymentSelectOpticalNoteView arguments holder class
class PaymentSelectOpticalNoteViewArguments {
  final Key? key;
  final String patientId;
  PaymentSelectOpticalNoteViewArguments({this.key, required this.patientId});
}

/// ReceiptView arguments holder class
class ReceiptViewArguments {
  final Key? key;
  final Payment payment;
  final bool showAppBar;
  ReceiptViewArguments(
      {this.key, required this.payment, required this.showAppBar});
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

/// ViewOpticalNote arguments holder class
class ViewOpticalNoteArguments {
  final Key? key;
  final Patient patient;
  ViewOpticalNoteArguments({this.key, required this.patient});
}

/// UpdateServiceView arguments holder class
class UpdateServiceViewArguments {
  final Key? key;
  final Service service;
  UpdateServiceViewArguments({this.key, required this.service});
}

/// UpdateProductView arguments holder class
class UpdateProductViewArguments {
  final Key? key;
  final Product medicine;
  UpdateProductViewArguments({this.key, required this.medicine});
}

/// UpdateLensView arguments holder class
class UpdateLensViewArguments {
  final Key? key;
  final Lens lens;
  UpdateLensViewArguments({this.key, required this.lens});
}

/// PaymentSelectBalanceNoteView arguments holder class
class PaymentSelectBalanceNoteViewArguments {
  final Key? key;
  final String patientId;
  PaymentSelectBalanceNoteViewArguments({this.key, required this.patientId});
}
