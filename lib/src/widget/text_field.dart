import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

import '../utils/extension.dart';
import '../utils/login_config.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<bool> isPhoneNotifier;
  final ValueNotifier<bool> isFormValidNotifier;
  final TextFiledConfig config;
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.isPhoneNotifier,
    required this.isFormValidNotifier,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return ValueListenableBuilder(
      valueListenable: isPhoneNotifier,
      builder: (context, isPhone, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: IntlPhoneField(
            controller: controller,
            initialCountryCode: config.initialCountryCode ?? 'IN',
            disableLengthCheck: config.disableLengthCheck ?? !isPhone,
            inputFormatters: const [],
            prefixIcon: isPhone ? null : const SizedBox.shrink(),
            decoration: config.decoration ??
                InputDecoration(
                  hintText: isPhone ? 'Enter your phone' : 'Enter your email',
                  prefixIconConstraints: !isPhone
                      ? BoxConstraints.tight(const Size(10, 10))
                      : null,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
            style: config.style ??
                textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontSize: 20,
                ),
            dropdownTextStyle: config.dropdownTextStyle ??
                textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                ),
            onChanged: (phone) {
              print(phone.number);
              isFormValidNotifier.value =
                  isPhone ? phone.isValidNumber() : phone.number.isEmail;
            },
            keyboardType: config.keyboardType ?? TextInputType.emailAddress,
            textInputAction: config.textInputAction ?? TextInputAction.done,
          ),
        );
      },
    );
  }
}
