import 'package:get/get.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/attachment_picker.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/mock_attachment_picker.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/request_repository.dart';
import 'package:pocketwrench/features/requester/requests/view_models/new_request_view_model.dart';

/// Shared by the three steps. The first step creates the ViewModel; later
/// steps reuse it, so the draft survives going back and forth.
class NewRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttachmentPicker>(MockAttachmentPicker.new);
    Get.lazyPut<NewRequestViewModel>(
      () => NewRequestViewModel(
        Get.find<RequestRepository>(),
        Get.find<AttachmentPicker>(),
      ),
    );
  }
}
