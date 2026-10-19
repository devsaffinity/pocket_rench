import 'dart:async';

import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/professional_profile.dart';
import 'package:pocketwrench/features/mechanic/profile/data/repositories/mechanic_profile_repository.dart';
import 'package:pocketwrench/features/shared/profile/data/models/account.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';

/// The mechanic's professional profile, read-only, with a way to edit it.
class ProfessionalProfileViewModel extends GetxController {
  ProfessionalProfileViewModel(this._repository, this._accountRepository);

  final MechanicProfileRepository _repository;
  final AccountRepository _accountRepository;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  ProfessionalProfile? _profile;
  ProfessionalProfile? get profile => _profile;

  Account? _account;
  Account? get account => _account;

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.professionalProfile]);
    try {
      _account = await _accountRepository.loadAccount();
      _profile = await _repository.loadProfessionalProfile();
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.professionalProfile]);
  }

  /// "Edit Profile" opens the account editor; the name may change there.
  Future<void> onEditProfile() async {
    await Get.toNamed<void>(AppRoutes.editProfile);
    await load();
  }

  /// Changing the photo needs an image picker package, which is not approved.
  void onChangePhoto() => AppSnackbar.show(AppStrings.photoPickerUnavailable);

  void onBack() => Get.back<void>();
}
