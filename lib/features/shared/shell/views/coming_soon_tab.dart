import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';

/// Body for a tab whose screen is not designed yet.
class ComingSoonTab extends StatelessWidget {
  const ComingSoonTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: AppEmptyState(
        title: AppStrings.comingSoonTitle,
        message: AppStrings.comingSoonMessage,
      ),
    );
  }
}
