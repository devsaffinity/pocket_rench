/// Which events send the person a notification.
class NotificationPrefs {
  const NotificationPrefs({
    required this.responses,
    required this.chatMessages,
    required this.liveInvites,
    required this.requestResolved,
    required this.responseHelpful,
  });

  final bool responses;
  final bool chatMessages;
  final bool liveInvites;
  final bool requestResolved;
  final bool responseHelpful;

  NotificationPrefs copyWith({
    bool? responses,
    bool? chatMessages,
    bool? liveInvites,
    bool? requestResolved,
    bool? responseHelpful,
  }) {
    return NotificationPrefs(
      responses: responses ?? this.responses,
      chatMessages: chatMessages ?? this.chatMessages,
      liveInvites: liveInvites ?? this.liveInvites,
      requestResolved: requestResolved ?? this.requestResolved,
      responseHelpful: responseHelpful ?? this.responseHelpful,
    );
  }
}
