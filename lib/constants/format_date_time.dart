import 'package:intl/intl.dart';

class FormatDateTime {
  String formatDateTime(DateTime datetime) {
    return DateFormat('EEEE, MMM d \'at\' h:mm a').format(datetime);
  }
}