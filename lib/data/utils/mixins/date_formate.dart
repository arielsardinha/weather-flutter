import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:localization/localization.dart';

mixin DateFormatMixin {
  Future<void> _initializeLocale(String locale) async {
    await initializeDateFormatting(locale, null);
  }

  String formatDateFromDateTime(DateTime dateTime) {
    final locale = 'locale'.i18n();
    final dateFormat = 'date_format'.i18n();
    _initializeLocale(locale);

    return DateFormat(dateFormat, locale).format(dateTime);
  }
}
