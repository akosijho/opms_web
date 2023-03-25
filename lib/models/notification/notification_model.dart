import 'package:opmswebstaff/extensions/string_extension.dart';

class NotificationModel {
  dynamic id;
  final dynamic user_id;
  final String notification_title;
  final String notification_msg;
  final String notification_type;
  bool isRead;
  DateTime? date_created;

  NotificationModel({
    this.id,
    required this.user_id,
    required this.notification_title,
    required this.notification_msg,
    required this.notification_type,
    required this.isRead,
    this.date_created,
  });

  Map<String, dynamic> toJson(
      {required dynamic id, required DateTime timestamp}) {
    return {
      'id': id,
      'user_id': this.user_id,
      'notification_title': this.notification_title,
      'notification_msg': this.notification_msg,
      'notification_type': this.notification_type,
      'isRead': this.isRead,
      'date_created': timestamp.toString(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as dynamic,
      user_id: map['user_id'] as dynamic,
      notification_title: map['notification_title'] as String,
      notification_msg: map['notification_msg'] as String,
      notification_type: map['notification_type'] as String,
      isRead: map['isRead'] as bool,
      date_created: (map['date_created']).toString().toDateTime(),
    );
  }
}
