import 'package:opmsapp/extensions/string_extension.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  //convert date time to 12hr string format
  String toTime() => DateFormat.jm().format(this);

  String toStringDateFormat() => DateFormat.yMMMd().format(this);

  String toDateFormat() => DateFormat.yMMMd().add_jm().format(this);

  DateTime? toDateMonthDayOnly() =>
      DateFormat('yyyy-MM-dd').format(this).toDateTime();

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  bool isSameDateMonth(DateTime other) {
    return this.year == other.year && this.month == other.month;
  }

  bool isSameYear(DateTime other) {
    return this.year == other.year;
  }
}
