import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

mixin DateFormatMixin {
  String formatDateFromDateTime(DateTime dateTime) {
    final locale = 'locale'.i18n();
    final dateFormat = 'date_format'.i18n();

    try {
      return DateFormat(dateFormat, locale).format(dateTime);
    } catch (e) {
      return '';
    }
  }
}
