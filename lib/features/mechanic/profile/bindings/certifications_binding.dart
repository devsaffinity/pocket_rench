import 'package:get/get.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/repositories/document_picker.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/repositories/mock_document_picker.dart';
import 'package:pocketwrench/features/mechanic/profile/data/repositories/mechanic_profile_repository.dart';
import 'package:pocketwrench/features/mechanic/profile/view_models/certifications_view_model.dart';

class CertificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentPicker>(MockDocumentPicker.new);
    Get.lazyPut<CertificationsViewModel>(
      () => CertificationsViewModel(
        Get.find<MechanicProfileRepository>(),
        Get.find<DocumentPicker>(),
      ),
    );
  }
}
