import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  /// Example: 07-08-2026 05:30 PM
  String toFormattedDateTime() {
    if (this == null) return '';

    return DateFormat('dd-MM-yyyy hh:mm a').format(this!);
  }

  /// Example: 07-08-2026
  String toFormattedDate() {
    if (this == null) return '';

    return DateFormat('dd-MM-yyyy').format(this!);
  }

  /// Example: 05:30 PM
  String toFormattedTime() {
    if (this == null) return '';

    return DateFormat('hh:mm a').format(this!);
  }
}
