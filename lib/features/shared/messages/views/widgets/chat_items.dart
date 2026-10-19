import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_item.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_perspective.dart';

/// Renders any [ChatItem], aligned to the right for the signed-in person's
/// messages and to the left for received ones.
class ChatItemView extends StatelessWidget {
  const ChatItemView({
    required this.item,
    super.key,
    this.perspective = ChatPerspective.requester,
  });

  final ChatItem item;
  final ChatPerspective perspective;

  bool get _isMechanic => perspective == ChatPerspective.mechanic;

  @override
  Widget build(BuildContext context) {
    final item = this.item;
    return switch (item) {
      TimeSeparator() => Center(
        child: Text(item.label, style: AppTextStyles.dropCaption),
      ),
      TextMessage() => _aligned(
        item,
        _TextBubble(
          text: item.text,
          isMine: item.isMine,
          perspective: perspective,
        ),
      ),
      ImageMessage() => _aligned(
        item,
        _MediaBubble(imageUrl: item.url, perspective: perspective),
      ),
      VideoMessage() => _aligned(
        item,
        _MediaBubble(
          imageUrl: item.thumbnailUrl,
          isVideo: true,
          perspective: perspective,
        ),
      ),
    };
  }

  Widget _aligned(ChatMessage message, Widget child) => Align(
    alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.only(
        right: _isMechanic && message.isMine
            ? AppSizes.chatMechanicOutgoingInset
            : 0,
      ),
      child: child,
    ),
  );
}

class _TextBubble extends StatelessWidget {
  const _TextBubble({
    required this.text,
    required this.isMine,
    required this.perspective,
  });

  final String text;
  final bool isMine;
  final ChatPerspective perspective;

  @override
  Widget build(BuildContext context) {
    final round = Radius.circular(AppSizes.chatBubbleRadius);
    final tail = Radius.circular(AppSizes.chatBubbleTailRadius);

    final isMechanic = perspective == ChatPerspective.mechanic;

    return Container(
      // The mechanic's bubbles are always drawn at full width.
      constraints: BoxConstraints(
        minWidth: isMechanic ? AppSizes.chatBubbleMaxWidth : 0,
        maxWidth: AppSizes.chatBubbleMaxWidth,
      ),
      padding: EdgeInsets.all(AppSizes.chatBubblePadding),
      decoration: BoxDecoration(
        color: isMine
            ? AppColors.logoAccent
            : isMechanic
            ? AppColors.surface
            : AppColors.bubbleIncoming,
        borderRadius: BorderRadius.only(
          topLeft: round,
          topRight: round,
          bottomLeft: isMine ? round : tail,
          bottomRight: isMine ? tail : round,
        ),
      ),
      child: Text(
        text,
        style: isMine
            ? AppTextStyles.bubbleOutgoing
            : AppTextStyles.bubbleIncoming,
      ),
    );
  }
}

class _MediaBubble extends StatelessWidget {
  const _MediaBubble({
    required this.imageUrl,
    required this.perspective,
    this.isVideo = false,
  });

  final String imageUrl;
  final bool isVideo;
  final ChatPerspective perspective;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.chatBubbleRadius);

    final isMechanic = perspective == ChatPerspective.mechanic;

    return Container(
      width: isMechanic
          ? AppSizes.chatMechanicMediaWidth
          : AppSizes.chatMediaWidth,
      height: isMechanic
          ? AppSizes.chatMechanicMediaHeight
          : AppSizes.chatMediaHeight,
      padding: EdgeInsets.all(AppSizes.chatMediaBorder),
      decoration: BoxDecoration(
        color: isMechanic ? AppColors.surface : AppColors.bubbleIncoming,
        borderRadius: radius,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppSizes.chatBubbleRadius - AppSizes.chatMediaBorder,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppImage(imageUrl),
            if (isVideo)
              Center(
                child: AppImage(
                  AppIcons.play,
                  width: AppSizes.chatPlayIcon,
                  height: AppSizes.chatPlayIcon,
                  fit: BoxFit.contain,
                  color: AppColors.logoAccent,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
