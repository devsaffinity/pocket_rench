import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_item.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_thread.dart';
import 'package:pocketwrench/features/shared/messages/data/models/conversation.dart';
import 'package:pocketwrench/features/shared/messages/data/models/support_request.dart';

/// Conversations and chat messages.
abstract class MessageRepository {
  Future<List<Conversation>> loadConversations();

  Future<ChatThread> loadThread(String conversationId);

  /// Opens the conversation with [mechanic], starting one if none exists.
  Future<ChatThread> openWithMechanic(
    Mechanic mechanic, {
    SupportRequest? request,
  });

  /// Opens the conversation with the customer [name], starting one if none
  /// exists. Used from the mechanic's side.
  Future<ChatThread> openWithCustomer({
    required String id,
    required String name,
    SupportRequest? request,
  });

  Future<ChatMessage> sendText({
    required String conversationId,
    required String text,
  });
}
