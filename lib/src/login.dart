import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'reset_password.dart';
import 'signup.dart';
import 'utils/extension.dart';
import 'utils/login_config.dart';
import 'utils/login_data.dart';
import 'utils/login_provider.dart';
import 'utils/page_config.dart';
import 'utils/reset_config.dart';
import 'utils/signup_data.dart';
import 'utils/verify_config.dart';
import 'verify.dart';
import 'widget/button.dart';
import 'widget/email_phone_field.dart';
import 'widget/oauth.dart';
import 'widget/page.dart';
import 'widget/password_field.dart';
import 'widget/title.dart';

/// The callback triggered your login logic
/// The result is an error message, callback successes if message is null
typedef LoginCallback = Future<String?>? Function(LoginData);

/// The callback triggered your signup logic
/// The result is an error message, callback successes if message is null
typedef SignupCallback = Future<String?>? Function(SignupData);

/// If the callback returns true, the additional data card is shown
typedef ProviderNeedsSignUpCallback = Future<bool> Function();

/// The callback triggered your auth logic for the provider
typedef ProviderAuthCallback = Future<String?>? Function();

/// The callback triggered your OTP verification logic
typedef VerifyCallback = Future<String?>? Function(LoginData);

/// The callback triggered your OTP resend logic
typedef ResendOtpCallback = Future<String?>? Function(LoginData);

class FlutterAnimatedLogin extends StatefulWidget {
  /// The callback triggered your login logic
  final LoginCallback? onLogin;

  /// The callback triggered your signup logic
  final SignupCallback? onSignup;

  /// [VerifyCallback] triggered your OTP verification logic
  /// The result is an error message, callback successes if message is null
  final VerifyCallback? onVerify;

  /// [ResendOtpCallback] triggered your OTP resend logic
  final ResendOtpCallback? onResendOtp;

  /// The configuration for the login text field
  final LoginConfig loginConfig;

  /// The list of login providers for the oauth
  final List<LoginProvider>? providers;

  /// The login type, default is [LoginType.otp]
  final LoginType loginType;

  /// The configuration for the verify page
  final VerifyConfig verifyConfig;

  /// The terms and conditions for the login/signup page
  final TextSpan? termsAndConditions;

  /// [PageConfig] for the page widget to customize the page.
  final PageConfig config;

  final ResetConfig resetConfig;

  const FlutterAnimatedLogin({
    super.key,
    this.onLogin,
    this.onSignup,
    this.onVerify,
    this.onResendOtp,
    this.loginConfig = const LoginConfig(),
    this.providers,
    this.loginType = LoginType.otp,
    this.verifyConfig = const VerifyConfig(),
    this.termsAndConditions,
    this.config = const PageConfig(),
    this.resetConfig = const ResetConfig(),
  });

  @override
  State<FlutterAnimatedLogin> createState() => _FlutterAnimatedLoginState();
}

class _FlutterAnimatedLoginState extends State<FlutterAnimatedLogin> {
  /// The text controller for the text field if not provided by the user
  late TextEditingController _textController;

  /// The text controller for the password field if not provided by the user
  late TextEditingController _passwordController;

