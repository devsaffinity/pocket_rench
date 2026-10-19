import 'package:pocketwrench/features/shared/alerts/data/models/alert_item.dart';
import 'package:pocketwrench/features/shared/alerts/data/repositories/alerts_repository.dart';

/// Fixed sample notifications matching the design. Reads last until restart.
class MockAlertsRepository implements AlertsRepository {
  static const Duration _latency = Duration(milliseconds: 400);

  final List<AlertItem> _alerts = [
    const AlertItem(
      id: 'mike-responded',
      title: 'Mike Responded',
      body: 'Mike Anderson responded to your request.',
      isToday: true,
      isUnread: true,
    ),
    const AlertItem(
      id: 'youre-invited',
      title: 'You’re Invited',
      body: 'You were invited to a live diagnostic session.',
      isToday: true,
      isUnread: true,
    ),
    const AlertItem(
      id: 'join-us-live',
      title: 'Join Us Live',
      body: "Don't miss out on our exclusive live Q&A session.",
      isToday: true,
      isUnread: true,
    ),
    const AlertItem(
      id: 'request-resolved',
      title: 'Request Resolved',
      body: 'Your Ford F-150 request was marked resolved.',
    ),
    const AlertItem(
      id: 'marked-helpful',
      title: 'Marked Helpful',
      body: 'Your advice was marked helpful by Marcus Harris.',
    ),
    const AlertItem(
      id: 'follow-up-requested',
      title: 'Follow-up Requested',
      body: 'Jane Doe has requested a follow-up on your previous suggestion.',
    ),
    const AlertItem(
      id: 'no-response-yet',
      title: 'No Response Yet',
      body: 'Sam Lee has not yet responded to your feedback.',
    ),
    const AlertItem(
      id: 'advice-implemented',
      title: 'Advice Implemented',
      body: 'Chris Walker implemented your advice on the brake issue.',
    ),
  ];

  @override
  Future<List<AlertItem>> loadAlerts() async {
    await Future<void>.delayed(_latency);
    return List.unmodifiable(_alerts);
  }

  @override
  Future<void> markRead(String id) async {
    final index = _alerts.indexWhere((alert) => alert.id == id);
    if (index >= 0) _alerts[index] = _alerts[index].markRead();
  }
}
