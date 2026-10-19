import 'dart:async';

import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/verification.dart';
import 'package:pocketwrench/features/mechanic/profile/data/repositories/mechanic_profile_repository.dart';

/// Whether the mechanic's documents are verified or still under review.
class VerificationStatusViewModel extends GetxController {
  VerificationStatusViewModel(this._repository);

  final MechanicProfileRepository _repository;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  Verification? _verification;
  Verification? get verification => _verification;

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.verificationStatus]);
    try {
      _verification = await _repository.loadVerification();
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.verificationStatus]);
  }

  void onBack() => Get.back<void>();
}
