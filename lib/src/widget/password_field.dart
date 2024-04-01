import 'package:flutter/material.dart';
import 'package:flutter_animated_login/src/utils/extension.dart';

import '../utils/password_config.dart';

class PasswordTextField extends StatelessWidget {
  final ValueNotifier<bool> isFormValidNotifier;
  final PasswordTextFiledConfig config;
  final TextEditingController controller;
  const PasswordTextField({
    super.key,
    required this.isFormValidNotifier,
    required this.config,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isObscure = ValueNotifier<bool>(true);
    return ValueListenableBuilder(
      valueListenable: isObscure,
      builder: (context, obscure, child) {
        return TextFormField(
          obscureText: obscure,
          controller: controller,
          onChanged: (value) {
            config.onChanged?.call(value);
          },
          onTap: config.onTap,
          onEditingComplete: config.onEditingComplete,
          onFieldSubmitted: config.onFieldSubmitted,
          onSaved: config.onSaved,
          validator: config.validator ??
              (value) {
                if (value.isEmptyOrNull) {
                  return 'Password is required';
                }
                return null;
              },
          inputFormatters: config.inputFormatters,
          enabled: config.enabled,
          cursorWidth: config.cursorWidth,
          cursorHeight: config.cursorHeight,
          cursorRadius: config.cursorRadius,
          cursorColor: config.cursorColor,
          cursorErrorColor: config.cursorErrorColor,
          keyboardAppearance: config.keyboardAppearance,
          scrollPadding: config.scrollPadding,
          enableInteractiveSelection: config.enableInteractiveSelection,
          selectionControls: config.selectionControls,
          buildCounter: config.buildCounter,
          scrollPhysics: config.scrollPhysics,
          autofillHints: config.autofillHints,
          autovalidateMode: config.autovalidateMode,
          scrollController: config.scrollController,
          restorationId: config.restorationId,
          focusNode: config.focusNode,
          decoration: config.decoration ??
              InputDecoration(
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => isObscure.value = !obscure,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
          keyboardType: config.keyboardType,
          textCapitalization: config.textCapitalization,
          textInputAction: config.textInputAction,
          style: config.style,
          strutStyle: config.strutStyle,
          textDirection: config.textDirection,
          textAlign: config.textAlign,
          textAlignVertical: config.textAlignVertical,
          autofocus: config.autofocus,
          readOnly: config.readOnly,
          showCursor: config.showCursor,
          obscuringCharacter: config.obscuringCharacter,
          autocorrect: config.autocorrect,
          canRequestFocus: config.canRequestFocus,
          clipBehavior: config.clipBehavior,
          contentInsertionConfiguration: config.contentInsertionConfiguration,
          contextMenuBuilder: config.contextMenuBuilder,
          cursorOpacityAnimates: config.cursorOpacityAnimates,
          dragStartBehavior: config.dragStartBehavior,
          enableIMEPersonalizedLearning: config.enableIMEPersonalizedLearning,
          enableSuggestions: config.enableSuggestions,
          expands: config.expands,
          magnifierConfiguration: config.magnifierConfiguration,
          maxLength: config.maxLength,
          maxLengthEnforcement: config.maxLengthEnforcement,
          maxLines: config.maxLines,
          minLines: config.minLines,
          mouseCursor: config.mouseCursor,
          onAppPrivateCommand: config.onAppPrivateCommand,
          onTapAlwaysCalled: config.onTapAlwaysCalled,
          onTapOutside: config.onTapOutside,
          scribbleEnabled: config.scribbleEnabled,
          selectionHeightStyle: config.selectionHeightStyle,
          selectionWidthStyle: config.selectionWidthStyle,
          smartDashesType: config.smartDashesType,
          smartQuotesType: config.smartQuotesType,
          spellCheckConfiguration: config.spellCheckConfiguration,
          statesController: config.statesController,
          undoController: config.undoController,
        );
      },
    );
  }
}
