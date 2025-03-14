import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../flutter_animated_login.dart';
import '../utils/extension.dart';

class EmailPhoneTextField extends StatelessWidget {
  final EmailPhoneTextFiledConfig config;
  final TextFieldController controller;
  final FormMessages formMessages;
  final LoginFieldInputType loginFieldInputType;

  const EmailPhoneTextField({
    super.key,
    required this.config,
    required this.controller,
    required this.formMessages,
    required this.loginFieldInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Watch.builder(
      builder: (context) {
        bool isPhone;

        switch (loginFieldInputType) {
          case LoginFieldInputType.phoneOrEmail:
            isPhone = isPhoneNotifier.value;
            break;
          case LoginFieldInputType.email:
            isPhone = false;
            break;
          case LoginFieldInputType.phone:
            isPhone = true;
            break;
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: IntlPhoneField(
            controller: controller,
            initialCountryCode: config.initialCountryCode ?? 'IN',
            disableLengthCheck: !isPhone,
            inputFormatters: config.inputFormatters ?? const [],
            prefixIcon: isPhone ? null : const SizedBox.shrink(),
            decoration: config.decoration ??
                InputDecoration(
                  hintText: isPhone
                      ? formMessages.loginFieldEnterPhone
                      : formMessages.loginFieldEnterEmailOrPhone,
                  labelText:
                      isPhone ? formMessages.phone : formMessages.emailOrPhone,
                  prefixIconConstraints: !isPhone
                      ? BoxConstraints.tight(const Size(10, 10))
                      : null,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  counter: const SizedBox.shrink(),
                ),
            style: config.style,
            dropdownTextStyle: config.dropdownTextStyle ?? config.style,
            onChanged: (phone) {
              isFormValidNotifier.value =
                  isPhone ? phone.isValidNumber() : phone.number.isEmail;
              config.onChanged?.call((
                number: phone,
                value: phone.number,
              ));
              usernameNotifier.value = phone;
            },
            onCountryChanged: config.onCountryChanged,
            obscureText: config.obscureText,
            onSubmitted: config.onSubmitted,
            onTap: config.onTap,
            onEditingComplete: config.onEditingComplete,
            onSaved: (phone) {
              if (phone == null) return;
              isFormValidNotifier.value =
                  isPhone ? phone.isValidNumber() : phone.number.isEmail;
              config.onSaved?.call((
                number: phone,
                value: phone.number,
              ));
              usernameNotifier.value = phone;
            },
            keyboardType: config.keyboardType ?? TextInputType.emailAddress,
            textInputAction: config.textInputAction ?? TextInputAction.next,
            autofillHints: config.autofillHints ??
                [
                  AutofillHints.email,
                  AutofillHints.telephoneNumber,
                  AutofillHints.telephoneNumberNational,
                ],
            focusNode: config.focusNode,
            autofocus: config.autofocus,
            autovalidateMode: config.autovalidateMode,
            buildCounter: config.buildCounter,
            countries: config.countries,
            cursorColor: config.cursorColor,
            cursorWidth: config.cursorWidth,
            cursorHeight: config.cursorHeight,
            cursorRadius: config.cursorRadius,
            dialogType: config.dialogType,
            enabled: config.enabled,
            dropdownDecoration: config.dropdownDecoration,
            dropdownIcon: config.dropdownIcon,
            dropdownIconPosition: config.dropdownIconPosition,
            expands: config.expands,
            maxLength: config.maxLength,
            flagsButtonMargin: config.flagsButtonMargin,
            flagsButtonPadding: config.flagsButtonPadding,
            formFieldKey: config.formFieldKey,
            initialValue: config.initialValue,
            invalidMessage: config.invalidMessage,
            keyboardAppearance: config.keyboardAppearance,
            languageCode: config.languageCode,
            magnifierConfiguration: config.magnifierConfiguration,
            maxLengthEnforcement: config.maxLengthEnforcement,
            maxLines: config.maxLines,
            minLines: config.minLines,
            pickerDialogStyle: config.pickerDialogStyle,
            readOnly: config.readOnly,
            showCountryFlag: config.showCountryFlag,
            showCursor: config.showCursor,
            showDropdownIcon: config.showDropdownIcon,
            textAlign: config.textAlign,
            textAlignVertical: config.textAlignVertical,
            validator: isPhone
                ? null
                : (value) {
                    final userInput = value?.number ?? "";
                    if (userInput.isEmptyOrNull && value != null) {
                      return formMessages.loginFieldEnterPhoneValidatorEmpty;
                    } else if (!(userInput.isEmail) &&
                        !(userInput.isIntlPhoneNumber)) {
                      return formMessages.loginFieldEnterPhoneValidatorInvalid;
                    }
                    return null;
                  },
          ),
        );
      },
    );
  }
}
