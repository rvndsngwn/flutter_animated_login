import 'package:flutter/material.dart';
import 'package:flutter_animated_login/src/login.dart';

import 'utils/extension.dart';
import 'utils/login_config.dart';
import 'utils/page_config.dart';
import 'utils/signup_config.dart';
import 'widget/button.dart';
import 'widget/email_phone_field.dart';
import 'widget/page.dart';
import 'widget/password_field.dart';
import 'widget/title.dart';

class FlutterAnimatedSignup extends StatelessWidget {
  final LoginConfig loginConfig;
  final LoginType loginType;
  final TextEditingController controller;
  final TextEditingController passwordController;
  final PageConfig pageConfig;
  final SignupConfig config;
  FlutterAnimatedSignup({
    super.key,
    required this.loginConfig,
    required this.loginType,
    required this.controller,
    required this.passwordController,
    required this.pageConfig,
    required this.config,
  });
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                title: config.title ?? 'Create Account',
                titleStyle: textTheme.titleLarge,
                subtitle: config.subtitle ??
                    "Create an account to get started with our app.",
                subtitleStyle: textTheme.titleMedium,
                titleGap: const SizedBox(height: 6),
                child: config.logo ??
                    Icon(
                      Icons.person_add_alt_1,
                      size: 100,
                      color: theme.colorScheme.secondary,
                    ),
              ),
          EmailPhoneTextField(
            controller: controller,
            config: config.textFiledConfig,
          ),
          const SizedBox(height: 20),
          PasswordTextField(
            config: config.passwordTextFiledConfig,
            controller: passwordController,
          ),
          const SizedBox(height: 20),
          PasswordTextField(
            config: config.passwordTextFiledConfig.copyWith(
              decoration: (isObscure) {
                return config.passwordTextFiledConfig.decoration
                        ?.call(isObscure)
                        ?.copyWith(
                          labelText: 'Confirm Password',
                        ) ??
                    InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () => isObscure.value = !isObscure.value,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    );
              },
              validator: (value) {
                if (value != passwordController.text) {
                  return 'Password does not match';
                }
                return null;
              },
            ),
            controller: confirmPasswordController,
          ),
          const SizedBox(height: 40),
          SignInButton(
            onPressed: () async {
              return null;
            },
            config: loginConfig.copyWith(
              buttonText: const Text('Sign Up'),
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
          config.footer.orShrink,
        ],
      ),
    );
  }
}
