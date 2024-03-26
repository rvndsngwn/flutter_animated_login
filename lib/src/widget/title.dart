import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? child;
  final Widget? titleGap;
  const TitleWidget({
    super.key,
    this.title = 'Mohesu Enterprise',
    this.subtitle = 'Let\'s Sign In',
    this.titleStyle,
    this.subtitleStyle,
    this.child = const FlutterLogo(size: 100),
    this.titleGap = const SizedBox(height: 20),
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        child ?? const SizedBox.shrink(),
        const SizedBox(height: 20),
        if (title != null)
          Text(
            title!,
            style: titleStyle ?? textTheme.headlineMedium,
          ),
        if (titleGap != null) titleGap!,
        if (subtitle != null)
          Text(
            subtitle!,
            style: subtitleStyle ?? textTheme.titleLarge,
          ),
        if (title != null && titleGap != null && subtitle != null)
          const SizedBox(height: 40),
      ],
    );
  }
}
