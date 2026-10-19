import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/requester/home/data/models/home_data.dart';
import 'package:pocketwrench/features/requester/home/data/repositories/home_repository.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/request_repository.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';
import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';

class HomeViewModel extends GetxController {
  HomeViewModel(
    this._repository,
    this._requestRepository,
    this._accountRepository, {
    required VoidCallback onOpenExplore,
    required VoidCallback onOpenRequests,
  }) : _onOpenExplore = onOpenExplore,
       _onOpenRequests = onOpenRequests;

  final HomeRepository _repository;
  final RequestRepository _requestRepository;
  final AccountRepository _accountRepository;
  final VoidCallback _onOpenExplore;
  final VoidCallback _onOpenRequests;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  HomeData? _data;
  HomeData? get data => _data;

  HomeUser? _user;
  HomeUser? get user => _user;

  List<HelpRequest> _requests = const [];
  List<HelpRequest> get requests => _requests;

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.homeBody]);
    try {
      _data = await _repository.loadHome();
      _requests = await _requestRepository.loadRequests();
      final account = await _accountRepository.loadAccount();
      _user = HomeUser(name: account.name, avatar: account.avatarUrl);
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.homeBody]);
  }

  // The destinations below are not designed yet.
  void onBellTap() => _comingSoon();
  void onFindMechanic() => _onOpenExplore();
  void onSeeAll() => _onOpenExplore();
  Future<void> onAddRequest() async {
    await Get.toNamed<void>(AppRoutes.newRequestDetails);
    await load();
  }

  Future<void> onMechanicTap(Mechanic mechanic) async {
    await Get.toNamed<void>(AppRoutes.mechanicProfile, arguments: mechanic.id);
  }

  void onRequestTap(HelpRequest request) => _onOpenRequests();

  void _comingSoon() => AppSnackbar.show(AppStrings.featureComingSoon);
}
