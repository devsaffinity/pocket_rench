import 'dart:async';

import 'package:get/get.dart';
import 'package:pocketwrench/features/mechanic/home/view_models/mechanic_home_view_model.dart';
import 'package:pocketwrench/features/mechanic/requests/data/repositories/service_request_repository.dart';
import 'package:pocketwrench/features/mechanic/requests/view_models/service_request_detail_view_model.dart';
import 'package:pocketwrench/features/mechanic/requests/view_models/service_requests_view_model.dart';

class ServiceRequestDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceRequestDetailViewModel>(
      () => ServiceRequestDetailViewModel(
        Get.find<ServiceRequestRepository>(),
        // A response changes both the Requests tab and Home.
        onChanged: () {
          unawaited(Get.find<ServiceRequestsViewModel>().load());
          unawaited(Get.find<MechanicHomeViewModel>().load());
        },
      ),
    );
  }
}
