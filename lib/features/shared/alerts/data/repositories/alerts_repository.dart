import 'package:pocketwrench/features/shared/alerts/data/models/alert_item.dart';

/// The signed-in person's notifications.
abstract class AlertsRepository {
  /// Newest first.
  Future<List<AlertItem>> loadAlerts();

  Future<void> markRead(String id);
}
