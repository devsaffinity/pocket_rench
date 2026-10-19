/// One row of the conversation list.
class Conversation {
  const Conversation({
    required this.id,
    required this.participantName,
    required this.participantRole,
    required this.avatar,
    required this.lastMessage,
    required this.timeLabel,
    this.unreadCount = 0,
    this.isVerified = true,
  });

  final String id;
  final String participantName;

  /// For example "Automotive Technician".
  final String participantRole;

  /// Asset path or network URL.
  final String avatar;
  final String lastMessage;

  /// Relative time such as "2m" or "1h".
  final String timeLabel;
  final int unreadCount;
  final bool isVerified;

  bool get hasUnread => unreadCount > 0;

  Conversation copyWith({String? lastMessage, String? timeLabel}) {
    return Conversation(
      id: id,
      participantName: participantName,
      participantRole: participantRole,
      avatar: avatar,
      lastMessage: lastMessage ?? this.lastMessage,
      timeLabel: timeLabel ?? this.timeLabel,
      unreadCount: unreadCount,
      isVerified: isVerified,
    );
  }
}
