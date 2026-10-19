import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/mechanic/requests/data/models/service_request.dart';
import 'package:pocketwrench/features/mechanic/requests/views/widgets/request_tag.dart';
import 'package:pocketwrench/features/shared/requests/views/widgets/request_status_icon.dart';

/// A request waiting for an answer, with Decline and Accept buttons. Shown on
/// Home and under "All" on the Requests tab.
class PendingRequestCard extends StatelessWidget {
  const PendingRequestCard({
    required this.request,
    required this.onTap,
    required this.onAccept,
    required this.onDecline,
    super.key,
    this.isBusy = false,
  });

  final ServiceRequest request;
  final VoidCallback onTap;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  /// True while a response is being sent; the buttons ignore taps.
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      request: request,
      onTap: onTap,
      children: [
        SizedBox(height: AppSizes.mechButtonsTop),
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                label: AppStrings.decline,
                color: AppColors.background,
                textStyle: AppTextStyles.requestAction,
                onTap: isBusy ? null : onDecline,
              ),
            ),
            SizedBox(width: AppSizes.mechButtonGap),
            Expanded(
              child: _ActionButton(
                label: AppStrings.accept,
                color: AppColors.logoAccent,
                textStyle: AppTextStyles.requestActionAccent,
                onTap: isBusy ? null : onAccept,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// An accepted request: who asked, their last message and a way into the chat.
class ActiveRequestCard extends StatelessWidget {
  const ActiveRequestCard({
    required this.request,
    required this.onTap,
    required this.onOpenConversation,
    super.key,
  });

  final ServiceRequest request;
  final VoidCallback onTap;
  final VoidCallback onOpenConversation;

  @override
  Widget build(BuildContext context) {
    final lastMessage = request.lastMessage;

    return _CardShell(
      request: request,
      onTap: onTap,
      showRequester: true,
      children: [
        if (lastMessage != null) ...[
          SizedBox(height: AppSizes.svcBoxTop),
          _LastMessageBox(text: lastMessage),
        ],
        SizedBox(
          height: lastMessage != null
              ? AppSizes.svcBoxButtonGap
              : AppSizes.mechButtonsTop,
        ),
        _ActionButton(
          label: AppStrings.openConversation,
          color: AppColors.logoAccent,
          textStyle: AppTextStyles.requestActionAccent,
          onTap: onOpenConversation,
        ),
      ],
    );
  }
}

/// A finished request: the summary and who asked.
class ResolvedRequestCard extends StatelessWidget {
  const ResolvedRequestCard({
    required this.request,
    required this.onTap,
    super.key,
  });

  final ServiceRequest request;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _CardShell(request: request, onTap: onTap, showRequester: true);
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({
    required this.request,
    required this.onTap,
    this.showRequester = false,
    this.children = const [],
  });

  final ServiceRequest request;
  final VoidCallback onTap;
  final bool showRequester;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          AppSizes.spaceM,
          AppSizes.spaceM,
          AppSizes.spaceM,
          // A card that ends on the requester line sits a touch tighter.
          showRequester && children.isEmpty
              ? AppSizes.svcResolvedBottom
              : AppSizes.spaceM,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RequestStatusIcon(
                  isResolved: request.status == ServiceStatus.resolved,
                ),
                const Spacer(),
                StatusTag.forRequest(request),
              ],
            ),
            SizedBox(height: AppSizes.mechCardIconTitleGap),
            Text(request.title, style: AppTextStyles.itemTitle),
            SizedBox(height: AppSizes.mechRequestTitleSubGap),
            Text(request.request.summary, style: AppTextStyles.bodySmall),
            if (showRequester) ...[
              SizedBox(height: AppSizes.svcRequesterGap),
              Text(
                AppStrings.requesterLine(request.requesterName),
                style: AppTextStyles.requesterLine,
              ),
            ],
            ...children,
          ],
        ),
      ),
    );
  }
}

class _LastMessageBox extends StatelessWidget {
  const _LastMessageBox({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: AppSizes.svcBoxHeight),
      padding: EdgeInsets.fromLTRB(
        AppSizes.svcBoxPaddingH,
        AppSizes.svcBoxPaddingTop,
        AppSizes.svcBoxPaddingH,
        AppSizes.svcBoxPaddingTop,
      ),
      decoration: BoxDecoration(
        color: AppColors.lastMessageBackground,
        borderRadius: BorderRadius.circular(AppSizes.radiusS),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.lastMessageLabel,
            style: AppTextStyles.lastMessageLabel,
          ),
          SizedBox(height: AppSizes.svcBoxLabelGap),
          Text(
            AppStrings.lastMessageQuote(text),
            style: AppTextStyles.lastMessageQuote,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.color,
    required this.textStyle,
    required this.onTap,
  });

  final String label;
  final Color color;
  final TextStyle textStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      haptic: true,
      child: Container(
        height: AppSizes.mechButtonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSizes.mechButtonRadius),
        ),
        child: Text(label, style: textStyle),
      ),
    );
  }
}
