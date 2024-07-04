import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';

import 'login.dart';
import 'utils/extension.dart';
import 'utils/login_config.dart';
import 'utils/page_config.dart';
import 'utils/signup_config.dart';
import 'utils/signup_data.dart';
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
  final SignupCallback? onSignup;
  final GlobalKey<FormState> formKey;
  FlutterAnimatedSignup({
    super.key,
    required this.loginConfig,
    required this.loginType,
    required this.controller,
    required this.passwordController,
    required this.pageConfig,
    required this.config,
    this.onSignup,
    required this.formKey,
  });
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    Future<String?> onLoginFunction() async {
      try {
        final isValid = formKey.currentState?.validate() ?? false;
        if (!isValid) {
          context.error(
            "Error",
            description: loginConfig.messages.invalidFormData,
          );
          return null;
        }
        formKey.currentState?.save();
        if (onSignup != null) {
          final result = await onSignup?.call(SignupData(
            name: controller.text.isEmail
                ? controller.text
                : usernameNotifier.value.completeNumber,
            password: passwordController.text,
            additionalSignupData: {
              'confirmPassword': confirmPasswordController.text,
            },
          ));
          if (context.mounted) {
            if (result.isNotEmptyOrNull) {
              context.error("Error", description: result);
            } else if (config.loginAfterSignUp) {
              nextPageNotifier.value = 0;
            } else {
              nextPageNotifier.value = 0;
              formKey.currentState?.reset();
              isFormValidNotifier.value = false;
              controller.clear();
              passwordController.clear();
              confirmPasswordController.clear();
              isPhoneNotifier.value = false;
              usernameNotifier.value = PhoneNumber(
                countryISOCode: "",
                countryCode: "",
                number: "",
              );
            }
          }
        }
        return null;
      } finally {
        signInButtonIsLoading.value = false;
      }
    }

    return PageWidget(
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          config.header ??
              config.titleWidget ??
              TitleWidget(
                title: config.title ?? loginConfig.messages.signUp,
                titleStyle: textTheme.titleLarge,
                subtitle:
                    config.subtitle ?? loginConfig.messages.createAccountLong,
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
            formMessages: loginConfig.messages,
          ),
          const SizedBox(height: 20),
          PasswordTextField(
            config: config.passwordTextFiledConfig,
            controller: passwordController,
            formMessages: loginConfig.messages,
          ),
          const SizedBox(height: 20),
          PasswordTextField(
            config: config.passwordTextFiledConfig.copyWith(
              decoration: (isObscure) {
                return config.passwordTextFiledConfig.decoration
                        ?.call(isObscure)
                        ?.copyWith(
                          labelText: loginConfig.messages.confirmPassword,
                        ) ??
                    InputDecoration(
                      hintText: loginConfig.messages.reEnterPassword,
                      labelText: loginConfig.messages.confirmPassword,
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
                  return loginConfig.messages.passwordsUnmatched;
                }
                return null;
              },
              onFieldSubmitted: (value) {
                config.passwordTextFiledConfig.onFieldSubmitted?.call(value);
                onLoginFunction();
              },
              textInputAction: TextInputAction.done,
            ),
            controller: confirmPasswordController,
            formMessages: loginConfig.messages,
          ),
          const SizedBox(height: 40),
          SignInButton(
            onPressed: onLoginFunction,
            config: loginConfig.copyWith(
              buttonText: Text(loginConfig.messages.signUp),
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
            child: Text(loginConfig.messages.signIn),
          ),
          config.footer.orShrink,
        ],
      ),
    );
  }
}
