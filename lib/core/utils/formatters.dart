import 'package:pocketwrench/core/constants/app_strings.dart';

/// Display formatting for values shown in the UI.
abstract final class Formatters {
  /// "October 24, 1991".
  static String longDate(DateTime date) =>
      '${AppStrings.months[date.month - 1]} ${date.day}, ${date.year}';

  /// "Dec 2027".
  static String monthYear(DateTime date) =>
      '${AppStrings.monthsShort[date.month - 1]} ${date.year}';
}
