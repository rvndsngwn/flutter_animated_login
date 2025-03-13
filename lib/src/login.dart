import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';
import 'package:signals/signals_flutter.dart';

import 'reset_password.dart';
import 'signup.dart';
import 'utils/extension.dart';
import 'utils/form_messages.dart';
import 'utils/login_config.dart';
import 'utils/login_data.dart';
import 'utils/login_provider.dart';
import 'utils/page_config.dart';
import 'utils/reset_config.dart';
import 'utils/signup_config.dart';
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

/// The callback triggered your reset password logic
typedef ResetPasswordCallback = Future<String?>? Function(String);

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

  /// The configuration for the reset password page
  final ResetConfig resetConfig;

  /// The configuration for the signup page
  final SignupConfig signupConfig;

  /// The callback triggered your reset password logic
  final ResetPasswordCallback? onResetPassword;

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
    this.signupConfig = const SignupConfig(),
    this.onResetPassword,
  });

  @override
  State<FlutterAnimatedLogin> createState() => _FlutterAnimatedLoginState();
}

class _FlutterAnimatedLoginState extends State<FlutterAnimatedLogin> {
  /// The text controller for the text field if not provided by the user
  late TextEditingController _textController;

  /// The text controller for the password field if not provided by the user
  late TextEditingController _passwordController;

  /// Form key for the login form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: switch (nextPageNotifier.watch(context)) {
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
            formKey: formKey,
            formMessages: widget.loginConfig.messages,
          ),
        1 => FlutterAnimatedVerify(
            onVerify: widget.onVerify,
            name: _textController.text.isEmail
                ? _textController.text
                : usernameNotifier.value.completeNumber,
            config: widget.verifyConfig,
            onResendOtp: widget.onResendOtp,
            termsAndConditions: widget.termsAndConditions,
            pageConfig: widget.config,
            formMessages: widget.loginConfig.messages,
          ),
        2 => FlutterAnimatedSignup(
            config: widget.signupConfig.copyWith(
              textFiledConfig: widget.loginConfig.textFiledConfig,
              passwordTextFiledConfig: widget.loginConfig.passwordConfig,
            ),
            onSignup: widget.onSignup,
            loginConfig: widget.loginConfig,
            loginType: widget.loginType,
            controller: _textController,
            pageConfig: widget.config,
            passwordController: _passwordController,
            formKey: formKey,
          ),
        3 => FlutterAnimatedReset(
            config: widget.resetConfig.copyWith(
              textFiledConfig: widget.loginConfig.textFiledConfig,
            ),
            onResetPassword: widget.onResetPassword,
            loginConfig: widget.loginConfig,
            loginType: widget.loginType,
            controller: _textController,
            pageConfig: widget.config,
            formKey: formKey,
          ),
        _ => const Center(
            child: FlutterLogo(size: 100),
          ),
      },
    );
  }
}

enum LoginType {
  /// Login with OTP [LoginType.otp]
  /// This option provides the option to login with OTP only
  otp,

  /// Login with Password [LoginType.password]
  /// This option provides the option to login with password only
  /// Forget password and signup options are available
  password,

  /// Login with OTP and Password [LoginType.otpAndPassword]
  /// This option provides the option to login with OTP or Password
  /// If the user selects OTP, the user will be redirected to the OTP verification page
  /// If the user selects Password, the user will be logged in with the password
  /// ! This option does not provide the option to login with OTP and Password at the same time
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
  final GlobalKey<FormState> formKey;
  final FormMessages formMessages;

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
    required this.formMessages,
    this.termsAndConditions,
    this.pageConfig = const PageConfig(),
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final textConfig = config.textFiledConfig;
    final passConfig = config.passwordConfig;
    final isLoginWithOTP =
        loginType == LoginType.otp || loginType == LoginType.otpAndPassword;

    Future<String?> onLoginFunction() async {
      try {
        signInButtonIsLoading.value = true;
        final isValid = formKey.currentState?.validate() ?? false;
        if (!isValid) {
          context.error(
            "Error",
            description: "Invalid form data, fill all required fields",
          );
          return null;
        }
        formKey.currentState?.save();
        if (onLogin != null) {
          final result = await onLogin?.call(LoginData(
            name: textController.text.isEmail
                ? textController.text
                : usernameNotifier.value.completeNumber,
            secret: passwordController.text,
          ));
          if (context.mounted) {
            if (result.isNotEmptyOrNull) {
              context.error("Error", description: result);
            } else if (loginType == LoginType.otp) {
              nextPageNotifier.value = 1;
            } else {
              nextPageNotifier.value = 0;
              formKey.currentState?.reset();
              isFormValidNotifier.value = false;
              passwordController.clear();
              textController.clear();
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
            config: isLoginWithOTP
                ? textConfig.copyWith(
                    onSubmitted: (p0) {
                      textConfig.onSubmitted?.call(p0);
                      onLoginFunction();
                    },
                    textInputAction: TextInputAction.done,
                  )
                : textConfig,
            formMessages: formMessages,
            loginFieldInputType: config.loginFieldInputType,
          ),
          if (!isLoginWithOTP) ...[
            const SizedBox(height: 20),
            PasswordTextField(
              config: !isLoginWithOTP
                  ? passConfig.copyWith(
                      onFieldSubmitted: (p0) {
                        passConfig.onFieldSubmitted?.call(p0);
                        onLoginFunction();
                      },
                    )
                  : passConfig,
              controller: passwordController,
              formMessages: formMessages,
            ),
            const SizedBox(height: 8),
            const SignUpAndForgetButton(),
          ],
          const SizedBox(height: 40),
          SignInButton(
            onPressed: onLoginFunction,
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