  @override
  void initState() {
    final controller = widget.loginConfig.textFiledConfig.controller;
    final passwordController = widget.loginConfig.passwordConfig.controller;
    _passwordController = passwordController ?? TextEditingController();
    _textController = controller ?? TextEditingController();
    final text = _textController.text;
    isPhoneNotifier.value = text.isPhoneNumber || text.isIntlPhoneNumber;
    isFormValidNotifier.value = text.isEmail || isPhoneNotifier.value;
    _textController.addListener(() {
      final text = _textController.text;
      if (text.isNotEmpty) {
        /// Check if the text is a international phone number
        isPhoneNotifier.value = text.isIntlPhoneNumber;
      } else if (text.isEmptyOrNull ||
          text.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
        isPhoneNotifier.value = false;
      }
      isFormValidNotifier.value = text.isEmail || isPhoneNotifier.value;
    });
    if (widget.loginType == LoginType.password) {
      _passwordController.addListener(() {
        final password = _passwordController.text;
        final text = _textController.text;
        isFormValidNotifier.value = password.isNotEmptyOrNull &&
            (text.isNotEmptyOrNull && (text.isEmail || isPhoneNotifier.value));
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    isPhoneNotifier.dispose();
    isFormValidNotifier.dispose();
    nextPageNotifier.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch (nextPageNotifier.watch(context)) {
      0 => _LoginPage(
          config: widget.loginConfig,
          loginType: widget.loginType,
          onLogin: widget.onLogin,
          onVerify: widget.onVerify,
          providers: widget.providers,
          textController: _textController,
          termsAndConditions: widget.termsAndConditions,
          passwordController: _passwordController,
          pageConfig: widget.config,
        ),
      1 => FlutterAnimatedVerify(
          onVerify: widget.onVerify,
          name: _textController.text.isEmail
              ? _textController.text
              : phoneNumber.value.completeNumber,
          config: widget.verifyConfig,
          onResendOtp: widget.onResendOtp,
          termsAndConditions: widget.termsAndConditions,
          pageConfig: widget.config,
        ),
      2 => const FlutterAnimatedSignup(),
      3 => FlutterAnimatedReset(
          config: widget.resetConfig,
          loginConfig: widget.loginConfig,
          loginType: widget.loginType,
          controller: _textController,
          textConfig: widget.loginConfig.textFiledConfig,
        ),
      _ => const Center(
          child: FlutterLogo(size: 100),
        ),
    };
  }
}

enum LoginType {
  otp,
  password,
  otpAndPassword,
}

class _LoginPage extends StatelessWidget {
  final LoginConfig config;
  final TextSpan? termsAndConditions;
  final LoginType loginType;
  final LoginCallback? onLogin;
  final VerifyCallback? onVerify;
  final List<LoginProvider>? providers;
  final TextEditingController textController;
  final TextEditingController passwordController;

  /// [PageConfig] for the page widget to customize the page.
  final PageConfig pageConfig;

  const _LoginPage({
    this.onLogin,
    this.onVerify,
    this.providers,
    required this.config,
    required this.loginType,
    required this.textController,
    required this.passwordController,
    this.termsAndConditions,
    this.pageConfig = const PageConfig(),
  });

  @override
  Widget build(BuildContext context) {
    final textConfig = config.textFiledConfig;
    final passConfig = config.passwordConfig;
    final isLoginWithOTP =
        loginType == LoginType.otp || loginType == LoginType.otpAndPassword;
    return PageWidget(
      config: pageConfig,
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          config.header ??
              config.titleWidget ??
              TitleWidget(
                title: config.title,
                subtitle: config.subtitle,
                child: config.logo,
              ),
          EmailPhoneTextField(
            controller: textController,
            config: textConfig,
          ),
          if (!isLoginWithOTP) ...[
            const SizedBox(height: 20),
            PasswordTextField(
              config: passConfig,
              controller: passwordController,
            ),
            const SizedBox(height: 8),
            const SignUpAndForgetButton(),
          ],
          const SizedBox(height: 40),
          SignInButton(
            onPressed: () async {
              if (onLogin != null) {
                final result = await onLogin?.call(LoginData(
                  name: textController.text.isEmail
                      ? textController.text
                      : phoneNumber.value.completeNumber,
                  secret: passwordController.text,
                ));
                if (context.mounted) {
                  if (result.isNotEmptyOrNull) {
                    context.error("Error", description: result);
                  } else {
                    nextPageNotifier.value = 1;
                  }
                }
              }
              return null;
            },
            config: config,
            constraints: constraints,
            loginType: loginType,
          ),
          OAuthWidget(
            providers: providers,
            termsAndConditions: termsAndConditions,
            footerWidget: config.footer,
          ),
        ],
      ),
    );
  }
}
