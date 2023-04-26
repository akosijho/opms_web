// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../core/service/api/api_service.dart';
import '../core/service/api/api_service_impl.dart';
import '../core/service/bottom_sheet/bottom_sheet_service.dart';
import '../core/service/connectivity/connectivity_service.dart';
import '../core/service/dialog/dialog_service.dart';
import '../core/service/dialog/dialog_service_imp.dart';
import '../core/service/firebase_auth/firebase_auth_service.dart';
import '../core/service/firebase_auth/firebase_auth_service_impl.dart';
import '../core/service/firebase_messaging/firebase_messaging_service.dart';
import '../core/service/navigation/navigation_service.dart';
import '../core/service/navigation/navigation_service_impl.dart';
import '../core/service/pdf_service/pdf_service.dart';
import '../core/service/pdf_service/pdf_service_impl.dart';
import '../core/service/search_index/search_index.dart';
import '../core/service/session_service/session_service.dart';
import '../core/service/session_service/session_service_impl.dart';
import '../core/service/snack_bar/snack_bar_service.dart';
import '../core/service/snack_bar/snack_bar_service_impl.dart';
import '../core/service/toast/toast_service.dart';
import '../core/service/toast/toast_service_impl.dart';
import '../core/service/url_launcher/url_launcher_impl.dart';
import '../core/service/url_launcher/url_launcher_service.dart';
import '../core/service/validator/validator_service.dart';
import '../core/service/validator/validator_service_impl.dart';
import '../core/utility/connectivity_state.dart';
import '../core/utility/image_selector.dart';
import '../ui/views/main_body/main_body_view_model.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerSingleton<NavigationService>(NavigationServiceImpl());
  locator.registerLazySingleton<SnackBarService>(() => SnackBarServiceImpl());
  locator.registerLazySingleton<DialogService>(() => DialogServiceImpl());
  locator.registerLazySingleton<FirebaseAuthService>(
      () => FirebaseAuthServiceImpl());
  locator.registerLazySingleton<ValidatorService>(() => ValidatorServiceImpl());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => ConnectivityStateCheck());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  locator.registerLazySingleton<SessionService>(() => SessionServiceImpl());
  locator.registerLazySingleton<ToastService>(() => ToastServiceImpl());
  locator.registerLazySingleton(() => SearchIndexService());
  locator.registerLazySingleton<URLLauncherService>(
      () => URLLauncherServiceImpl());
  locator.registerLazySingleton(() => ConnectivityService());
  locator.registerLazySingleton(() => FirebaseMessagingService());
  locator.registerLazySingleton<PdfService>(() => PdfServiceImp());
  locator.registerLazySingleton<MainBodyViewModel>(() => MainBodyViewModel());
}
