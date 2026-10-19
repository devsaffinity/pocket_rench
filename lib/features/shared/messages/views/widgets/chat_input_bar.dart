import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/shared/messages/view_models/chat_view_model.dart';

/// Bottom bar: attach button, message field, and a mic (or send, once there
/// is text).
class ChatInputBar extends StatelessWidget {
  const ChatInputBar({required this.onAdd, required this.onMic, super.key});

  final VoidCallback onAdd;
  final VoidCallback onMic;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.chatInputLeft,
          AppSizes.chatInputTop,
          AppSizes.chatInputRight,
          math.max(context.bottomInset, AppSizes.chatInputBottom),
        ),
        child: GetBuilder<ChatViewModel>(
          id: AppUpdateIds.chatInput,
          builder: (vm) => Row(
            children: [
              _AddButton(onTap: onAdd),
              SizedBox(width: AppSizes.chatInputGap),
              Expanded(child: _MessageField(viewModel: vm)),
              SizedBox(width: AppSizes.chatMicGap),
              TapScale(
                onTap: vm.hasText ? vm.send : onMic,
                haptic: true,
                child: AppImage(
                  vm.hasText ? AppIcons.send : AppIcons.mic,
                  width: AppSizes.chatMicIcon,
                  height: AppSizes.chatMicIcon,
                  fit: BoxFit.contain,
                  color: vm.hasText
                      ? AppColors.logoAccent
                      : AppColors.textSubtle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      haptic: true,
      child: Container(
        width: AppSizes.chatAddButton,
        height: AppSizes.chatAddButton,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.surface,
        ),
        child: AppImage(
          AppIcons.plus,
          width: AppSizes.chatAddIcon,
          height: AppSizes.chatAddIcon,
          fit: BoxFit.contain,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _MessageField extends StatelessWidget {
  const _MessageField({required this.viewModel});

  final ChatViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.chatFieldHeight,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spaceM),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.chatFieldHeight / 2),
      ),
      child: TextField(
        controller: viewModel.inputController,
        focusNode: viewModel.inputFocus,
        textInputAction: TextInputAction.send,
        onSubmitted: (_) => viewModel.send(),
        style: AppTextStyles.input,
        cursorColor: AppColors.primary,
        decoration: InputDecoration.collapsed(
          hintText: AppStrings.writeMessage,
          hintStyle: AppTextStyles.hint,
        ),
      ),
    );
  }
}
