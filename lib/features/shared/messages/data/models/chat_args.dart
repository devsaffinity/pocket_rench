import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_perspective.dart';
import 'package:pocketwrench/features/shared/messages/data/models/support_request.dart';

/// How the chat screen is opened: from an existing conversation, or by
/// contacting a mechanic (which opens or starts one).
class ChatArgs {
  const ChatArgs.conversation(
    String this.conversationId, {
    this.perspective = ChatPerspective.requester,
  }) : mechanic = null,
       customerId = null,
       customerName = null,
       request = null;

  const ChatArgs.mechanic(Mechanic this.mechanic, {this.request})
    : conversationId = null,
      customerId = null,
      customerName = null,
      perspective = ChatPerspective.requester;

  /// Opens (or starts) the mechanic's conversation with a customer.
  const ChatArgs.customer({
    required String this.customerId,
    required String this.customerName,
    this.request,
  }) : conversationId = null,
       mechanic = null,
       perspective = ChatPerspective.mechanic;

  final String? customerId;
  final String? customerName;

  final ChatPerspective perspective;

  final String? conversationId;
  final Mechanic? mechanic;
  final SupportRequest? request;
}
