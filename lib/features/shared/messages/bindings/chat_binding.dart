import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/message_repository.dart';
import 'package:pocketwrench/features/shared/messages/view_models/chat_view_model.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatViewModel>(
      () => ChatViewModel(Get.find<MessageRepository>()),
    );
  }
}
