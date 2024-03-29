import 'package:flutter/material.dart';
import 'package:flutter_animated_login/src/utils/extension.dart';

class TitleWidget extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? child;
  final Widget? titleGap;
  const TitleWidget({
    super.key,
    this.title,
    this.subtitle,
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
        child.orShrink,
        const SizedBox(height: 20),
        if (title.isNotEmptyOrNull)
          Text(
            title ?? "",
            style: titleStyle ?? textTheme.headlineMedium,
          ),
        titleGap.orShrink,
        if (subtitle.isNotEmptyOrNull)
          Text(
            subtitle ?? "",
            style: subtitleStyle ?? textTheme.titleLarge,
          ),
        if (title.isNotEmptyOrNull &&
            titleGap.isNotNull &&
            subtitle.isNotEmptyOrNull)
          const SizedBox(height: 40),
      ],
    );
  }
}
