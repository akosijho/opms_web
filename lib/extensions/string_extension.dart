import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  DateTime? toDateTime() => DateTime.tryParse(this);

  // String toDateTime() => '';
  String? get toCurrency {
    if (this != '') {
      return ' ₱${NumberFormat("#,##0.00", "en_PH").format(double.tryParse(this))}';
    } else {
      return null;
    }
  }
}
