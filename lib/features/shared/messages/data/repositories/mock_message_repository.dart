import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_item.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_thread.dart';
import 'package:pocketwrench/features/shared/messages/data/models/conversation.dart';
import 'package:pocketwrench/features/shared/messages/data/models/support_request.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/message_repository.dart';

/// In-memory sample conversations matching the design.
class MockMessageRepository implements MessageRepository {
  static const Duration _latency = Duration(milliseconds: 400);

  static const SupportRequest _sampleRequest = SupportRequest(
    id: 'request-1',
    title: 'Engine overheating at idle',
    details: '2019 Ford F-150 · Engine',
  );

  static const List<Conversation> _requesterConversations = [
    Conversation(
      id: 'mike-anderson',
      participantName: 'Mike Anderson',
      participantRole: 'Automotive Technician',
      avatar: 'https://randomuser.me/api/portraits/men/86.jpg',
      lastMessage: 'Can you send me a photo of the coolant reservoir?',
      timeLabel: '2m',
      unreadCount: 1,
    ),
    Conversation(
      id: 'robert-davis',
      participantName: 'Robert Davis',
      participantRole: 'Diagnostics Specialist',
      avatar: 'https://randomuser.me/api/portraits/men/52.jpg',
      lastMessage: "I'll take a look at the video.",
      timeLabel: '1h',
    ),
    Conversation(
      id: 'sarah-jenkins',
      participantName: 'Sarah Jenkins',
      participantRole: 'Engine Specialist',
      avatar: 'https://randomuser.me/api/portraits/women/12.jpg',
      lastMessage: 'That should fix it. Let me know.',
      timeLabel: '3h',
    ),
  ];

  static const List<ChatItem> _requesterMikeThread = [
    TextMessage(
      id: 'm1',
      isMine: true,
      text:
          'Hi Mike, the truck starts overheating after about 10 minutes of '
          'idling.',
    ),
    TimeSeparator(id: 't1', label: 'Today, 2:15 PM'),
    TextMessage(
      id: 'm2',
      isMine: false,
      text:
          'Got it. Can you send me a photo of the coolant reservoir and '
          'radiator area?',
    ),
    TextMessage(id: 'm3', isMine: true, text: 'Sure, sending them now.'),
    ImageMessage(
      id: 'm4',
      isMine: true,
      url: 'https://picsum.photos/seed/engine-bay/600/440',
    ),
    TextMessage(
      id: 'm5',
      isMine: false,
      text: "Thanks. Can you also record a short video while it's idling?",
    ),
    VideoMessage(
      id: 'm6',
      isMine: true,
      thumbnailUrl: 'https://picsum.photos/seed/dashboard/600/440',
    ),
  ];

  final List<Conversation> _conversations = [];
  final Map<String, List<ChatItem>> _threads = {};

  MockMessageRepository() {
    useRequesterData();
  }

  /// Mock only: serves the requester's conversations (the default).
  void useRequesterData() {
    _conversations
      ..clear()
      ..addAll(_requesterConversations);
    _threads
      ..clear()
      ..['mike-anderson'] = List.of(_requesterMikeThread);
  }

  /// The mechanic's side of the same sample data: customers writing in.
  static const List<Conversation> _mechanicConversations = [
    Conversation(
      id: 'mike-anderson',
      participantName: 'Mike Anderson',
      participantRole: 'Customer',
      avatar: 'https://randomuser.me/api/portraits/men/19.jpg',
      lastMessage: 'Can you send me a photo of the coolant reservoir?',
      timeLabel: '2m',
      unreadCount: 1,
    ),
    Conversation(
      id: 'robert-davis',
      participantName: 'Robert Davis',
      participantRole: 'Customer',
      avatar: 'https://randomuser.me/api/portraits/men/64.jpg',
      lastMessage: "I'll take a look at the video.",
      timeLabel: '1h',
    ),
    Conversation(
      id: 'sarah-jenkins',
      participantName: 'Sarah Jenkins',
      participantRole: 'Customer',
      avatar: 'https://randomuser.me/api/portraits/women/90.jpg',
      lastMessage: 'That should fix it. Let me know.',
      timeLabel: '3h',
    ),
  ];

