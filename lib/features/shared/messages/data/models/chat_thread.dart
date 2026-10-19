import 'package:pocketwrench/features/shared/messages/data/models/chat_item.dart';
import 'package:pocketwrench/features/shared/messages/data/models/conversation.dart';
import 'package:pocketwrench/features/shared/messages/data/models/support_request.dart';

/// A conversation with its messages and the request it is about.
class ChatThread {
  const ChatThread({
    required this.conversation,
    required this.items,
    this.request,
  });

  final Conversation conversation;
  final List<ChatItem> items;

  /// The support request this chat started from, if any.
  final SupportRequest? request;

  ChatThread withItem(ChatItem item) => ChatThread(
    conversation: conversation,
    items: [...items, item],
    request: request,
  );
}
