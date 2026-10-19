/// An entry in a chat thread: a message or a time separator.
sealed class ChatItem {
  const ChatItem(this.id);

  final String id;
}

class TimeSeparator extends ChatItem {
  const TimeSeparator({required String id, required this.label}) : super(id);

  /// For example "Today, 2:15 PM".
  final String label;
}

sealed class ChatMessage extends ChatItem {
  const ChatMessage(super.id, {required this.isMine});

  /// Sent by the signed-in person (right side) rather than received.
  final bool isMine;
}

class TextMessage extends ChatMessage {
  const TextMessage({
    required String id,
    required super.isMine,
    required this.text,
  }) : super(id);

  final String text;
}

class ImageMessage extends ChatMessage {
  const ImageMessage({
    required String id,
    required super.isMine,
    required this.url,
  }) : super(id);

  /// Asset path or network URL.
  final String url;
}

class VideoMessage extends ChatMessage {
  const VideoMessage({
    required String id,
    required super.isMine,
    required this.thumbnailUrl,
  }) : super(id);

  /// Asset path or network URL of the preview frame.
  final String thumbnailUrl;
}
