import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:opmswebstaff/core/utility/custom_scroll_behaviour.dart';
import 'package:opmswebstaff/firebase_options.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'constants/styles/palette_color.dart';
import 'constants/styles/theme_style.dart';
// import 'package:http/http.dart' as http;

String appVersion = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: Palettes.kcBlueMain1,
  ));
  // final response = await http.get(Uri.parse('https://example.com'));
  // print(response.body);

  setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp();
  await GetStorage.init('MyLocalDB');
  // FirebaseAuth auth = FirebaseAuth.instance.currentUser;
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  // await getAppVersionNumber();

  runApp(opmswebstaff());
  // Add the following line:
  // FlutterNativeSplash.remove();

}

final navigationService = locator<NavigationService>();

class opmswebstaff extends StatelessWidget {
  const opmswebstaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      builder: (context, widget) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EyeChoice Optical Shop',

        // initialRoute: Routes.PreLoader,
        initialRoute: Routes.Login,

        onGenerateRoute: StackedRouter().onGenerateRoute,
        themeMode: ThemeMode.light,
        theme: ThemeStyles.themeLight,
        scrollBehavior: CustomScrollBehaviour(),
      ),
    );
  }
}

// Future<void> getAppVersionNumber() async {
//   final packageInfo = await PackageInfo.fromPlatform();
//   appVersion = packageInfo.version;
// }