  static const List<ChatItem> _mechanicMikeThread = [
    TextMessage(
      id: 'c1',
      isMine: true,
      text: "Thanks for the details. Let's check the coolant flow first.",
    ),
    TextMessage(id: 'c2', isMine: false, text: 'The coolant level is normal.'),
    TextMessage(
      id: 'c3',
      isMine: true,
      text:
          'Can you start the engine and send me a short video of the '
          'temperature gauge?',
    ),
    VideoMessage(
      id: 'c4',
      isMine: false,
      thumbnailUrl: 'https://picsum.photos/seed/dashboard/600/440',
    ),
    TextMessage(
      id: 'c5',
      isMine: true,
      text:
          'I see what you mean. Check whether the cooling fan is switching '
          'on.',
    ),
  ];

  /// Mock only: serves the mechanic's conversations from now on. A real
  /// backend returns the signed-in person's own.
  void useMechanicData() {
    _conversations
      ..clear()
      ..addAll(_mechanicConversations);
    _threads
      ..clear()
      ..['mike-anderson'] = List.of(_mechanicMikeThread)
      // Customers whose chats start from a service request.
      ..['james-wilson'] = List.of(_mechanicMikeThread)
      ..['sarah-lee'] = [
        const TextMessage(
          id: 'sl1',
          isMine: false,
          text: "I've checked the levels, and it's low.",
        ),
      ]
      ..['robert-smith'] = [
        const TextMessage(
          id: 'rs1',
          isMine: false,
          text: 'Can you run a diagnostic scan?',
        ),
      ];
  }

  int _nextId = 100;

  @override
  Future<List<Conversation>> loadConversations() async {
    await Future<void>.delayed(_latency);
    return List.unmodifiable(_conversations);
  }

  @override
  Future<ChatThread> loadThread(String conversationId) async {
    await Future<void>.delayed(_latency);
    final conversation = _conversations.firstWhere(
      (c) => c.id == conversationId,
    );
    return ChatThread(
      conversation: conversation,
      items: List.of(_threads[conversationId] ?? const []),
      request: conversationId == 'mike-anderson' ? _sampleRequest : null,
    );
  }

  @override
  Future<ChatThread> openWithMechanic(
    Mechanic mechanic, {
    SupportRequest? request,
  }) async {
    await Future<void>.delayed(_latency);
    final existing = _conversations.where((c) => c.id == mechanic.id);
    if (existing.isNotEmpty) {
      final thread = await loadThread(mechanic.id);
      return ChatThread(
        conversation: thread.conversation,
        items: thread.items,
        request: request ?? thread.request,
      );
    }

    final conversation = Conversation(
      id: mechanic.id,
      participantName: mechanic.name,
      participantRole: mechanic.specialty,
      avatar: mechanic.avatar,
      lastMessage: '',
      timeLabel: 'now',
      isVerified: mechanic.isVerified,
    );
    _conversations.insert(0, conversation);
    _threads[mechanic.id] = [];
    return ChatThread(
      conversation: conversation,
      items: const [],
      request: request,
    );
  }

  @override
  Future<ChatThread> openWithCustomer({
    required String id,
    required String name,
    SupportRequest? request,
  }) async {
    await Future<void>.delayed(_latency);
    var index = _conversations.indexWhere((c) => c.id == id);
    if (index < 0) {
      final items = _threads.putIfAbsent(id, () => []);
      final last = items.whereType<TextMessage>().lastOrNull;
      _conversations.insert(
        0,
        Conversation(
          id: id,
          participantName: name,
          participantRole: 'Customer',
          avatar:
              'https://randomuser.me/api/portraits/lego/${id.hashCode.abs() % 9}.jpg',
          lastMessage: last?.text ?? '',
          timeLabel: 'now',
        ),
      );
      index = 0;
    }
    return ChatThread(
      conversation: _conversations[index],
      items: List.of(_threads[id] ?? const []),
      request: request,
    );
  }

  @override
  Future<ChatMessage> sendText({
    required String conversationId,
    required String text,
  }) async {
    final message = TextMessage(
      id: 'sent-${_nextId++}',
      isMine: true,
      text: text,
    );
    _threads.putIfAbsent(conversationId, () => []).add(message);
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index >= 0) {
      _conversations[index] = _conversations[index].copyWith(
        lastMessage: text,
        timeLabel: 'now',
      );
    }
    return message;
  }
}
