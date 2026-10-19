import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/theme/app_system_ui.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/features/mechanic/requests/data/models/service_request.dart';
import 'package:pocketwrench/features/mechanic/requests/view_models/service_request_detail_view_model.dart';
import 'package:pocketwrench/features/mechanic/requests/views/widgets/request_tag.dart';
import 'package:pocketwrench/features/shared/requests/data/models/request_attachment.dart';

/// One request in full: what is wrong, the files sent, who asked, and the
/// actions that fit its status. Opened from the Requests tab or Home.
class ServiceRequestDetailView extends GetView<ServiceRequestDetailViewModel> {
  const ServiceRequestDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final topShift = math.max(
      0.0,
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.lightIcons,
      child: Scaffold(
        body: Stack(
          children: [
            GetBuilder<ServiceRequestDetailViewModel>(
              id: AppUpdateIds.serviceRequestDetail,
              builder: (vm) {
                final request = vm.request;
                if (vm.state == ViewState.error) {
                  return AppEmptyState(
                    title: AppStrings.genericError,
                    actionLabel: AppStrings.retry,
                    onAction: vm.load,
                  );
                }
                if (request == null) return const Center(child: AppLoader());

                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.screenPaddingH,
                    AppSizes.svcDetailTop + topShift,
                    AppSizes.screenPaddingH,
                    math.max(context.bottomInset, AppSizes.svcDetailBottom),
                  ),
                  child: FadeSlideIn(
                    child: _Content(request: request, viewModel: vm),
                  ),
                );
              },
            ),
            Positioned(
              left: AppSizes.authBackLeft,
              top: AppSizes.authBackTop + topShift,
              child: AppIconButton(
                svgPath: AppIcons.arrowLeft,
                size: AppSizes.iconBack,
                onPressed: controller.onBack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.request, required this.viewModel});

  final ServiceRequest request;
  final ServiceRequestDetailViewModel viewModel;

  String get _priorityLabel => switch (request.priority) {
    RequestPriority.urgent => AppStrings.urgencyUrgent,
    RequestPriority.important => AppStrings.priorityImportant,
    RequestPriority.normal => AppStrings.urgencyNormal,
  };

  @override
  Widget build(BuildContext context) {
    final attachments = request.request.attachments;
    final isUrgent = request.priority != RequestPriority.normal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: AppSizes.svcDetailTagGap),
                child: Text(request.title, style: AppTextStyles.detailTitle),
              ),
            ),
            request.status == ServiceStatus.resolved
                ? StatusTag.forRequest(request)
                : const StatusTag.active(),
          ],
        ),
        SizedBox(height: AppSizes.svcDetailSummaryGap),
        Text(request.request.summary, style: AppTextStyles.bodySmall),
        SizedBox(height: AppSizes.svcDetailChipsGap),
        Row(
          children: [
            _Chip(label: request.request.category),
            SizedBox(width: AppSizes.svcChipGap),
            _Chip(label: _priorityLabel, isUrgent: isUrgent),
          ],
        ),
        SizedBox(height: AppSizes.svcSectionGap),
        Text(AppStrings.descriptionLabel, style: AppTextStyles.onbLabel),
        SizedBox(height: AppSizes.svcLabelCardGap),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSizes.svcDescriptionPadding),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          child: Text(
            request.request.description,
            style: AppTextStyles.descriptionFull,
          ),
        ),
        if (attachments.isNotEmpty) ...[
          SizedBox(height: AppSizes.svcSectionGapLoose),
          Text(
            AppStrings.sectionAttachments(attachments.length),
            style: AppTextStyles.onbLabel,
          ),
          SizedBox(height: AppSizes.svcLabelThumbGap),
          Row(
            children: [
              for (var i = 0; i < attachments.length; i++) ...[
                if (i > 0) SizedBox(width: AppSizes.svcThumbGap),
                _Thumb(attachment: attachments[i]),
              ],
            ],
          ),
        ],
        SizedBox(height: AppSizes.svcSectionGapLoose),
        Text(AppStrings.requestedBy, style: AppTextStyles.onbLabel),
        SizedBox(height: AppSizes.svcLabelRequesterGap),
        _RequesterCard(request: request),
        _Actions(request: request, viewModel: viewModel),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, this.isUrgent = false});

  final String label;
  final bool isUrgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.svcChipHeight,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.svcChipPaddingH),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isUrgent ? AppColors.urgentChipBackground : AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.svcChipHeight / 2),
      ),
      child: Text(
        label,
        style: AppTextStyles.requestChip.copyWith(
          color: isUrgent ? AppColors.urgent : AppColors.textMuted,
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.attachment});

  final RequestAttachment attachment;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.svcThumbRadius);
    final url = attachment.previewUrl;

    if (url == null) {
      return Container(
        width: AppSizes.svcThumb,
        height: AppSizes.svcThumb,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: radius,
        ),
        child: AppImage(
          AppIcons.file,
          width: AppSizes.iconM,
          height: AppSizes.iconM,
          fit: BoxFit.contain,
          color: AppColors.textMuted,
        ),
      );
    }

    return SizedBox(
      width: AppSizes.svcThumb,
      height: AppSizes.svcThumb,
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppImage(url),
            if (attachment.kind == AttachmentKind.video)
              Center(
                child: AppImage(
                  AppIcons.play,
                  width: AppSizes.svcThumb / 2,
                  height: AppSizes.svcThumb / 2,
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

class _RequesterCard extends StatelessWidget {
  const _RequesterCard({required this.request});

  final ServiceRequest request;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.svcRequesterCardWidth,
      height: AppSizes.svcRequesterCardHeight,
      padding: EdgeInsets.all(AppSizes.svcRequesterCirclePadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.svcRequesterCircle,
            height: AppSizes.svcRequesterCircle,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
            ),
            child: Text(
              request.requesterInitials,
              style: AppTextStyles.requesterInitials,
            ),
          ),
          SizedBox(width: AppSizes.svcRequesterTextGap),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.requesterName,
                  style: AppTextStyles.itemTitle.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Text(request.requesterCity, style: AppTextStyles.requesterCity),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Decline and Accept while a request is pending; "Open Conversation" once it
/// is active; nothing when it is resolved.
class _Actions extends StatelessWidget {
  const _Actions({required this.request, required this.viewModel});

  final ServiceRequest request;
  final ServiceRequestDetailViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final children = switch (request.status) {
      ServiceStatus.pending => [
        AppButton(
          label: AppStrings.decline,
          variant: AppButtonVariant.text,
          height: AppSizes.svcDetailButtonHeight,
          textStyle: AppTextStyles.detailAction,
          isDisabled: viewModel.isResponding,
          onPressed: viewModel.onDecline,
        ),
        SizedBox(height: AppSizes.svcDetailButtonGap),
        AppButton(
          label: AppStrings.accept,
          backgroundColor: AppColors.logoAccent,
          textStyle: AppTextStyles.requestActionAccent,
          height: AppSizes.svcDetailButtonHeight,
          isLoading: viewModel.isResponding,
          onPressed: viewModel.onAccept,
        ),
      ],
      ServiceStatus.active => [
        AppButton(
          label: AppStrings.openConversation,
          backgroundColor: AppColors.logoAccent,
          textStyle: AppTextStyles.requestActionAccent,
          height: AppSizes.svcDetailButtonHeight,
          onPressed: viewModel.onOpenConversation,
        ),
      ],
      ServiceStatus.resolved => const <Widget>[],
    };
    if (children.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: AppSizes.svcButtonsTop),
      child: Column(children: children),
    );
  }
}
