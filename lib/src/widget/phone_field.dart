import 'package:flutter/material.dart';
import 'package:flutter_animated_login/flutter_animated_login.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:universal_io/io.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<bool> isFormValidNotifier;
  final PhoneFiledConfig phoneConfig;
  const PhoneField({
    super.key,
    required this.controller,
    required this.isFormValidNotifier,
    required this.phoneConfig,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return IntlPhoneField(
      controller: controller,
      autofocus: phoneConfig.autofocus,
      decoration: phoneConfig.decoration ??
          const InputDecoration(
            hintText: 'Enter your phone',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
      style: phoneConfig.style ??
          textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.secondary,
            fontSize: 20,
          ),
      dropdownTextStyle: phoneConfig.dropdownTextStyle ??
          textTheme.titleLarge?.copyWith(
            fontSize: 20,
          ),
      initialCountryCode: phoneConfig.initialCountryCode ?? 'IN',
      initialValue: controller.text,
      disableLengthCheck: phoneConfig.disableLengthCheck,
      onChanged: (phone) {
        print(phone.completeNumber);
        isFormValidNotifier.value = phone.isValidNumber();
      },
      keyboardType: phoneConfig.keyboardType ??
          (Platform.isAndroid
              ? TextInputType.visiblePassword
              : const TextInputType.numberWithOptions()),
      textInputAction: phoneConfig.textInputAction ?? TextInputAction.done,
    );
  }
}
