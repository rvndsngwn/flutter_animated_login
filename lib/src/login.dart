import 'package:flutter/material.dart';

import 'utils/extension.dart';
import 'utils/login_config.dart';
import 'utils/login_data.dart';
import 'utils/login_provider.dart';
import 'utils/signup_data.dart';
import 'utils/verify_config.dart';
import 'verify.dart';
import 'widget/button.dart';
import 'widget/email_phone_field.dart';
import 'widget/oauth.dart';
import 'widget/page.dart';
import 'widget/password_field.dart';
import 'widget/title.dart';

/// The callback triggered after login
/// The result is an error message, callback successes if message is null
typedef LoginCallback = Future<String?>? Function(LoginData);

/// The callback triggered after signup
/// The result is an error message, callback successes if message is null
typedef SignupCallback = Future<String?>? Function(SignupData);

/// If the callback returns true, the additional data card is shown
typedef ProviderNeedsSignUpCallback = Future<bool> Function();

/// The callback triggered after the user has oauth with the provider
typedef ProviderAuthCallback = Future<String?>? Function();

/// The callback triggered after the user has verified the OTP
typedef VerifyCallback = Future<String?>? Function(String);

/// The callback triggered after the user has resent the OTP
typedef ResendOtpCallback = Future<String?>? Function();

class FlutterAnimatedLogin extends StatefulWidget {
  /// The callback triggered after login
  final LoginCallback? onLogin;

  /// The callback triggered after signup
  final SignupCallback? onSignup;

  /// [VerifyCallback] triggered after the user has verified the OTP
  /// The result is an error message, callback successes if message is null
  final VerifyCallback? onVerify;

  /// [ResendOtpCallback] triggered after the user has resent the OTP
  final ResendOtpCallback? onResendOtp;

  /// The configuration for the login text field
  final LoginConfig loginConfig;

  /// The header widget for the login page
  final Widget? headerWidget;

  /// The footer widget for the login page
  final Widget? footerWidget;

  /// The list of login providers for the oauth
  final List<LoginProvider>? providers;

  /// The login type, default is [LoginType.loginWithOTP]
  final LoginType loginType;

  /// The configuration for the verify page
  final VerifyConfig verifyConfig;

  const FlutterAnimatedLogin({
    super.key,
    this.onLogin,
    this.onSignup,
    this.onVerify,
    this.onResendOtp,
    this.loginConfig = const LoginConfig(),
    this.headerWidget,
    this.footerWidget,
    this.providers,
    this.loginType = LoginType.loginWithOTP,
    this.verifyConfig = const VerifyConfig(),
  });

  @override
  State<FlutterAnimatedLogin> createState() => _FlutterAnimatedLoginState();
}

class _FlutterAnimatedLoginState extends State<FlutterAnimatedLogin> {
  /// The text controller for the text field if not provided by the user
  late TextEditingController _textController;

  /// The notifier for the notifying if the text is a phone number
  final ValueNotifier<bool> _isPhoneNotifier = ValueNotifier(false);

  /// The notifier for the notifying if the form is valid
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier(false);

  final ValueNotifier<int> _nextPageNotifier = ValueNotifier(0);

  @override
  void initState() {
    final controller = widget.loginConfig.textFiledConfig.controller;
    _textController = controller ?? TextEditingController();
    debugPrint('Controller: ${_textController.text}');
    final text = _textController.text;
    _isPhoneNotifier.value = text.isPhoneNumber || text.isIntlPhoneNumber;
    _isFormValidNotifier.value = text.isEmail || _isPhoneNotifier.value;
    _textController.addListener(() {
      final text = _textController.text;
      debugPrint('Text: $text');
      if (text.isNotEmpty) {
        /// Check if the text is a international phone number
        _isPhoneNotifier.value = text.isIntlPhoneNumber;
      } else if (text.isEmptyOrNull ||
          text.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
        _isPhoneNotifier.value = false;
      }
      _isFormValidNotifier.value = text.isEmail || _isPhoneNotifier.value;
    });
    debugPrint('Phone: ${_isPhoneNotifier.value}');
    debugPrint('Listener: ${_textController.hasListeners}');
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _isPhoneNotifier.dispose();
    _isFormValidNotifier.dispose();
    _nextPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _nextPageNotifier,
      builder: (context, nextPage, child) {
        switch (nextPage) {
          case 0:
            return _LoginPage(
              config: widget.loginConfig,
              headerWidget: widget.headerWidget,
              footerWidget: widget.footerWidget,
              loginType: widget.loginType,
              onLogin: widget.onLogin,
              onVerify: widget.onVerify,
              providers: widget.providers,
              isPhoneNotifier: _isPhoneNotifier,
              isFormValidNotifier: _isFormValidNotifier,
              nextPageNotifier: _nextPageNotifier,
              textController: _textController,
            );
          case 1:
            return FlutterAnimatedVerify(
              onVerify: widget.onVerify,
              name: _textController.text,
              nextPageNotifier: _nextPageNotifier,
              config: widget.verifyConfig,
              onResendOtp: widget.onResendOtp,
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

enum LoginType {
  loginWithOTP,
  loginWithPassword,
}

class _LoginPage extends StatelessWidget {
  final LoginConfig config;
  final Widget? headerWidget;
  final Widget? footerWidget;
  final LoginType loginType;
  final LoginCallback? onLogin;
  final VerifyCallback? onVerify;
  final List<LoginProvider>? providers;
  final TextEditingController textController;

  final ValueNotifier<bool> isPhoneNotifier;
  final ValueNotifier<bool> isFormValidNotifier;
  final ValueNotifier<int> nextPageNotifier;

  const _LoginPage({
    this.headerWidget,
    this.footerWidget,
    this.onLogin,
    this.onVerify,
    this.providers,
    required this.config,
    required this.loginType,
    required this.isPhoneNotifier,
    required this.isFormValidNotifier,
    required this.nextPageNotifier,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final textConfig = config.textFiledConfig;
    return PageWidget(
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          headerWidget ??
              TitleWidget(
                title: config.title,
                subtitle: config.subtitle,
              ),
          EmailPhoneTextField(
            controller: textController,
            config: textConfig,
            isFormValidNotifier: isFormValidNotifier,
            isPhoneNotifier: isPhoneNotifier,
          ),
          if (loginType == LoginType.loginWithPassword) ...[
            const SizedBox(height: 20),
            PasswordTextField(
              config: textConfig,
              isFormValidNotifier: isFormValidNotifier,
            ),
          ],
          const SizedBox(height: 40),
          SignInButton(
            formNotifier: isFormValidNotifier,
            onPressed: () async {
              if (onLogin != null) {
                final result = await onLogin?.call(LoginData(
                  name: textController.text,
                  password: null,
                ));
                debugPrint('Login result: $result');
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
          ),
          footerWidget ?? OAuthWidget(providers: providers),
        ],
      ),
    );
  }
}
