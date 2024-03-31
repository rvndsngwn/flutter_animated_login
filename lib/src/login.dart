import 'package:flutter/material.dart';

import 'utils/extension.dart';
import 'utils/login_config.dart';
import 'utils/login_data.dart';
import 'utils/login_provider.dart';
import 'utils/signup_data.dart';
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

class FlutterAnimatedLogin extends StatefulWidget {
  /// The callback triggered after login
  final LoginCallback? onLogin;

  /// The callback triggered after signup
  final SignupCallback? onSignup;

  /// The text controller for the text field
  final TextEditingController? textController;

  /// The configuration for the login text field
  final LoginConfig config;

  /// The header widget for the login page
  final Widget? headerWidget;

  /// The footer widget for the login page
  final Widget? footerWidget;

  /// The list of login providers for the oauth
  final List<LoginProvider>? providers;

  /// The login type, default is [LoginType.loginWithOTP]
  final LoginType loginType;
  const FlutterAnimatedLogin({
    super.key,
    this.onLogin,
    this.onSignup,
    this.textController,
    this.config = const LoginConfig(),
    this.headerWidget,
    this.footerWidget,
    this.providers,
    this.loginType = LoginType.loginWithOTP,
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

  @override
  void initState() {
    _textController = widget.textController ?? TextEditingController();
    final text = _textController.text;
    _isPhoneNotifier.value = text.isPhoneNumber || text.isIntlPhoneNumber;
    _isFormValidNotifier.value = text.isEmail || _isPhoneNotifier.value;
    _textController.addListener(() {
      final text = _textController.text;
      if (text.isNotEmpty) {
        /// Check if the text is a international phone number
        _isPhoneNotifier.value = text.isIntlPhoneNumber;
      } else if (text.isEmptyOrNull ||
          text.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
        _isPhoneNotifier.value = false;
      }
      _isFormValidNotifier.value = text.isEmail || _isPhoneNotifier.value;
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _isPhoneNotifier.dispose();
    _isFormValidNotifier.dispose();
    widget.textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config.textFiledConfig;
    return PageWidget(
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.headerWidget ??
              TitleWidget(
                title: widget.config.title,
                subtitle: widget.config.subtitle,
              ),
          EmailPhoneTextField(
            config: config,
            controller: _textController,
            isFormValidNotifier: _isFormValidNotifier,
            isPhoneNotifier: _isPhoneNotifier,
          ),
          if (widget.loginType == LoginType.loginWithPassword) ...[
            const SizedBox(height: 20),
            PasswordTextField(
              config: config,
              isFormValidNotifier: _isFormValidNotifier,
            ),
          ],
          const SizedBox(height: 40),
          SignInButton(
            formNotifier: _isFormValidNotifier,
            onPressed: () async {
              if (widget.onLogin != null) {
                final result = await widget.onLogin?.call(LoginData(
                  name: _textController.text,
                  password: null,
                ));
                debugPrint('Login result: $result');
                if (context.mounted) {
                  if (result.isNotEmptyOrNull) {
                    context.error("Error", description: result);
                  }
                }
              }
              return null;
            },
            config: widget.config,
            constraints: constraints,
          ),
          widget.footerWidget ?? OAuthWidget(providers: widget.providers),
        ],
      ),
    );
  }
}

enum LoginType {
  loginWithOTP,
  loginWithPassword,
}
