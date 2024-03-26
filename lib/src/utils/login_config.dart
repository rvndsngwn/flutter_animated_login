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
  final PhoneTextFiled phoneTextFiled;
  final EmailTextFiled emailTextFiled;

  const LoginConfig({
    this.logo,
    this.title,
    this.subtitle = 'Let\'s Sign In',
    this.buttonText,
    this.buttonTextStyle,
    this.termsAndConditions,
    this.privacyPolicy,
    this.footerText,
    this.phoneTextFiled = const PhoneTextFiled(),
    this.emailTextFiled = const EmailTextFiled(),
  });
}

class PhoneTextFiled {
  final bool autofocus;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextStyle? dropdownTextStyle;
  final String? initialCountryCode;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  const PhoneTextFiled({
    this.autofocus = true,
    this.decoration,
    this.style,
    this.dropdownTextStyle,
    this.initialCountryCode = 'IN',
    this.keyboardType = const TextInputType.numberWithOptions(
      signed: true,
      decimal: false,
    ),
    this.textInputAction,
  });
}

class EmailTextFiled {
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  const EmailTextFiled({
    this.decoration,
    this.style,
    this.keyboardType = TextInputType.emailAddress,
    this.textInputAction,
    this.validator,
    this.autofillHints,
  });
}
