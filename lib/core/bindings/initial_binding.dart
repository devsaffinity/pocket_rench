import 'package:get/get.dart';
import 'package:pocketwrench/features/requester/mechanics/data/repositories/mechanic_repository.dart';
import 'package:pocketwrench/features/requester/mechanics/data/repositories/mock_mechanic_repository.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/mock_request_repository.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/request_repository.dart';
import 'package:pocketwrench/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:pocketwrench/features/shared/auth/data/repositories/mock_auth_repository.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/message_repository.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/mock_message_repository.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/mock_account_repository.dart';

/// App-wide dependencies. Feature-specific view models belong in each
/// feature's binding. Repositories shared by several screens live here and are
/// recreated on demand (`fenix`) if a route disposes them.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(MockAuthRepository.new, fenix: true);
    Get.lazyPut<MechanicRepository>(MockMechanicRepository.new, fenix: true);
    // The two mocks below switch to the mechanic's sample data when the mechanic
    // shell opens, so they must not be disposed and rebuilt with a route.
    Get.put<MessageRepository>(MockMessageRepository(), permanent: true);
    Get.lazyPut<RequestRepository>(MockRequestRepository.new, fenix: true);
    Get.put<AccountRepository>(MockAccountRepository(), permanent: true);
  }
}
