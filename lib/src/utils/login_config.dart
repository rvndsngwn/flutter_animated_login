import 'package:flutter/material.dart';

class LoginConfig {
  final Widget? logo;
  final String? title;
  final String? subtitle;
  final Widget? buttonText;
  final TextStyle? buttonTextStyle;
  final String? termsAndConditions;
  final String? privacyPolicy;
  final String? footerText;
  final PhoneFiledConfig phoneFiledConfig;
  final EmailFiledConfig emailFiledConfig;

  const LoginConfig({
    this.logo,
    this.title,
    this.subtitle,
    this.buttonText,
    this.buttonTextStyle,
    this.termsAndConditions,
    this.privacyPolicy,
    this.footerText,
    this.phoneFiledConfig = const PhoneFiledConfig(),
    this.emailFiledConfig = const EmailFiledConfig(),
  });
}

class PhoneFiledConfig {
  final bool autofocus;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextStyle? dropdownTextStyle;
  final String? initialCountryCode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool disableLengthCheck;
  const PhoneFiledConfig({
    this.autofocus = true,
    this.decoration,
    this.style,
    this.dropdownTextStyle,
    this.initialCountryCode = 'IN',
    this.keyboardType,
    this.textInputAction,
    this.disableLengthCheck = false,
  });
}

class EmailFiledConfig {
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  const EmailFiledConfig({
    this.decoration,
    this.style,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.autofillHints,
  });
}
