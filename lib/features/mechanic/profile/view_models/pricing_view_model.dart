import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/pricing.dart';
import 'package:pocketwrench/features/mechanic/profile/data/repositories/mechanic_profile_repository.dart';

/// Service pricing: switch tiers on and off, add a custom tier, set the
/// minimum charge. "Save Changes" stores the lot.
class PricingViewModel extends GetxController {
  PricingViewModel(this._repository);

  final MechanicProfileRepository _repository;

  final TextEditingController tierNameController = TextEditingController();
  final TextEditingController tierPriceController = TextEditingController();
  final TextEditingController tierDescriptionController =
      TextEditingController();
  final TextEditingController minimumController = TextEditingController();

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  PricingPlan? _plan;
  PricingPlan? get plan => _plan;

  String? _tierNameError;
  String? get tierNameError => _tierNameError;
  String? _tierPriceError;
  String? get tierPriceError => _tierPriceError;
  String? _minimumError;
  String? get minimumError => _minimumError;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  int _customTiers = 0;

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  @override
  void onClose() {
    AppHelpers.disposeAfterFrame([
      tierNameController,
      tierPriceController,
      tierDescriptionController,
      minimumController,
    ]);
    super.onClose();
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.pricingTiers]);
    try {
      _plan = await _repository.loadPricing();
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.pricingTiers]);
  }

  static int? _parsePrice(String text) {
    final value = int.tryParse(text.replaceAll(RegExp(r'[^0-9]'), ''));
    return value == null || value <= 0 ? null : value;
  }

  void toggleTier(String id) {
    final plan = _plan;
    if (plan == null) return;
    _plan = PricingPlan(
      minimumCharge: plan.minimumCharge,
      tiers: [
        for (final tier in plan.tiers)
          if (tier.id == id)
            tier.copyWith(isEnabled: !tier.isEnabled)
          else
            tier,
      ],
    );
    update([AppUpdateIds.pricingTiers]);
  }

  /// Clears the "new tier" form before it opens.
  void prepareNewTier() {
    tierNameController.clear();
    tierPriceController.clear();
    tierDescriptionController.clear();
    _tierNameError = null;
    _tierPriceError = null;
  }

  /// Adds the tier typed into the form. Returns false (and shows the errors)
  /// when it is not valid yet.
  bool addTier() {
    final plan = _plan;
    final name = tierNameController.text.trim();
    final price = _parsePrice(tierPriceController.text);
    _tierNameError = name.isEmpty ? AppStrings.fieldRequired : null;
    _tierPriceError = price == null ? AppStrings.priceInvalid : null;
    update([AppUpdateIds.pricingTiers]);
    if (plan == null || _tierNameError != null || price == null) return false;

    _plan = PricingPlan(
      minimumCharge: plan.minimumCharge,
      tiers: [
        ...plan.tiers,
        PricingTier(
          id: 'custom-${_customTiers++}',
          name: name,
          price: price,
          description: tierDescriptionController.text.trim(),
        ),
      ],
    );
    update([AppUpdateIds.pricingTiers]);
    return true;
  }

  /// Fills the "minimum fee" form with the current value.
  void prepareMinimum() {
    minimumController.text = '${_plan?.minimumCharge ?? ''}';
    _minimumError = null;
  }

  /// Applies the minimum typed into the form. Returns false when invalid.
  bool setMinimum() {
    final plan = _plan;
    final price = _parsePrice(minimumController.text);
    _minimumError = price == null ? AppStrings.priceInvalid : null;
    update([AppUpdateIds.pricingTiers]);
    if (plan == null || price == null) return false;

    _plan = PricingPlan(tiers: plan.tiers, minimumCharge: price);
    update([AppUpdateIds.pricingTiers]);
    return true;
  }

  Future<void> onSave() async {
    final plan = _plan;
    if (_isSaving || plan == null) return;

    _isSaving = true;
    update([AppUpdateIds.pricingSubmit]);
    try {
      await _repository.savePricing(plan);
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
      return;
    } finally {
      _isSaving = false;
      update([AppUpdateIds.pricingSubmit]);
    }

    // Leave first: Get.back() would close an open snackbar instead.
    Get.back<void>();
    AppSnackbar.show(AppStrings.pricingSaved, type: AppSnackbarType.success);
  }

  void onBack() => Get.back<void>();
}
