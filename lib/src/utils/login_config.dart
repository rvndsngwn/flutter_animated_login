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
  final TextFiledConfig textFiledConfig;

  const LoginConfig({
    this.logo,
    this.title,
    this.subtitle,
    this.buttonText,
    this.buttonTextStyle,
    this.termsAndConditions,
    this.privacyPolicy,
    this.footerText,
    this.textFiledConfig = const TextFiledConfig(),
  });
}

class TextFiledConfig {
  final bool autofocus;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextStyle? dropdownTextStyle;
  final String? initialCountryCode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? disableLengthCheck;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  const TextFiledConfig({
    this.autofocus = false,
    this.decoration,
    this.style,
    this.dropdownTextStyle,
    this.initialCountryCode = 'IN',
    this.keyboardType,
    this.textInputAction,
    this.disableLengthCheck,
    this.autofillHints,
    this.validator,
  });
}
