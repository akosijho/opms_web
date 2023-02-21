import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../../../models/notification_token/notification_token_model.dart';

class FirebaseMessagingService {
  Future<void> sendTopicNotification({
    required int notificationId,
    required String toTopic,
    required String bagId,
    required String title,
    required String message,
    required String imageUrl,
    required String route,
  }) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final serverToken = "AAAA22iuutQ:APA91bGbn4jlDT20iy0d5mwuQTauOJYUby3W"
        "E3IZ9WveHFOOoy1BNZalFUqI2iHL3m8kTLaGVeNxOPD-PiJqigOu321Nu7q_h5Wn8eIPNEq9X9YI90IteSjflr4s-7gylXd8KLwKMtNf";
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Key= $serverToken'
    };

    final response = await http.post(url,
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          'notification': <String, dynamic>{},
          'priority': 'high',
          'content-available': 'true',
          'data': <String, dynamic>{
            'notificationId': notificationId,
            'title': title,
            'body': message,
            'image_url': imageUrl,
            'route': route,
            'payload': bagId
          },
          'to': toTopic
        }));
  }

  Future<NotificationToken> saveFcmToken() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    final tokenId = await FirebaseMessaging.instance.getToken();

    return NotificationToken(uid: uid, tokenId: tokenId);
  }
}
