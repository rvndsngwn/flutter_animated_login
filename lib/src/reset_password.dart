import 'package:flutter/material.dart';

import 'login.dart';
import 'utils/extension.dart';
import 'utils/login_config.dart';
import 'utils/page_config.dart';
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
  final PageConfig pageConfig;
  final ResetPasswordCallback? onResetPassword;
  const FlutterAnimatedReset({
    super.key,
    required this.config,
    required this.loginConfig,
    required this.loginType,
    required this.controller,
    required this.pageConfig,
    this.onResetPassword,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return PageWidget(
      config: pageConfig,
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
            config: config.textFiledConfig,
          ),
          const SizedBox(height: 40),
          SignInButton(
            onPressed: () async {
              if (onResetPassword != null) {
                final isValid = formKey.currentState?.validate() ?? false;
                if (!isValid) {
                  context.error(
                    "Error",
                    description: "Invalid form data, fill all required fields",
                  );
                  return null;
                }
                final result = await onResetPassword?.call(controller.text);
                if (context.mounted) {
                  if (result.isNotEmptyOrNull) {
                    context.error("Error", description: result);
                  } else {
                    context.success(
                      "Success",
                      description: "Password reset link sent successfully",
                    );
                    nextPageNotifier.value = 0;
                  }
                }
              }
              return null;
            },
            config: loginConfig.copyWith(
              buttonText: const Text('Reset Password'),
            ),
            constraints: constraints,
            loginType: loginType,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => nextPageNotifier.value = 0,
            style: TextButton.styleFrom(
              textStyle: config.buttonTextStyle ?? textTheme.titleMedium,
            ),
            child: const Text('Sign In'),
          ),
          config.footer.orShrink,
        ],
      ),
    );
  }
}
