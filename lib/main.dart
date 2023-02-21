import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opmsapp/app/app.locator.dart';
import 'package:opmsapp/constants/styles/theme_style.dart';
import 'package:opmsapp/core/service/navigation/navigation_service.dart';
import 'package:opmsapp/core/utility/custom_scroll_behaviour.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/app.router.dart';
import 'constants/styles/palette_color.dart';

String appVersion = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: Palettes.kcBlueMain1,
  ));
  setupLocator();

  await Firebase.initializeApp();
  await GetStorage.init('MyLocalDB');
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  await getAppVersionNumber();

  runApp(OpmsApp());
  // Add the following line:
  FlutterNativeSplash.remove();

}

final navigationService = locator<NavigationService>();

class OpmsApp extends StatelessWidget {
  const OpmsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      builder: (context, widget) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EyeChoice Optical Shop',
        initialRoute: Routes.PreLoader,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        themeMode: ThemeMode.light,
        theme: ThemeStyles.themeLight,
        scrollBehavior: CustomScrollBehaviour(),
      ),
    );
  }
}

Future<void> getAppVersionNumber() async {
  final packageInfo = await PackageInfo.fromPlatform();
  appVersion = packageInfo.version;
}
