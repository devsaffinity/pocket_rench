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
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/app_pill_button.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/features/requester/requests/view_models/requests_view_model.dart';
import 'package:pocketwrench/features/requester/requests/views/widgets/request_card.dart';
import 'package:pocketwrench/features/requester/requests/views/widgets/request_segments.dart';

/// "My Requests" tab body. Hosted by the main shell.
class RequestsTab extends GetView<RequestsViewModel> {
  const RequestsTab({super.key});

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
            child: GetBuilder<RequestsViewModel>(
              id: AppUpdateIds.requestsList,
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

  final RequestsViewModel viewModel;

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
          title: AppStrings.noRequestsTitle,
          message: AppStrings.noRequestsMessage,
        ),
      );
    } else {
      list = Column(
        children: [
          for (final request in requests) ...[
            RequestCard(
              request: request,
              onTap: () => viewModel.onRequestTap(request),
            ),
            SizedBox(height: AppSizes.requestListGap),
          ],
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSizes.requestsRowHeight,
          child: Row(
            children: [
              Expanded(child: AppText.heading(AppStrings.requestsTitle)),
              AppPillButton(
                label: AppStrings.add,
                onPressed: viewModel.onAdd,
                height: AppSizes.requestsRowHeight,
                horizontalPadding: AppSizes.requestsAddPaddingH,
                textStyle: AppTextStyles.pillLarge,
                leading: Padding(
                  padding: EdgeInsets.only(right: AppSizes.requestsAddGap),
                  child: AppImage(
                    AppIcons.plus,
                    width: AppSizes.requestsAddIcon,
                    height: AppSizes.requestsAddIcon,
                    fit: BoxFit.contain,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.requestsSegmentTop),
        RequestSegments(
          filter: viewModel.filter,
          totalCount: viewModel.totalCount,
          onChanged: viewModel.selectFilter,
        ),
        SizedBox(height: AppSizes.segmentListGap),
        list,
      ],
    );
  }
}
