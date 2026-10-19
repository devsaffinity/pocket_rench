import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_args.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_perspective.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_thread.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/message_repository.dart';

enum AttachmentType { camera, photos, video, document }

/// One chat thread: messages, the input box, attachments and voice notes.
class ChatViewModel extends GetxController {
  ChatViewModel(this._repository);

  /// Bar heights (0 to 1) of the recording waveform at rest.
  static const List<double> _waveShape = [
    0.21, 0.42, 0.74, 0.95, 0.32, 0.53, 0.84, 0.26, //
    0.63, 1.0, 0.37, 0.47, 0.74, 0.21, 0.32,
  ];
  static const Duration _waveStep = Duration(milliseconds: 140);

  final MessageRepository _repository;

  final TextEditingController inputController = TextEditingController();
  final FocusNode inputFocus = FocusNode();
  final ScrollController scrollController = ScrollController();

  ChatArgs? _args;

  ChatPerspective get perspective =>
      _args?.perspective ?? ChatPerspective.requester;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  ChatThread? _thread;
  ChatThread? get thread => _thread;

  bool _hasText = false;
  bool get hasText => _hasText;

  Timer? _recordingTimer;
  Timer? _waveTimer;
  int _recordingSeconds = 0;
  int get recordingSeconds => _recordingSeconds;
  int _waveOffset = 0;

  /// Waveform bar heights (0 to 1), shifting while recording.
  List<double> get waveLevels => [
    for (var i = 0; i < _waveShape.length; i++)
      _waveShape[(i + _waveOffset) % _waveShape.length],
  ];

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is ChatArgs) _args = arguments;
    inputController.addListener(_onInputChanged);
    unawaited(load());
  }

  @override
  void onClose() {
    _stopTimers();
    inputController.removeListener(_onInputChanged);
    AppHelpers.disposeAfterFrame([
      inputController,
      inputFocus,
      scrollController,
    ]);
    super.onClose();
  }

  Future<void> load() async {
    final args = _args;
    if (args == null) {
      _state = ViewState.error;
      update([AppUpdateIds.chatBody]);
      return;
    }

    _state = ViewState.loading;
    update([AppUpdateIds.chatBody]);
    try {
      final mechanic = args.mechanic;
      final customerId = args.customerId;
      if (mechanic != null) {
        _thread = await _repository.openWithMechanic(
          mechanic,
          request: args.request,
        );
      } else if (customerId != null) {
        _thread = await _repository.openWithCustomer(
          id: customerId,
          name: args.customerName ?? '',
          request: args.request,
        );
      } else {
        _thread = await _repository.loadThread(args.conversationId!);
      }
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.chatBody]);
    _scrollToEnd(animate: false);
  }

  void _onInputChanged() {
    final next = inputController.text.trim().isNotEmpty;
    if (next == _hasText) return;
    _hasText = next;
    update([AppUpdateIds.chatInput]);
  }

  Future<void> send() async {
    final current = _thread;
    final text = inputController.text.trim();
    if (current == null || text.isEmpty) return;

    inputController.clear();
    final message = await _repository.sendText(
      conversationId: current.conversation.id,
      text: text,
    );
    _thread = (_thread ?? current).withItem(message);
    update([AppUpdateIds.chatBody]);
    _scrollToEnd(animate: true);
  }

  void _scrollToEnd({required bool animate}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      final end = scrollController.position.maxScrollExtent;
      if (animate) {
        unawaited(
          scrollController.animateTo(
            end,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          ),
        );
      } else {
        scrollController.jumpTo(end);
      }
    });
  }

  // Attachments need camera, gallery and file pickers, which are not approved.
  // void onAttachmentSelected(AttachmentType type) {
  //   Get.back<void>();
  //   AppSnackbar.show(AppStrings.attachmentsUnavailable);
  // }

  // Voice notes

  void startRecording() {
    _stopTimers();
    _recordingSeconds = 0;
    _waveOffset = 0;
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _recordingSeconds++;
      update([AppUpdateIds.chatRecording]);
    });
    _waveTimer = Timer.periodic(_waveStep, (_) {
      _waveOffset++;
      update([AppUpdateIds.chatRecording]);
    });
    update([AppUpdateIds.chatRecording]);
  }

  /// Stops the timers. Safe to call more than once.
  void stopRecording() => _stopTimers();

  void _stopTimers() {
    _recordingTimer?.cancel();
    _waveTimer?.cancel();
    _recordingTimer = null;
    _waveTimer = null;
  }

  void onCancelRecording() {
    _stopTimers();
    Get.back<void>();
  }

  // Recording audio needs a recorder package, which is not approved.
  void onSendVoice() {
    _stopTimers();
    Get.back<void>();
    AppSnackbar.show(AppStrings.voiceNotesUnavailable);
  }

  // Calls and the request screen are not designed yet.
  void onPhone() => AppSnackbar.show(AppStrings.featureComingSoon);
  void onViewRequest() => AppSnackbar.show(AppStrings.featureComingSoon);
  void onStartLiveStream() => AppSnackbar.show(AppStrings.featureComingSoon);

  void onBack() => Get.back<void>();
}
