import 'package:flutter/material.dart';

import 'login.dart';
import 'utils/extension.dart';
import 'utils/login_config.dart';
import 'utils/reset_config.dart';
import 'widget/button.dart';
import 'widget/email_phone_field.dart';
import 'widget/page.dart';
import 'widget/title.dart';

class FlutterAnimatedReset extends StatelessWidget {
  final ResetConfig config;
  final LoginConfig loginConfig;
  final LoginType loginType;
  final TextEditingController controller;
  final EmailPhoneTextFiledConfig textConfig;
  const FlutterAnimatedReset({
    super.key,
    required this.config,
    required this.loginConfig,
    required this.loginType,
    required this.controller,
    required this.textConfig,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return PageWidget(
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          config.header ??
              config.titleWidget ??
              TitleWidget(
                title: config.title ?? 'Reset Account Password',
                titleStyle: textTheme.titleLarge,
                subtitle: config.subtitle ??
                    "We'll send you a link to reset your account password.",
                subtitleStyle: textTheme.titleMedium,
                titleGap: const SizedBox(height: 6),
                child: config.logo ??
                    Icon(
                      Icons.password,
                      size: 100,
                      color: theme.colorScheme.secondary,
                    ),
              ),
          EmailPhoneTextField(
            controller: controller,
            config: textConfig,
          ),
          const SizedBox(height: 40),
          SignInButton(
            onPressed: () async {
              return null;
            },
            config: loginConfig.copyWith(
              buttonText: const Text('Reset'),
            ),
            constraints: constraints,
            loginType: loginType,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => nextPageNotifier.value = 0,
            style: TextButton.styleFrom(
              textStyle: config.buttonTextStyle ?? textTheme.titleLarge,
            ),
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
