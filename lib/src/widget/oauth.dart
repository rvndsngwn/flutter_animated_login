import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';

import 'divider.dart';

class OAuthWidget extends StatelessWidget {
  final Future<void> Function()? onPressed;
  const OAuthWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 20),
        const DividerText(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconAutoLoadingButton.filled(
              onPressed: onPressed,
              icon: const Icon(Icons.apple),
            ),
            const SizedBox(width: 20),
            IconAutoLoadingButton.filled(
              onPressed: onPressed,
              icon: const Icon(Icons.facebook),
            ),
            const SizedBox(width: 20),
            IconAutoLoadingButton.filled(
              onPressed: onPressed,
              icon: const Icon(Icons.flutter_dash),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            text: 'By signing in, you agree to the ',
            children: [
              TextSpan(
                text: 'Terms and policy',
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => print('Terms and policy'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => print('Powered by MOHESU'),
          child: const Text('Powered by MOHESU'),
        ),
      ],
    );
  }
}
