import 'package:opmswebstaff/core/service/url_launcher/url_launcher_service.dart';
import 'package:url_launcher/url_launcher.dart';

class URLLauncherServiceImpl implements URLLauncherService {
  @override
  void callPhoneNumber({required String phone}) {
    //launch phone dialer with provided phone number to be called
    launch('tel:$phone');
  }

  @override
  void sendTextMessage({required String phone}) {
    //launch phone sms app with provided phone number to be texted
    launch('sms:$phone');
  }
}
