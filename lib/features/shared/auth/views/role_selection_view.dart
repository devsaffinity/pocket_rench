import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/features/shared/auth/data/models/user_role.dart';
import 'package:pocketwrench/features/shared/auth/view_models/role_selection_view_model.dart';
import 'package:pocketwrench/features/shared/auth/views/widgets/role_card.dart';

class RoleSelectionView extends GetView<RoleSelectionViewModel> {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.roleTitle,
      subtitle: AppStrings.roleSubtitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.authBodyGapCards,
      onBack: controller.onBack,
      body: GetBuilder<RoleSelectionViewModel>(
        id: AppUpdateIds.roleCards,
        builder: (vm) => Column(
          children: [
            RoleCard(
              iconPath: AppIcons.search,
              title: AppStrings.roleHelpTitle,
              description: AppStrings.roleHelpDescription,
              isSelected: vm.selectedRole == UserRole.vehicleOwner,
              onTap: () => vm.selectRole(UserRole.vehicleOwner),
            ),
            SizedBox(height: AppSizes.roleCardGap),
            RoleCard(
              iconPath: AppIcons.wrench,
              title: AppStrings.roleMechanicTitle,
              description: AppStrings.roleMechanicDescription,
              isSelected: vm.selectedRole == UserRole.mechanic,
              onTap: () => vm.selectRole(UserRole.mechanic),
            ),
          ],
        ),
      ),
      bottom: AppButton(
        label: AppStrings.continueLabel,
        height: AppSizes.buttonHeightTall,
        onPressed: controller.onContinue,
      ),
    );
  }
}
