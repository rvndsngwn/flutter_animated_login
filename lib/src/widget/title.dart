import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_login/src/utils/extension.dart';

class TitleWidget extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? child;
  final Widget? titleGap;
  final void Function()? onTap;
  const TitleWidget({
    super.key,
    this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.child = const FlutterLogo(size: 100),
    this.titleGap = const SizedBox(height: 20),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
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
          Text.rich(
            TextSpan(
              text: subtitle ?? "",
              style: subtitleStyle ?? textTheme.headlineSmall,
              children: [
                if (onTap != null)
                  TextSpan(
                    text: ' Edit',
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTap,
                  ),
              ],
            ),
          ),
        if (title.isNotEmptyOrNull &&
            titleGap.isNotNull &&
            subtitle.isNotEmptyOrNull)
          const SizedBox(height: 40),
      ],
    );
  }
}
