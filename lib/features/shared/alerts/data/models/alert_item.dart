/// One notification in the Alerts list.
class AlertItem {
  const AlertItem({
    required this.id,
    required this.title,
    required this.body,
    this.isToday = false,
    this.isUnread = false,
  });

  final String id;
  final String title;
  final String body;

  /// Shown under "Today"; the rest go under "Earlier".
  final bool isToday;
  final bool isUnread;

  AlertItem markRead() =>
      AlertItem(id: id, title: title, body: body, isToday: isToday);
}
