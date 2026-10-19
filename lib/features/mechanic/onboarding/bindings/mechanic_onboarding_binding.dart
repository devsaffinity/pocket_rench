import 'package:get/get.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/repositories/document_picker.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/repositories/mechanic_onboarding_repository.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/repositories/mock_document_picker.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/repositories/mock_mechanic_onboarding_repository.dart';
import 'package:pocketwrench/features/mechanic/onboarding/view_models/mechanic_onboarding_view_model.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';

/// Shared by the five onboarding steps. The first step creates the
/// ViewModel; later steps reuse it, so answers survive going back and forth.
class MechanicOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MechanicOnboardingRepository>(
      MockMechanicOnboardingRepository.new,
    );
    Get.lazyPut<DocumentPicker>(MockDocumentPicker.new);
    Get.lazyPut<MechanicOnboardingViewModel>(
      () => MechanicOnboardingViewModel(
        Get.find<MechanicOnboardingRepository>(),
        Get.find<AccountRepository>(),
        Get.find<DocumentPicker>(),
      ),
    );
  }
}
