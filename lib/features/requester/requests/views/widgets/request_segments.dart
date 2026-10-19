import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/widgets/app_segmented_control.dart';
import 'package:pocketwrench/features/requester/requests/view_models/requests_view_model.dart';

/// "All / Active / Resolved" switch for the requester's requests.
class RequestSegments extends StatelessWidget {
  const RequestSegments({
    required this.filter,
    required this.totalCount,
    required this.onChanged,
    super.key,
  });

  final RequestFilter filter;
  final int totalCount;
  final ValueChanged<RequestFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppSegmentedControl(
      labels: [
        AppStrings.requestsAll(totalCount),
        AppStrings.requestsActive,
        AppStrings.requestsResolved,
      ],
      selectedIndex: RequestFilter.values.indexOf(filter),
      onChanged: (index) => onChanged(RequestFilter.values[index]),
    );
  }
}
