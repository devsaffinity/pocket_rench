import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_images.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/mechanic/home/data/models/mechanic_home_data.dart';
import 'package:pocketwrench/features/mechanic/home/view_models/mechanic_home_view_model.dart';
import 'package:pocketwrench/features/mechanic/home/views/widgets/home_widgets.dart';
import 'package:pocketwrench/features/mechanic/requests/views/widgets/request_cards.dart';
import 'package:pocketwrench/features/shared/home/views/widgets/home_header.dart';
import 'package:pocketwrench/features/shared/home/views/widgets/promo_banner.dart';
import 'package:pocketwrench/features/shared/profile/data/models/account.dart';

/// The mechanic's Home tab body. Hosted by the mechanic shell, which provides
/// the navigation bar.
class MechanicHomeTab extends GetView<MechanicHomeViewModel> {
  const MechanicHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MechanicHomeViewModel>(
      id: AppUpdateIds.mechanicHomeBody,
      builder: (vm) {
        final data = vm.data;
        final account = vm.account;
        if (vm.state == ViewState.error) {
          return AppEmptyState(
            title: AppStrings.genericError,
            actionLabel: AppStrings.retry,
            onAction: vm.load,
          );
        }
        if (data == null || account == null) {
          return const Center(child: AppLoader());
        }
        return _Content(data: data, account: account, viewModel: vm);
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.data,
    required this.account,
    required this.viewModel,
  });

  final MechanicHomeData data;
  final Account account;
  final MechanicHomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final top = math.max(
      context.topInset + AppSizes.spaceS + AppSizes.spaceXS,
      AppSizes.homeTop,
    );

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        AppSizes.homePaddingLeft,
        top,
        AppSizes.homePaddingRight,
        AppSizes.homeBottomPadding,
      ),
      child: FadeSlideIn(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
              name: account.name,
              avatar: account.avatarUrl,
              onBellTap: viewModel.onBellTap,
            ),
            SizedBox(height: AppSizes.homeHeaderBannerGap),
            PromoBanner(
              title: AppStrings.visibilityTitle,
              body: AppStrings.visibilityBody,
              buttonLabel: AppStrings.upgradeNow,
              imagePath: AppImages.mechanicBanner,
              fadeImageEdge: true,
              wrapTextBesideImage: true,
              onPressed: viewModel.onUpgrade,
            ),
            SizedBox(height: AppSizes.mechSectionTop),
            Text(AppStrings.yourActivity, style: AppTextStyles.itemTitle),
            SizedBox(height: AppSizes.mechTitleCardGap),
            Row(
              children: [
                Expanded(
                  child: ActivityStatCard(
                    value: '${data.stats.requestsHelped}',
                    label: AppStrings.requestsHelped,
                  ),
                ),
                SizedBox(width: AppSizes.mechStatGap),
                Expanded(
                  child: ActivityStatCard(
                    value: data.stats.helpfulRating.toStringAsFixed(1),
                    label: AppStrings.helpfulRating,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.mechRequestsTop),
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.myRequests,
                    style: AppTextStyles.sectionTitle,
                  ),
                ),
                TapScale(
                  onTap: viewModel.onSeeAll,
                  child: Text(AppStrings.seeAll, style: AppTextStyles.link),
                ),
              ],
            ),
            SizedBox(height: AppSizes.mechRequestsTitleGap),
            if (viewModel.requests.isEmpty)
              const AppEmptyState(
                title: AppStrings.noRequestsTitle,
                message: AppStrings.noRequestsMessage,
              )
            else
              for (final request in viewModel.requests) ...[
                PendingRequestCard(
                  request: request,
                  isBusy: viewModel.isResponding(request.id),
                  onTap: () => viewModel.onRequestTap(request),
                  onAccept: () => viewModel.onAccept(request),
                  onDecline: () => viewModel.onDecline(request),
                ),
                SizedBox(height: AppSizes.mechanicCardGap),
              ],
          ],
        ),
      ),
    );
  }
}
