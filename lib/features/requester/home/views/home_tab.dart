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
import 'package:pocketwrench/features/requester/home/data/models/home_data.dart';
import 'package:pocketwrench/features/requester/home/view_models/home_view_model.dart';
import 'package:pocketwrench/features/requester/home/views/widgets/requests_header.dart';
import 'package:pocketwrench/features/requester/mechanics/views/widgets/mechanic_card.dart';
import 'package:pocketwrench/features/requester/requests/views/widgets/request_card.dart';
import 'package:pocketwrench/features/shared/home/views/widgets/home_header.dart';
import 'package:pocketwrench/features/shared/home/views/widgets/promo_banner.dart';

/// Home tab body. Hosted by the main shell, which provides the navigation bar.
class HomeTab extends GetView<HomeViewModel> {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      id: AppUpdateIds.homeBody,
      builder: (vm) {
        final data = vm.data;
        if (vm.state == ViewState.error) {
          return AppEmptyState(
            title: AppStrings.genericError,
            actionLabel: AppStrings.retry,
            onAction: vm.load,
          );
        }
        final user = vm.user;
        if (data == null || user == null) {
          return const Center(child: AppLoader());
        }
        return _HomeContent(data: data, user: user, viewModel: vm);
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.data,
    required this.user,
    required this.viewModel,
  });

  final HomeData data;
  final HomeUser user;
  final HomeViewModel viewModel;

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
              name: user.name,
              avatar: user.avatar,
              onBellTap: viewModel.onBellTap,
            ),
            SizedBox(height: AppSizes.homeHeaderBannerGap),
            PromoBanner(
              title: AppStrings.bannerTitle,
              body: AppStrings.bannerBody,
              buttonLabel: AppStrings.findAMechanic,
              imagePath: AppImages.homeBanner,
              onPressed: viewModel.onFindMechanic,
            ),
            SizedBox(height: AppSizes.homeSectionGap),
            Text(AppStrings.findMechanics, style: AppTextStyles.sectionTitle),
            SizedBox(height: AppSizes.homeTitleCardGap),
            for (final mechanic in data.mechanics) ...[
              MechanicCard(
                mechanic: mechanic,
                onTap: () => viewModel.onMechanicTap(mechanic),
              ),
              SizedBox(height: AppSizes.mechanicCardGap),
            ],
            SizedBox(height: AppSizes.seeAllTop - AppSizes.mechanicCardGap),
            Align(
              alignment: Alignment.centerRight,
              child: TapScale(
                onTap: viewModel.onSeeAll,
                child: Text(AppStrings.seeAll, style: AppTextStyles.link),
              ),
            ),
            SizedBox(height: AppSizes.seeAllRequestsGap),
            RequestsHeader(onAdd: viewModel.onAddRequest),
            SizedBox(height: AppSizes.requestsRowCardGap),
            for (final request in viewModel.requests) ...[
              RequestCard(
                request: request,
                onTap: () => viewModel.onRequestTap(request),
              ),
              SizedBox(height: AppSizes.mechanicCardGap),
            ],
          ],
        ),
      ),
    );
  }
}
