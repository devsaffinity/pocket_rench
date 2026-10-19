import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_args.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_perspective.dart';
import 'package:pocketwrench/features/shared/messages/data/models/conversation.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/message_repository.dart';

/// Conversation list with local search.
class MessagesViewModel extends GetxController {
  MessagesViewModel(
    this._repository, {
    required VoidCallback onBack,
    required VoidCallback onEmptyAction,
    this.perspective = ChatPerspective.requester,
  }) : _onBack = onBack,
       _onEmptyAction = onEmptyAction;

  /// Whose conversations these are; chats opened from here are drawn from the
  /// same side.
  final ChatPerspective perspective;

  final MessageRepository _repository;
  final VoidCallback _onBack;
  final VoidCallback _onEmptyAction;

  final TextEditingController searchController = TextEditingController();

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<Conversation> _conversations = const [];

  /// Whether the person has no conversations at all (not just no matches).
  bool get hasNoConversations =>
      _state == ViewState.success && _conversations.isEmpty;

  String _query = '';

  /// Conversations matching the search text.
  List<Conversation> get visibleConversations {
    final needle = _query.trim().toLowerCase();
    if (needle.isEmpty) return _conversations;
    return _conversations
        .where(
          (c) =>
              c.participantName.toLowerCase().contains(needle) ||
              c.lastMessage.toLowerCase().contains(needle),
        )
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  @override
  void onClose() {
    AppHelpers.disposeAfterFrame([searchController]);
    super.onClose();
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.messagesList]);
    try {
      _conversations = await _repository.loadConversations();
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.messagesList]);
  }

  void onQueryChanged(String value) {
    _query = value;
    update([AppUpdateIds.messagesList]);
  }

  Future<void> onConversationTap(Conversation conversation) async {
    await Get.toNamed<void>(
      AppRoutes.chat,
      arguments: ChatArgs.conversation(
        conversation.id,
        perspective: perspective,
      ),
    );
    // Previews and times change while chatting.
    await load();
  }

  /// The button on the empty state.
  void onEmptyAction() => _onEmptyAction();

  void onBack() => _onBack();
}
