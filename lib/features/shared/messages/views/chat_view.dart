import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/theme/app_system_ui.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_bottom_sheet.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_perspective.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_thread.dart';
import 'package:pocketwrench/features/shared/messages/view_models/chat_view_model.dart';
import 'package:pocketwrench/features/shared/messages/views/widgets/attachment_sheet.dart';
import 'package:pocketwrench/features/shared/messages/views/widgets/chat_header.dart';
import 'package:pocketwrench/features/shared/messages/views/widgets/chat_input_bar.dart';
import 'package:pocketwrench/features/shared/messages/views/widgets/chat_items.dart';
import 'package:pocketwrench/features/shared/messages/views/widgets/recording_sheet.dart';
import 'package:pocketwrench/features/shared/messages/views/widgets/support_request_card.dart';

/// Full-screen chat with a mechanic.
class ChatView extends GetView<ChatViewModel> {
  const ChatView({super.key});

  Future<void> _openAttachments() {
    AppHelpers.unfocus();
    return AppBottomSheet.show<void>(
      style: AppSheetStyle.panel,
      title: AppStrings.addToMessage,
      child: const AttachmentSheet(),
    );
  }

  Future<void> _openRecorder() {
    AppHelpers.unfocus();
    controller.startRecording();
    return AppBottomSheet.show<void>(
      style: AppSheetStyle.panel,
      horizontalPadding: AppSizes.recordingPaddingH,
      child: const RecordingSheet(),
    ).whenComplete(controller.stopRecording);
  }

  @override
  Widget build(BuildContext context) {
    final topShift = math.max(
      0.0,
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.lightIcons,
      child: Scaffold(
        body: GetBuilder<ChatViewModel>(
          id: AppUpdateIds.chatBody,
          builder: (vm) {
            final thread = vm.thread;
            if (vm.state == ViewState.error) {
              return AppEmptyState(
                title: AppStrings.genericError,
                actionLabel: AppStrings.retry,
                onAction: vm.load,
              );
            }
            if (thread == null) return const Center(child: AppLoader());

            return Column(
              children: [
                SizedBox(height: AppSizes.chatHeaderTop + topShift),
                ChatHeader(
                  conversation: thread.conversation,
                  perspective: vm.perspective,
                  hasActiveRequest: thread.request != null,
                  onBack: vm.onBack,
                  onPhone: vm.onPhone,
                ),
                SizedBox(height: AppSizes.chatHeaderCardGap),
                Expanded(
                  child: _Messages(thread: thread, viewModel: vm),
                ),
                ChatInputBar(onAdd: _openAttachments, onMic: _openRecorder),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Messages extends StatelessWidget {
  const _Messages({required this.thread, required this.viewModel});

  final ChatThread thread;
  final ChatViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final request = thread.request;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: AppHelpers.unfocus,
      child: ListView(
        controller: viewModel.scrollController,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          AppSizes.screenPaddingH,
          0,
          AppSizes.screenPaddingH,
          AppSizes.chatListBottom,
        ),
        children: [
          if (request != null)
            SupportRequestCard(
              request: request,
              onView: viewModel.onViewRequest,
              onStartLiveStream:
                  viewModel.perspective == ChatPerspective.mechanic
                  ? viewModel.onStartLiveStream
                  : null,
            ),
          if (request != null) SizedBox(height: AppSizes.chatCardBubbleGap),
          for (var i = 0; i < thread.items.length; i++) ...[
            if (i > 0) SizedBox(height: AppSizes.chatItemGap),
            ChatItemView(
              item: thread.items[i],
              perspective: viewModel.perspective,
            ),
          ],
        ],
      ),
    );
  }
}
