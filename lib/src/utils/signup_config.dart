import 'package:flutter/material.dart';

import '../../flutter_animated_login.dart';

class SignupConfig {
  final Widget? logo;
  final Widget? header;
  final Widget? footer;
  final String? title;
  final String? subtitle;
  final TitleWidget? titleWidget;
  final Widget? resendButton;
  final TextStyle? buttonTextStyle;
  final EmailPhoneTextFiledConfig textFiledConfig;
  final PasswordTextFiledConfig passwordTextFiledConfig;

  const SignupConfig({
    this.logo,
    this.header,
    this.footer,
    this.title,
    this.subtitle,
    this.titleWidget,
    this.resendButton,
    this.buttonTextStyle,
    this.textFiledConfig = const EmailPhoneTextFiledConfig(),
    this.passwordTextFiledConfig = const PasswordTextFiledConfig(),
  });

  SignupConfig copyWith({
    Widget? logo,
    Widget? header,
    Widget? footer,
    String? title,
    String? subtitle,
    TitleWidget? titleWidget,
    Widget? resendButton,
    TextStyle? buttonTextStyle,
    EmailPhoneTextFiledConfig? textFiledConfig,
    PasswordTextFiledConfig? passwordTextFiledConfig,
  }) {
    return SignupConfig(
      logo: logo ?? this.logo,
      header: header ?? this.header,
      footer: footer ?? this.footer,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      titleWidget: titleWidget ?? this.titleWidget,
      resendButton: resendButton ?? this.resendButton,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      textFiledConfig: textFiledConfig ?? this.textFiledConfig,
      passwordTextFiledConfig:
          passwordTextFiledConfig ?? this.passwordTextFiledConfig,
    );
  }
}
