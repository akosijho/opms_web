import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/api/api_service_impl.dart';
import 'package:opmswebstaff/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:opmswebstaff/core/service/connectivity/connectivity_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service.dart';
import 'package:opmswebstaff/core/service/dialog/dialog_service_imp.dart';
import 'package:opmswebstaff/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:opmswebstaff/core/service/firebase_auth/firebase_auth_service_impl.dart';
import 'package:opmswebstaff/core/service/firebase_messaging/firebase_messaging_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service_impl.dart';
import 'package:opmswebstaff/core/service/pdf_service/pdf_service.dart';
import 'package:opmswebstaff/core/service/pdf_service/pdf_service_impl.dart';
import 'package:opmswebstaff/core/service/search_index/search_index.dart';
import 'package:opmswebstaff/core/service/session_service/session_service.dart';
import 'package:opmswebstaff/core/service/session_service/session_service_impl.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service.dart';
import 'package:opmswebstaff/core/service/snack_bar/snack_bar_service_impl.dart';
import 'package:opmswebstaff/core/service/toast/toast_service.dart';
import 'package:opmswebstaff/core/service/toast/toast_service_impl.dart';
import 'package:opmswebstaff/core/service/url_launcher/url_launcher_impl.dart';
import 'package:opmswebstaff/core/service/url_launcher/url_launcher_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service.dart';
import 'package:opmswebstaff/core/service/validator/validator_service_impl.dart';
import 'package:opmswebstaff/core/utility/connectivity_state.dart';
import 'package:opmswebstaff/core/utility/image_selector.dart';
import 'package:opmswebstaff/ui/views/add%20rx/rx_view.dart';
import 'package:opmswebstaff/ui/views/add_expense_item/add_expense_item_view.dart';
import 'package:opmswebstaff/ui/views/add_expenses/add_expenses_view.dart';
import 'package:opmswebstaff/ui/views/add_optical_certificate/add_certificate_view.dart';
import 'package:opmswebstaff/ui/views/add_patient/add_patient_view.dart';
import 'package:opmswebstaff/ui/views/add_payment/add_payment_view.dart';
import 'package:opmswebstaff/ui/views/add_prescription/add_prescription_view.dart';
import 'package:opmswebstaff/ui/views/add_prescription_item/add_prescription_item_view.dart';
import 'package:opmswebstaff/ui/views/add_product/add_lens/add_lens_view.dart';
import 'package:opmswebstaff/ui/views/add_product/add_product_view.dart';
import 'package:opmswebstaff/ui/views/add_service/add_service_view.dart';
import 'package:opmswebstaff/ui/views/appointment/appointment_view.dart';
import 'package:opmswebstaff/ui/views/appointment_select_patient/appointment_select_patient_view.dart';
import 'package:opmswebstaff/ui/views/appoitment_yearly_monthly/appointment_year_month_view.dart';
import 'package:opmswebstaff/ui/views/create_appointment/create_appointment_view.dart';
import 'package:opmswebstaff/ui/views/finance/reports_view.dart';
import 'package:opmswebstaff/ui/views/home/home_view.dart';
import 'package:opmswebstaff/ui/views/home/responsive/desktop_view/desktop_body.dart';
import 'package:opmswebstaff/ui/views/home/responsive/mobile_view/mobile_body.dart';
import 'package:opmswebstaff/ui/views/login/login_view.dart';
import 'package:opmswebstaff/ui/views/main_body/main_body_view.dart';
import 'package:opmswebstaff/ui/views/main_body/main_body_view_model.dart';
import 'package:opmswebstaff/ui/views/medical_history/medical_history_view.dart';
import 'package:opmswebstaff/ui/views/medical_history_photo_view/med_history_photo_view.dart';
import 'package:opmswebstaff/ui/views/notification/notification_view.dart';
import 'package:opmswebstaff/ui/views/optical_certification/optical_certification_view.dart';
import 'package:opmswebstaff/ui/views/patient_info/patient_info_view.dart';
import 'package:opmswebstaff/ui/views/patient_optical_chart/patient_optical_chart_view.dart';
import 'package:opmswebstaff/ui/views/patients/patients_view.dart';
import 'package:opmswebstaff/ui/views/payment_select_balance_note/payment_select_balance_note_view.dart';
import 'package:opmswebstaff/ui/views/payment_select_optical_note/payment_select_optical_note_view.dart';
import 'package:opmswebstaff/ui/views/payment_select_patient/payment_select_patient_view.dart';
import 'package:opmswebstaff/ui/views/prescription_view/prescription_view.dart';
import 'package:opmswebstaff/ui/views/product/frame_lens/frame_lens_view.dart';
import 'package:opmswebstaff/ui/views/product/product_view.dart';
import 'package:opmswebstaff/ui/views/receipt_view/receipt_view.dart';
import 'package:opmswebstaff/ui/views/register/register_view.dart';
import 'package:opmswebstaff/ui/views/select_product_view/select_lens_view/select_lens_view.dart';
import 'package:opmswebstaff/ui/views/select_product_view/select_product_view.dart';
import 'package:opmswebstaff/ui/views/service/service_view.dart';
import 'package:opmswebstaff/ui/views/set_optical_note/set_optical_note_view.dart';
import 'package:opmswebstaff/ui/views/update_product/update_lens/update_lens.dart';
import 'package:opmswebstaff/ui/views/update_product/update_product_view.dart';
import 'package:opmswebstaff/ui/views/update_service/update_service_view.dart';
import 'package:opmswebstaff/ui/views/update_user_info/setup_user_view.dart';
import 'package:opmswebstaff/ui/views/user_view/user_view.dart';
import 'package:opmswebstaff/ui/views/verify_email/verify_email_view.dart';
import 'package:opmswebstaff/ui/views/view_optical_note/view_optical_note.dart';
import 'package:opmswebstaff/ui/views/view_dental_notes_by_tooth/view_dental_note_by_tooth_view.dart';
import 'package:opmswebstaff/ui/views/view_patient_appointment/view_patient_appointment_view.dart';
import 'package:opmswebstaff/ui/views/view_patient_payments/view_patient_payment.dart';
import 'package:opmswebstaff/ui/widgets/selection_optometrist/selection_optometrist.dart';
import 'package:opmswebstaff/ui/widgets/selection_service/selection_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/views/edit_patient/edit_patient_view.dart';

