import 'dart:async';

import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_profile.dart';
import 'package:pocketwrench/features/requester/mechanics/data/repositories/mechanic_repository.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/request_repository.dart';
import 'package:pocketwrench/features/shared/messages/data/models/chat_args.dart';
import 'package:pocketwrench/features/shared/messages/data/models/support_request.dart';

class MechanicProfileViewModel extends GetxController {
  MechanicProfileViewModel(this._repository, this._requestRepository);

  final MechanicRepository _repository;
  final RequestRepository _requestRepository;

  String _mechanicId = '';

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  MechanicProfile? _profile;
  MechanicProfile? get profile => _profile;

  List<SupportRequest> _requests = const [];
  List<SupportRequest> get requests => _requests;

  String? _selectedRequestId;
  String? get selectedRequestId => _selectedRequestId;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is String) _mechanicId = arguments;
    unawaited(load());
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.profileBody]);
    try {
      final profileFuture = _repository.loadProfile(_mechanicId);
      final requestsFuture = _requestRepository.loadRequests();
      _profile = await profileFuture;
      _requests = [
        for (final request in await requestsFuture)
          if (!request.isResolved)
            SupportRequest(
              id: request.id,
              title: request.title,
              details: request.shortSummary,
            ),
      ];
      _selectedRequestId = _requests.isEmpty ? null : _requests.first.id;
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.profileBody]);
  }

  void selectRequest(String id) {
    _selectedRequestId = id;
    update([AppUpdateIds.contactRequests]);
  }

  Future<void> onContinueToConversation() async {
    final profile = _profile;
    if (profile == null) return;

    final selected = _requests.where((r) => r.id == _selectedRequestId);
    Get.back<void>();
    await Get.toNamed<void>(
      AppRoutes.chat,
      arguments: ChatArgs.mechanic(
        profile.mechanic,
        request: selected.isEmpty ? null : selected.first,
      ),
    );
  }

  // Creating a support request is not designed yet.
  void onCreateSupportRequest() {
    Get.back<void>();
    AppSnackbar.show(AppStrings.featureComingSoon);
  }

  void onMore() => AppSnackbar.show(AppStrings.featureComingSoon);

  void onBack() => Get.back<void>();
}
