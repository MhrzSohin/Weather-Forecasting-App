import 'package:intl/intl.dart';

class DateAndTimeHelper {
  static String covertTimeStampToTime(int? timestamp) {
    String time = 'N/A';
    if (timestamp != null) {
      DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
      time = DateFormat('hh:mm a').format(dateTime);
    }
    return time;
  }

  static String getCurrentDate() {
    String date = ' ';
    DateTime dateTime = DateTime.now();
    date = DateFormat('EEEE | MMM dd').format(dateTime);
    return date;
  }
}
