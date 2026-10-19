import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_bottom_sheet.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/app_search_field.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/features/requester/explore/view_models/explore_view_model.dart';
import 'package:pocketwrench/features/requester/explore/views/widgets/filter_bar.dart';
import 'package:pocketwrench/features/requester/explore/views/widgets/filters_sheet.dart';
import 'package:pocketwrench/features/requester/mechanics/views/widgets/mechanic_card.dart';

/// Explore tab body: search, filters and the suggested mechanics. Hosted by
/// the main shell, which provides the navigation bar.
class ExploreTab extends GetView<ExploreViewModel> {
  const ExploreTab({super.key});

  Future<void> _openFilters() {
    controller.beginEditingFilters();
    return AppBottomSheet.show<void>(
      title: AppStrings.filtersTitle,
      child: const FiltersSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topShift = math.max(
      0.0,
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
    );
    final horizontal = AppSizes.screenPaddingH;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: AppHelpers.unfocus,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSizes.authTitleTopRole + topShift,
              child: Stack(
                children: [
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontal),
              child: FadeSlideIn(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.heading(AppStrings.exploreTitle),
                    SizedBox(height: AppSizes.exploreTitleSearchGap),
                    AppSearchField(
                      controller: controller.searchController,
                      hint: AppStrings.searchHint,
                      onChanged: controller.onQueryChanged,
                    ),
                    SizedBox(height: AppSizes.exploreSearchChipsGap),
                    GetBuilder<ExploreViewModel>(
                      id: AppUpdateIds.exploreFilterBar,
                      builder: (vm) =>
                          FilterBar(filters: vm.applied, onTap: _openFilters),
                    ),
                    SizedBox(height: AppSizes.exploreChipsListGap),
                    GetBuilder<ExploreViewModel>(
                      id: AppUpdateIds.exploreList,
                      builder: (vm) => _MechanicList(viewModel: vm),
                    ),
                    SizedBox(height: AppSizes.homeBottomPadding),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MechanicList extends StatelessWidget {
  const _MechanicList({required this.viewModel});

  final ExploreViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final mechanics = viewModel.mechanics;

    if (viewModel.state == ViewState.error) {
      return AppEmptyState(
        title: AppStrings.genericError,
        actionLabel: AppStrings.retry,
        onAction: viewModel.load,
      );
    }
    if (viewModel.state != ViewState.success && mechanics.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spaceXL),
        child: const Center(child: AppLoader()),
      );
    }
    if (mechanics.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spaceXL),
        child: const AppEmptyState(
          title: AppStrings.noMechanicsTitle,
          message: AppStrings.noMechanicsMessage,
        ),
      );
    }

    return Column(
      children: [
        for (final mechanic in mechanics) ...[
          MechanicCard(
            mechanic: mechanic,
            isCompact: true,
            onTap: () => viewModel.onMechanicTap(mechanic),
          ),
          SizedBox(height: AppSizes.mechanicCardGap),
        ],
      ],
    );
  }
}
