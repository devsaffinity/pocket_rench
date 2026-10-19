import 'package:pocketwrench/features/shared/profile/data/models/account.dart';
import 'package:pocketwrench/features/shared/profile/data/models/notification_prefs.dart';
import 'package:pocketwrench/features/shared/profile/data/models/privacy_settings.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';

/// In-memory stand-in: edits last until the app restarts.
class MockAccountRepository implements AccountRepository {
  static const Duration _latency = Duration(milliseconds: 400);

  static final Account _requester = Account(
    name: 'Jess Monroe',
    email: 'jess.m@email.com',
    phone: '+966-3332-2321-22',
    birthDate: DateTime(1991, 10, 24),
    city: 'San Francisco, CA',
    avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
  );

  static final Account _mechanic = Account(
    name: 'King Tom',
    email: 'King.t@email.com',
    phone: '+1-214-555-0142',
    birthDate: DateTime(1987, 3, 12),
    city: 'Dallas, TX',
    avatarUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
  );

  Account _account = _requester;

  /// Mock only: serves the mechanic sample account from now on. A real backend
  /// returns whoever is signed in.
  void useMechanicAccount() {
    _account = _mechanic;
    _notifications = _mechanicNotifications;
  }

  /// Mock only: serves the requester sample account (the default).
  void useRequesterAccount() {
    _account = _requester;
    _notifications = _requesterNotifications;
  }

  static const NotificationPrefs _requesterNotifications = NotificationPrefs(
    responses: false,
    chatMessages: true,
    liveInvites: true,
    requestResolved: true,
    responseHelpful: true,
  );

  static const NotificationPrefs _mechanicNotifications = NotificationPrefs(
    responses: true,
    chatMessages: true,
    liveInvites: true,
    requestResolved: true,
    responseHelpful: true,
  );

  NotificationPrefs _notifications = _requesterNotifications;

  PrivacySettings _privacy = const PrivacySettings(cityLevelLocationOnly: true);

  @override
  Future<Account> loadAccount() async {
    await Future<void>.delayed(_latency);
    return _account;
  }

  @override
  Future<void> saveAccount(Account account) async {
    await Future<void>.delayed(_latency);
    _account = account;
  }

  @override
  Future<List<String>> loadCities() async => const [
    'San Francisco, CA',
    'Dallas, TX',
    'Houston, TX',
    'Austin, TX',
    'Los Angeles, CA',
    'San Diego, CA',
    'Phoenix, AZ',
    'Chicago, IL',
    'New York, NY',
  ];

  @override
  Future<NotificationPrefs> loadNotificationPrefs() async => _notifications;

  @override
  Future<void> saveNotificationPrefs(NotificationPrefs prefs) async {
    await Future<void>.delayed(_latency);
    _notifications = prefs;
  }

  @override
  Future<PrivacySettings> loadPrivacy() async => _privacy;

  @override
  Future<void> savePrivacy(PrivacySettings settings) async {
    await Future<void>.delayed(_latency);
    _privacy = settings;
  }

  @override
  Future<void> changePassword({
    required String current,
    required String next,
  }) => Future<void>.delayed(_latency);
}
