import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';
import 'package:toastification/toastification.dart';

import '../utils/login_provider.dart';
import 'divider.dart';

class OAuthWidget extends StatelessWidget {
  final List<LoginProvider>? providers;
  const OAuthWidget({
    super.key,
    this.providers,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        if (providers != null) ...[
          const SizedBox(height: 20),
          const DividerText(),
          const SizedBox(height: 20),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: providers?.map((provider) {
                final index = providers?.indexOf(provider);
                return Padding(
                  padding: EdgeInsets.only(
                      right: (index == (providers?.length ?? 0) - 1) ? 0 : 10),
                  child: Column(
                    children: [
                      IconAutoLoadingButton.filled(
                        onPressed: () async {
                          final result = await provider.callback.call();
                          if (result != null && context.mounted) {
                            toastification.show(
                              context: context,
                              title: Text(result),
                              type: ToastificationType.error,
                            );
                          }
                        },
                        key: Key(provider.label ??
                            providers!.indexOf(provider).toString()),
                        tooltip: 'Sign in with ${provider.label}',
                        icon: Icon(provider.icon),
                      ),
                      if (provider.label != null) Text(provider.label ?? ""),
                    ],
                  ),
                );
              }).toList() ??
              [],
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
