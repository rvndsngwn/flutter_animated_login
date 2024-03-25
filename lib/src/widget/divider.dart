import 'package:flutter/material.dart';

class DividerText extends StatelessWidget {
  final Widget? child;
  const DividerText({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Row(
      children: [
        const Expanded(
          child: Divider(
            endIndent: 10,
          ),
        ),
        child ??
            Text(
              'OR',
              style: textTheme.labelMedium?.copyWith(
                color: theme.dividerColor,
              ),
            ),
        const Expanded(
          child: Divider(
            indent: 10,
          ),
        ),
      ],
    );
  }
}
