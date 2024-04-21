import 'package:flutter/material.dart';

import '../widget/title.dart';
import 'login_config.dart';

class ResetConfig {
  final Widget? logo;
  final Widget? header;
  final Widget? footer;
  final String? title;
  final String? subtitle;
  final TitleWidget? titleWidget;
  final Widget? resendButton;
  final TextStyle? buttonTextStyle;
  final EmailPhoneTextFiledConfig textFiledConfig;

  const ResetConfig({
    this.logo,
    this.header,
    this.footer,
    this.title,
    this.subtitle,
    this.titleWidget,
    this.resendButton,
    this.buttonTextStyle,
    this.textFiledConfig = const EmailPhoneTextFiledConfig(),
  });

  ResetConfig copyWith({
    Widget? logo,
    Widget? header,
    Widget? footer,
    String? title,
    String? subtitle,
    TitleWidget? titleWidget,
    Widget? resendButton,
    TextStyle? buttonTextStyle,
    EmailPhoneTextFiledConfig? textFiledConfig,
  }) {
    return ResetConfig(
      logo: logo ?? this.logo,
      header: header ?? this.header,
      footer: footer ?? this.footer,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      titleWidget: titleWidget ?? this.titleWidget,
      resendButton: resendButton ?? this.resendButton,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      textFiledConfig: textFiledConfig ?? this.textFiledConfig,
    );
  }
}