@StackedApp(
  routes: [
    // MaterialRoute(page: PreLoaderView, name: 'PreLoader'),
    // MaterialRoute(page: GetStartedView, name: 'GetStarted'),
    MaterialRoute(page: LoginView, name: 'Login'),
    MaterialRoute(page: RegisterView, name: 'Register'),
    MaterialRoute(page: VerifyEmailView, name: 'VerifyEmail'),
    MaterialRoute(page: SetUpUserView, name: 'SetUpUserView'),
    // MaterialRoute(page: SuccessView, name: 'Success'),
    MaterialRoute(page: MainBodyView, name: 'MainBodyView'),
    MaterialRoute(page: HomePageView, name: 'HomePageView'),
    MaterialRoute(page: MyDesktopBody, name: 'DesktopView'),
    MaterialRoute(page: MyMobileBody, name: 'MobileView'),
    MaterialRoute(page: AppointmentView, name: 'AppointmentView'),
    MaterialRoute(page: ProductView, name: 'ProductView'),
    MaterialRoute(page: PatientsView, name: 'PatientsView'),
    MaterialRoute(page: ServicesView, name: 'ServicesView'),
    MaterialRoute(page: FrameLensView, name: 'FrameLensView'),
    MaterialRoute(page: AddPatientView, name: 'AddPatientView'),
    MaterialRoute(
        page: AppointmentSelectPatientView,
        name: 'AppointmentSelectPatientView'),
    MaterialRoute(page: CreateAppointmentView, name: 'CreateAppointmentView'),
    MaterialRoute(page: AddProductView, name: 'AddProductView'),
    MaterialRoute(page: AddServiceView, name: 'AddServiceView'),
    MaterialRoute(page: AddLensView, name: 'AddLensView'),
    MaterialRoute(page: PatientInfoView, name: 'PatientInfoView'),
    MaterialRoute(page: MedicalHistoryView, name: 'MedicalHistoryView'),
    MaterialRoute(page: MedHistoryPhotoView, name: 'MedHistoryPhotoView'),
    MaterialRoute(page: PatientOpticalChartView, name: 'PatientOpticalChartView'),
    MaterialRoute(page: SetOpticalNoteView, name: 'SetOpticalNoteView'),
    MaterialRoute(page: AddPaymentView, name: 'AddPaymentView'),
    MaterialRoute(page: NotificationView, name: 'NotificationView'),
    // MaterialRoute(page: ViewDentalNoteView, name: 'ViewDentalNoteView'),
    MaterialRoute(page: AddExpenseView, name: 'AddExpenseView'),
    MaterialRoute(page: ReportView, name: 'ReportView'),
    MaterialRoute(page: ViewPatientAppointment, name: 'ViewPatientAppointment'),
    MaterialRoute(page: ViewPatientPayment, name: 'ViewPatientPayment'),
    MaterialRoute(page: AddPrescriptionView, name: 'AddPrescriptionView'),
    MaterialRoute(page: PrescriptionView, name: 'PrescriptionView'),
    MaterialRoute(page: EditPatientView, name: 'EditPatientView'),
    MaterialRoute(
        page: ViewAppointmentByPeriod, name: 'ViewAppointmentByPeriod'),
    MaterialRoute(
        page: OpticalCertificationView, name: 'OpticalCertificationView'),
    MaterialRoute(
        page: PaymentSelectPatientView, name: 'PaymentSelectPatientView'),
    CustomRoute(
        page: SelectionOptometrist,
        name: 'SelectionOptometrist',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: SelectionService,
        name: 'SelectionService',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: UserView,
        name: 'UserView',
        transitionsBuilder: TransitionsBuilders.slideRight,
        durationInMilliseconds: 300),
    CustomRoute(
        page: PaymentSelectOpticalNoteView,
        name: 'PaymentSelectOpticalNoteView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: SelectProductView,
        name: 'SelectProductView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: ReceiptView,
        name: 'ReceiptView',
        transitionsBuilder: TransitionsBuilders.slideRight,
        durationInMilliseconds: 300),
    CustomRoute(
        page: RxView,
        name: 'RxView',
        transitionsBuilder: TransitionsBuilders.slideRight,
        durationInMilliseconds: 300),
    CustomRoute(
        page: AddExpenseItemView,
        name: 'AddExpenseItemView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: AddPrescriptionItemView,
        name: 'AddPrescriptionItemView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: AddCertificateView,
        name: 'AddCertificateView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: ViewOpticalNote,
        name: 'ViewOpticalNote',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: ViewDentalNoteByToothView,
        name: 'ViewDentalNoteByToothView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: UpdateServiceView,
        name: 'UpdateServiceViews',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: UpdateProductView,
        name: 'UpdateProductViews',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: UpdateLensView,
        name: 'UpdateLensViews',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: PaymentSelectBalanceNoteView,
        name: 'PaymentSelectBalanceNoteView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: SelectLensView,
        name: 'SelectLensView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
  ],
  dependencies: [
    Singleton(classType: NavigationServiceImpl, asType: NavigationService),
    LazySingleton(classType: SnackBarServiceImpl, asType: SnackBarService),
    LazySingleton(classType: DialogServiceImpl, asType: DialogService),
    LazySingleton(
        classType: FirebaseAuthServiceImpl, asType: FirebaseAuthService),
    LazySingleton(classType: ValidatorServiceImpl, asType: ValidatorService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: ConnectivityStateCheck),
    LazySingleton(classType: ImageSelector),
    LazySingleton(classType: ApiServiceImpl, asType: ApiService),
    LazySingleton(classType: SessionServiceImpl, asType: SessionService),
    LazySingleton(classType: ToastServiceImpl, asType: ToastService),
    LazySingleton(classType: SearchIndexService),
    LazySingleton(
        classType: URLLauncherServiceImpl, asType: URLLauncherService),
    LazySingleton(classType: ConnectivityService),
    LazySingleton(classType: FirebaseMessagingService),
    LazySingleton(classType: PdfServiceImp, asType: PdfService),
    LazySingleton(classType: MainBodyViewModel, asType: MainBodyViewModel),
  ],
  logger: StackedLogger(),
)
class App {}
