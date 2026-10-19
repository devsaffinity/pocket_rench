import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/request_repository.dart';
import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';

enum RequestFilter { all, active, resolved }

/// The "My Requests" tab: the list with an All / Active / Resolved filter.
class RequestsViewModel extends GetxController {
  RequestsViewModel(this._repository, {required VoidCallback onBack})
    : _onBack = onBack;

  final RequestRepository _repository;
  final VoidCallback _onBack;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<HelpRequest> _requests = const [];
  int get totalCount => _requests.length;

  RequestFilter _filter = RequestFilter.all;
  RequestFilter get filter => _filter;

  List<HelpRequest> get visibleRequests => switch (_filter) {
    RequestFilter.all => _requests,
    RequestFilter.active => _requests.where((r) => !r.isResolved).toList(),
    RequestFilter.resolved => _requests.where((r) => r.isResolved).toList(),
  };

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.requestsList]);
    try {
      _requests = await _repository.loadRequests();
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.requestsList]);
  }

  void selectFilter(RequestFilter filter) {
    if (filter == _filter) return;
    _filter = filter;
    update([AppUpdateIds.requestsList]);
  }

  Future<void> onAdd() async {
    await Get.toNamed<void>(AppRoutes.newRequestDetails);
    // A request may have been sent.
    await load();
  }

  // A request's own screen is not designed yet.
  void onRequestTap(HelpRequest request) =>
      AppSnackbar.show(AppStrings.featureComingSoon);

  void onBack() => _onBack();
}
