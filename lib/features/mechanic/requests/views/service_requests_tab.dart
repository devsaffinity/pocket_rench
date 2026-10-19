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
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/app_segmented_control.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/features/mechanic/requests/data/models/service_request.dart';
import 'package:pocketwrench/features/mechanic/requests/view_models/service_requests_view_model.dart';
import 'package:pocketwrench/features/mechanic/requests/views/widgets/request_cards.dart';

/// The mechanic's "Service Requests" tab: requests waiting for an answer
/// (All), accepted ones (Active) and finished ones (Resolved).
class ServiceRequestsTab extends GetView<ServiceRequestsViewModel> {
  const ServiceRequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final topShift = math.max(
      0.0,
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
    );

    return Stack(
      children: [
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(
            top: AppSizes.authTitleTopRole + topShift,
            left: AppSizes.screenPaddingH,
            right: AppSizes.screenPaddingH,
            bottom: AppSizes.homeBottomPadding,
          ),
          child: FadeSlideIn(
            child: GetBuilder<ServiceRequestsViewModel>(
              id: AppUpdateIds.serviceRequestsList,
              builder: (vm) => _Content(viewModel: vm),
            ),
          ),
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
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.viewModel});

  final ServiceRequestsViewModel viewModel;

  Widget _card(ServiceRequest request) {
    Future<void> onTap() => viewModel.onRequestTap(request);
    return switch (request.status) {
      ServiceStatus.pending => PendingRequestCard(
        request: request,
        isBusy: viewModel.isResponding(request.id),
        onTap: onTap,
        onAccept: () => viewModel.onAccept(request),
        onDecline: () => viewModel.onDecline(request),
      ),
      ServiceStatus.active => ActiveRequestCard(
        request: request,
        onTap: onTap,
        onOpenConversation: () => viewModel.onOpenConversation(request),
      ),
      ServiceStatus.resolved => ResolvedRequestCard(
        request: request,
        onTap: onTap,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final requests = viewModel.visibleRequests;

    Widget list;
    if (viewModel.state == ViewState.error) {
      list = AppEmptyState(
        title: AppStrings.genericError,
        actionLabel: AppStrings.retry,
        onAction: viewModel.load,
      );
    } else if (viewModel.state != ViewState.success) {
      list = Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spaceXL),
        child: const Center(child: AppLoader()),
      );
    } else if (requests.isEmpty) {
      list = Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spaceXL),
        child: const AppEmptyState(
          title: AppStrings.noServiceRequestsTitle,
          message: AppStrings.noServiceRequestsMessage,
        ),
      );
    } else {
      list = Column(
        children: [
          for (final request in requests) ...[
            _card(request),
            SizedBox(height: AppSizes.mechanicCardGap),
          ],
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.heading(AppStrings.serviceRequestsTitle),
        SizedBox(height: AppSizes.exploreTitleSearchGap),
        AppSegmentedControl(
          labels: [
            AppStrings.requestsAll(viewModel.pendingCount),
            AppStrings.requestsActive,
            AppStrings.requestsResolved,
          ],
          selectedIndex: ServiceFilter.values.indexOf(viewModel.filter),
          onChanged: (index) =>
              viewModel.selectFilter(ServiceFilter.values[index]),
          pillColor: AppColors.accent,
          selectedLabelStyle: AppTextStyles.segmentLabelSelected.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSizes.segmentListGap),
        list,
      ],
    );
  }
}
