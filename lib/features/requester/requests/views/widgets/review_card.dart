import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/requester/requests/data/models/request_draft.dart';
import 'package:pocketwrench/features/requester/requests/views/widgets/attachment_widgets.dart';
import 'package:pocketwrench/features/shared/requests/views/widgets/urgency_tag.dart';

/// Everything entered, grouped into sections with "Edit" links.
class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.draft,
    required this.onEditDetails,
    required this.onEditFiles,
    required this.onViewDescription,
    super.key,
  });

  final RequestDraft draft;
  final VoidCallback onEditDetails;
  final VoidCallback onEditFiles;

  /// Opens the full description; the card only shows the first lines.
  final VoidCallback onViewDescription;

  @override
  Widget build(BuildContext context) {
    final vehicle = [
      '${draft.year} ${draft.make} ${draft.model}',
      if (draft.engine != null) draft.engine!,
    ].join(' • ');

    final sections = <Widget>[
      _Section(
        title: AppStrings.sectionTitleCategory,
        onEdit: onEditDetails,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(draft.title, style: AppTextStyles.bodySmall),
            SizedBox(height: AppSizes.reviewChipTopGap),
            _CategoryTag(label: (draft.category ?? '').toUpperCase()),
          ],
        ),
      ),
      _Section(
        title: AppStrings.sectionVehicle,
        onEdit: onEditDetails,
        child: Text(vehicle, style: AppTextStyles.bodySmall),
      ),
      _Section(
        title: AppStrings.sectionUrgency,
        onEdit: onEditDetails,
        child: Align(
          alignment: Alignment.centerLeft,
          child: UrgencyTag(
            urgency: draft.urgency,
            height: AppSizes.reviewUrgencyHeight,
            textStyle: AppTextStyles.tagLabel,
            horizontalPadding: AppSizes.categoryTagPaddingH,
          ),
        ),
      ),
      if (draft.description.trim().isNotEmpty)
        _Section(
          title: AppStrings.sectionDescription,
          onEdit: onEditDetails,
          child: TapScale(
            onTap: onViewDescription,
            child: Text(
              draft.description,
              maxLines: AppSizes.reviewDescriptionLines,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.reviewBody,
            ),
          ),
        ),
      if (draft.attachments.isNotEmpty)
        _Section(
          title: AppStrings.sectionAttachments(draft.attachments.length),
          onEdit: onEditFiles,
          child: Wrap(
            spacing: AppSizes.reviewThumbGap,
            runSpacing: AppSizes.reviewThumbGap,
            children: [
              for (final file in draft.attachments)
                AttachmentThumb(attachment: file, size: AppSizes.reviewThumb),
            ],
          ),
        ),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.reviewPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Column(
        children: [
          for (var i = 0; i < sections.length; i++) ...[
            if (i > 0) ...[
              SizedBox(height: AppSizes.reviewDividerGapAbove),
              Container(height: AppSizes.hairline, color: AppColors.border),
              SizedBox(height: AppSizes.reviewDividerGap),
            ],
            sections[i],
          ],
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.onEdit,
    required this.child,
  });

  final String title;
  final VoidCallback onEdit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: AppTextStyles.rowTitle)),
            TapScale(
              onTap: onEdit,
              child: Text(AppStrings.edit, style: AppTextStyles.editLink),
            ),
          ],
        ),
        SizedBox(height: AppSizes.reviewHeaderContentGap),
        SizedBox(width: double.infinity, child: child),
      ],
    );
  }
}

class _CategoryTag extends StatelessWidget {
  const _CategoryTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.categoryTagHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.categoryTag,
          borderRadius: BorderRadius.circular(AppSizes.categoryTagRadius),
        ),
        child: Center(
          widthFactor: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.categoryTagPaddingH,
            ),
            child: Text(label, style: AppTextStyles.tagLabel),
          ),
        ),
      ),
    );
  }
}
