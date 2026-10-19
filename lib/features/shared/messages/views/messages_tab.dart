import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/app_search_field.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/features/shared/messages/view_models/messages_view_model.dart';
import 'package:pocketwrench/features/shared/messages/views/widgets/conversation_card.dart';

/// Messages tab body: the conversation list, or an invitation to find a
/// mechanic when there are none. Hosted by the main shell.
class MessagesTab extends GetView<MessagesViewModel> {
  const MessagesTab({
    super.key,
    this.emptyBody = AppStrings.noMessagesBody,
    this.emptyActionLabel = AppStrings.findAMechanic,
  });

  /// What the empty state says, and its button, for the role using the tab.
  final String emptyBody;
  final String emptyActionLabel;

  @override
  Widget build(BuildContext context) {
    final topShift = math.max(
      0.0,
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
    );
    final backButton = Positioned(
      left: AppSizes.authBackLeft,
      top: AppSizes.authBackTop + topShift,
      child: AppIconButton(
        svgPath: AppIcons.arrowLeft,
        size: AppSizes.iconBack,
        onPressed: controller.onBack,
      ),
    );

    return GetBuilder<MessagesViewModel>(
      id: AppUpdateIds.messagesList,
      builder: (vm) {
        if (vm.hasNoConversations) {
          return Stack(
            children: [
              _EmptyMessages(
                body: emptyBody,
                actionLabel: emptyActionLabel,
                onAction: vm.onEmptyAction,
              ),
              backButton,
            ],
          );
        }

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: AppHelpers.unfocus,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: AppSizes.authTitleTopRole + topShift,
                  left: AppSizes.screenPaddingH,
                  right: AppSizes.screenPaddingH,
                  bottom: AppSizes.homeBottomPadding,
                ),
                child: FadeSlideIn(child: _ConversationList(viewModel: vm)),
              ),
              backButton,
            ],
          ),
        );
      },
    );
  }
}

class _ConversationList extends StatelessWidget {
  const _ConversationList({required this.viewModel});

  final MessagesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final conversations = viewModel.visibleConversations;

    Widget body;
    if (viewModel.state == ViewState.error) {
      body = AppEmptyState(
        title: AppStrings.genericError,
        actionLabel: AppStrings.retry,
        onAction: viewModel.load,
      );
    } else if (viewModel.state != ViewState.success) {
      body = Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spaceXL),
        child: const Center(child: AppLoader()),
      );
    } else if (conversations.isEmpty) {
      body = Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spaceXL),
        child: const AppEmptyState(title: AppStrings.noConversationsFound),
      );
    } else {
      body = Column(
        children: [
          for (final conversation in conversations) ...[
            ConversationCard(
              conversation: conversation,
              onTap: () => viewModel.onConversationTap(conversation),
            ),
            SizedBox(height: AppSizes.convCardGap),
          ],
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.heading(AppStrings.messagesTitle),
        SizedBox(height: AppSizes.exploreTitleSearchGap),
        AppSearchField(
          controller: viewModel.searchController,
          hint: AppStrings.searchConversations,
          onChanged: viewModel.onQueryChanged,
        ),
        SizedBox(height: AppSizes.convListTop),
        body,
      ],
    );
  }
}

class _EmptyMessages extends StatelessWidget {
  const _EmptyMessages({
    required this.body,
    required this.actionLabel,
    required this.onAction,
  });

  final String body;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    // The design centers this on the whole screen, not above the nav bar.
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: AppSizes.screenPaddingH,
          right: AppSizes.screenPaddingH,
          top: AppSizes.emptyCenterShift,
        ),
        child: FadeSlideIn(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppSizes.emptyCircle,
                height: AppSizes.emptyCircle,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.emptyIconBackground,
                ),
                child: AppImage(
                  AppIcons.messageSquare,
                  width: AppSizes.emptyIcon,
                  height: AppSizes.emptyIcon,
                  fit: BoxFit.contain,
                  color: AppColors.logoAccent,
                ),
              ),
              SizedBox(height: AppSizes.emptyCircleTitleGap),
              AppText.heading(AppStrings.noMessagesTitle),
              SizedBox(height: AppSizes.emptyTitleBodyGap),
              AppText(
                body,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSubtle,
                ),
                align: TextAlign.center,
              ),
              SizedBox(height: AppSizes.emptyBodyButtonGap),
              AppButton(
                label: actionLabel,
                height: AppSizes.buttonHeightTall,
                onPressed: onAction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
