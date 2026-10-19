import 'package:pocketwrench/features/shared/profile/data/models/account.dart';
import 'package:pocketwrench/features/shared/profile/data/models/notification_prefs.dart';
import 'package:pocketwrench/features/shared/profile/data/models/privacy_settings.dart';

/// The signed-in person's account and settings.
abstract class AccountRepository {
  Future<Account> loadAccount();
  Future<void> saveAccount(Account account);

  /// Cities offered in the location picker.
  Future<List<String>> loadCities();

  Future<NotificationPrefs> loadNotificationPrefs();
  Future<void> saveNotificationPrefs(NotificationPrefs prefs);

  Future<PrivacySettings> loadPrivacy();
  Future<void> savePrivacy(PrivacySettings settings);

  /// Throws when [current] is wrong.
  Future<void> changePassword({required String current, required String next});
}
