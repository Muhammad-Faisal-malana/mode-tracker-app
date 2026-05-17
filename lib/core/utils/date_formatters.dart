import 'package:intl/intl.dart';

class DateFormatters {
  static String shortDate(DateTime date) => DateFormat('MMM d').format(date);
  static String timeOnly(DateTime date) => DateFormat('h:mm a').format(date);
}
