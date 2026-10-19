import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_perspective.dart';
import 'package:pocketwrench/features/shared/messages/data/models/conversation.dart';

/// Back button, participant name and a call button. A requester sees a
/// verified tag and the mechanic's role under the name; a mechanic sees
/// whether the request is still active.
class ChatHeader extends StatelessWidget {
  const ChatHeader({
    required this.conversation,
    required this.onBack,
    required this.onPhone,
    super.key,
    this.perspective = ChatPerspective.requester,
    this.hasActiveRequest = false,
  });

  final Conversation conversation;
  final VoidCallback onBack;
  final VoidCallback onPhone;
  final ChatPerspective perspective;

  /// Mechanic view only: show "Active Request" under the name.
  final bool hasActiveRequest;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppSizes.authBackLeft),
        AppIconButton(
          svgPath: AppIcons.arrowLeft,
          size: AppSizes.iconBack,
          onPressed: onBack,
        ),
        SizedBox(width: AppSizes.chatBackGap),
        Expanded(
          child: _Titles(
            conversation: conversation,
            perspective: perspective,
            hasActiveRequest: hasActiveRequest,
          ),
        ),
        AppIconButton(
          svgPath: AppIcons.phone,
          size: AppSizes.chatPhoneIcon,
          color: AppColors.textSecondary,
          onPressed: onPhone,
        ),
        SizedBox(width: AppSizes.chatPhoneInset),
      ],
    );
  }
}

class _Titles extends StatelessWidget {
  const _Titles({
    required this.conversation,
    required this.perspective,
    required this.hasActiveRequest,
  });

  final Conversation conversation;
  final ChatPerspective perspective;
  final bool hasActiveRequest;

  bool get _isMechanic => perspective == ChatPerspective.mechanic;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                conversation.participantName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.itemTitle,
              ),
            ),
            if (!_isMechanic && conversation.isVerified) ...[
              SizedBox(width: AppSizes.chatNameTagGap),
              const _VerifiedTag(),
            ],
          ],
        ),
        if (_isMechanic && hasActiveRequest) ...[
          SizedBox(height: AppSizes.chatNameRoleGap),
          // Drawn a little higher than the role text, without moving the card.
          Transform.translate(
            offset: Offset(0, -AppSizes.chatStatusLift),
            child: const _ActiveRequestStatus(),
          ),
        ] else ...[
          SizedBox(height: AppSizes.chatNameRoleGap),
          Text(
            conversation.participantRole,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ],
    );
  }
}

class _ActiveRequestStatus extends StatelessWidget {
  const _ActiveRequestStatus();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSizes.chatStatusDot,
          height: AppSizes.chatStatusDot,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.verifiedTagText,
          ),
        ),
        SizedBox(width: AppSizes.chatStatusDotGap),
        Text(
          AppStrings.activeRequest,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.verifiedTagText,
          ),
        ),
      ],
    );
  }
}

class _VerifiedTag extends StatelessWidget {
  const _VerifiedTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.chatTagHeight,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.chatTagPaddingH),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.verifiedTagBackground,
        borderRadius: BorderRadius.circular(AppSizes.chatTagRadius),
      ),
      child: Text(AppStrings.verifiedTag, style: AppTextStyles.verifiedTag),
    );
  }
}
