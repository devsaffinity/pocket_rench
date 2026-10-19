import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/shared/messages/data/models/conversation.dart';

/// One conversation in the list: avatar, name, last message, time and unread
/// count.
class ConversationCard extends StatelessWidget {
  const ConversationCard({
    required this.conversation,
    required this.onTap,
    super.key,
  });

  final Conversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.convCardPaddingH,
          vertical: AppSizes.convCardPaddingV,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Row(
          children: [
            AppImage(
              conversation.avatar,
              width: AppSizes.homeAvatar,
              height: AppSizes.homeAvatar,
              borderRadius: BorderRadius.circular(AppSizes.homeAvatar),
            ),
            SizedBox(width: AppSizes.convAvatarGap),
            Expanded(child: _TextColumn(conversation: conversation)),
            SizedBox(width: AppSizes.spaceS),
            _MetaColumn(conversation: conversation),
          ],
        ),
      ),
    );
  }
}

class _TextColumn extends StatelessWidget {
  const _TextColumn({required this.conversation});

  final Conversation conversation;

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
                style: AppTextStyles.mechanicName,
              ),
            ),
            if (conversation.isVerified) ...[
              SizedBox(width: AppSizes.mechanicBadgeGap),
              AppImage(
                AppIcons.verified,
                width: AppSizes.mechanicBadgeSize,
                height: AppSizes.mechanicBadgeSize,
                fit: BoxFit.contain,
              ),
            ],
          ],
        ),
        SizedBox(height: AppSizes.convNameMessageGap),
        Text(
          conversation.lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bubbleIncoming,
        ),
      ],
    );
  }
}

/// Time at the top, unread badge level with the message line.
class _MetaColumn extends StatelessWidget {
  const _MetaColumn({required this.conversation});

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppSizes.convTimeTop),
          child: Text(conversation.timeLabel, style: AppTextStyles.bodySmall),
        ),
        SizedBox(height: AppSizes.spaceXS),
        if (conversation.hasUnread)
          _UnreadBadge(count: conversation.unreadCount)
        else
          SizedBox(height: AppSizes.convBadge),
      ],
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: AppSizes.convBadge),
      height: AppSizes.convBadge,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spaceXS),
      decoration: BoxDecoration(
        color: AppColors.logoAccent,
        borderRadius: BorderRadius.circular(AppSizes.convBadge / 2),
      ),
      child: Text('$count', style: AppTextStyles.unreadCount),
    );
  }
}
