class DateHelper {
  static DateHelper instance = DateHelper();

  getFormattedDbDate(DateTime date) {
    final DateTime now = date;
    return "${now.year}-${now.month}-${now.day}";
  }
}
