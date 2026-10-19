import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_filters.dart';
import 'package:pocketwrench/features/requester/mechanics/data/repositories/mechanic_repository.dart';

/// Mechanic search, filters and the suggested list.
class ExploreViewModel extends GetxController {
  ExploreViewModel(this._repository, {required VoidCallback onBack})
    : _onBack = onBack;

  static const Duration _searchDebounce = Duration(milliseconds: 300);

  final MechanicRepository _repository;
  final VoidCallback _onBack;

  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<Mechanic> _mechanics = const [];
  List<Mechanic> get mechanics => _mechanics;

  /// Filters currently applied to the list.
  MechanicFilters _applied = const MechanicFilters();
  MechanicFilters get applied => _applied;

  /// Filters being edited in the sheet; committed by [applyFilters].
  MechanicFilters _draft = const MechanicFilters();
  MechanicFilters get draft => _draft;

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  @override
  void onClose() {
    _debounce?.cancel();
    AppHelpers.disposeAfterFrame([searchController]);
    super.onClose();
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.exploreList]);
    try {
      _mechanics = await _repository.searchMechanics(
        query: searchController.text,
        filters: _applied,
      );
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.exploreList]);
  }

  void onQueryChanged(String _) {
    _debounce?.cancel();
    _debounce = Timer(_searchDebounce, () => unawaited(load()));
  }

  // Filters sheet

  /// Starts a new edit from the filters that are applied now.
  void beginEditingFilters() {
    _draft = _applied;
    update([AppUpdateIds.exploreSheet]);
  }

  void toggleSpecialty(Specialty specialty) {
    final next = {..._draft.specialties};
    if (!next.remove(specialty)) next.add(specialty);
    _draft = _draft.copyWith(specialties: next);
    update([AppUpdateIds.exploreSheet]);
  }

  void setNearMe({required bool value}) {
    _draft = _draft.copyWith(nearMe: value);
    update([AppUpdateIds.exploreSheet]);
  }

  void setExperience(ExperienceRange range) {
    _draft = _draft.copyWith(experience: range);
    update([AppUpdateIds.exploreSheet]);
  }

  void setPrice(PriceRange range) {
    _draft = _draft.copyWith(price: range);
    update([AppUpdateIds.exploreSheet]);
  }

  void setVerifiedOnly({required bool value}) {
    _draft = _draft.copyWith(verifiedOnly: value);
    update([AppUpdateIds.exploreSheet]);
  }

  Future<void> applyFilters() async {
    _applied = _draft;
    update([AppUpdateIds.exploreFilterBar]);
    Get.back<void>();
    await load();
  }

  Future<void> onMechanicTap(Mechanic mechanic) async {
    await Get.toNamed<void>(AppRoutes.mechanicProfile, arguments: mechanic.id);
  }

  void onBack() => _onBack();
}
