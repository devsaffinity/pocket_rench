import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/features/shared/messages/view_models/chat_view_model.dart';

/// Voice note recorder: title, live waveform, timer, Cancel and Send Voice.
class RecordingSheet extends StatelessWidget {
  const RecordingSheet({super.key});

  static String _format(int seconds) {
    final minutes = seconds ~/ 60;
    final rest = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$rest';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatViewModel>(
      id: AppUpdateIds.chatRecording,
      builder: (vm) => Column(
        children: [
          SizedBox(height: AppSizes.recordingTitleTop),
          const _Title(),
          SizedBox(height: AppSizes.recordingTitleWaveGap),
          _Waveform(levels: vm.waveLevels),
          SizedBox(height: AppSizes.recordingWaveTimerGap),
          Text(
            _format(vm.recordingSeconds),
            style: AppTextStyles.recordingTimer,
          ),
          SizedBox(height: AppSizes.recordingTimerButtonsGap),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: AppStrings.cancel,
                  variant: AppButtonVariant.secondary,
                  height: AppSizes.buttonHeightSecondary,
                  backgroundColor: AppColors.background,
                  textStyle: AppTextStyles.buttonSmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                  onPressed: vm.onCancelRecording,
                ),
              ),
              SizedBox(width: AppSizes.recordingButtonGap),
              Expanded(
                child: AppButton(
                  label: AppStrings.sendVoice,
                  height: AppSizes.buttonHeightSecondary,
                  backgroundColor: AppColors.logoAccent,
                  textStyle: AppTextStyles.buttonSmall,
                  onPressed: vm.onSendVoice,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSizes.recordingBottom - AppSizes.sheetBottomPadding,
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: AppSizes.recordingDot,
          height: AppSizes.recordingDot,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.recording,
          ),
        ),
        SizedBox(width: AppSizes.recordingDotGap),
        Text(
          AppStrings.recordingTitle,
          style: AppTextStyles.itemTitle.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}

class _Waveform extends StatelessWidget {
  const _Waveform({required this.levels});

  final List<double> levels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.waveMaxHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < levels.length; i++) ...[
            if (i > 0) SizedBox(width: AppSizes.waveBarGap),
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: AppSizes.waveBarWidth,
              height: AppSizes.waveMaxHeight * levels[i],
              decoration: BoxDecoration(
                color: AppColors.logoAccent,
                borderRadius: BorderRadius.circular(AppSizes.waveBarWidth / 2),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
