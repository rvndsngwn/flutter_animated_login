import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String subtitle;
  final TextStyle? subtitleStyle;
  final Widget child;
  final Widget titleGap;
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
        child,
        const SizedBox(height: 20),
        Text(
          title,
          style: titleStyle ?? textTheme.displaySmall,
        ),
        titleGap,
        Text(
          subtitle,
          style: subtitleStyle ?? textTheme.titleLarge,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
