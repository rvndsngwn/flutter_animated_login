import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animated_login/flutter_animated_login.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';

import 'utils/extension.dart';
import 'utils/loading_state.dart';
import 'widget/oauth.dart';

class FlutterAnimatedVerify extends StatefulWidget {
  final VerifyCallback? onVerify;
  final String name;
  final VerifyConfig config;
  final Widget? footerWidget;
  final Widget? termsAndConditions;
  final FormMessages formMessages;

  /// [ResendOtpCallback] triggered after the user has resent the OTP
  final ResendOtpCallback? onResendOtp;

  /// [PageConfig] for the page widget to customize the page.
  final PageConfig pageConfig;

  const FlutterAnimatedVerify({
    super.key,
    this.onVerify,
    required this.name,
    required this.config,
    this.onResendOtp,
    this.footerWidget,
    this.termsAndConditions,
    this.pageConfig = const PageConfig(),
    required this.formMessages,
  });

  @override
  State<FlutterAnimatedVerify> createState() => _FlutterAnimatedVerifyState();
}

class _FlutterAnimatedVerifyState extends State<FlutterAnimatedVerify> {
  late TextFieldController _textController;

  /// Timer object for OTP expiration.
  Timer? _otpExpirationTimer;
  final Duration _otpExpirationDuration = const Duration(seconds: 60);

  Duration get otpExpirationTimeLeft {
    final otpTickDuration = Duration(
      seconds: (_otpExpirationTimer?.tick ?? 0),
    );
    return _otpExpirationDuration - otpTickDuration;
  }

  /// Whether the otp has expired or not.
  bool get isOtpExpired => !(_otpExpirationTimer?.isActive ?? false);

  bool isEmail = false;

  OtpTextFiledConfig get textConfig => widget.config.textFiledConfig;
  VerifyConfig get config => widget.config;

  void onCompleted(String value) async {
    textConfig.onCompleted?.call(
      LoginData(name: widget.name, secret: value),
    );
    final result = await widget.onVerify?.call(
      LoginData(name: widget.name, secret: value),
    );
    if (result.isNotEmptyOrNull) {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        context.error('Error', description: result);
      }
    } else {
      nextPageNotifier.value = 0;
      isFormValidNotifier.value = false;
      isPhoneNotifier.value = false;
      _textController.clear();
      usernameNotifier.value = PhoneNumber(
        countryISOCode: "",
        countryCode: "",
        number: "",
      );
    }
  }

  @override
  void initState() {
    _textController =
        widget.config.textFiledConfig.controller ?? TextFieldController();
    Future.microtask(
      () {
        _otpExpirationTimer = Timer.periodic(
          const Duration(seconds: 1),
          (timer) {
            if (timer.tick == _otpExpirationDuration.inSeconds) {
              _otpExpirationTimer?.cancel();
            }
            setState(() {});
          },
        );
        setState(() {
          isEmail = widget.name.isEmail;
        });
        if (_textController.text.isEmptyOrNull &&
            _textController.text.length < 6) {
          _textController.text = '';
        }
        if (_textController.text.length > 6) {
          _textController.text = _textController.text.substring(0, 6);
        }
        if (_textController.text.length == 6) {
          onCompleted(_textController.text);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _textController.isDisposed ? null : _textController.dispose();
    _otpExpirationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final borderColor = theme.colorScheme.primary;
    final errorColor = theme.colorScheme.error;
    final fillColor = theme.colorScheme.primary.withValues(alpha: 0.1);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.secondary,
        fontSize: 20,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return PageWidget(
      config: widget.pageConfig,
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          config.header ??
              config.titleWidget ??
              TitleWidget(
                title: config.title ??
                    'Enter OTP sent to your ${isEmail ? 'email' : 'phone'}',
                titleStyle: textTheme.titleLarge,
                subtitle: config.subtitle ?? widget.name,
                subtitleStyle: textTheme.titleMedium,
                titleGap: const SizedBox(height: 6),
                onTap: () => nextPageNotifier.value = 0,
                child: config.logo.orShrink,
              ),
          Pinput(
            length: textConfig.length ?? 6,
            pinAnimationType: textConfig.pinAnimationType,
            controller: _textController,
            smsRetriever: textConfig.smsRetriever,
            autofillHints:
                textConfig.autofillHints ?? const [AutofillHints.oneTimeCode],
            focusedPinTheme: textConfig.focusedPinTheme ??
                defaultPinTheme.copyWith(
                  height: 68,
                  width: 64,
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: borderColor),
                  ),
                ),
            errorPinTheme: textConfig.errorPinTheme ??
                defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    color: errorColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
            defaultPinTheme: textConfig.defaultPinTheme ?? defaultPinTheme,
            onCompleted: onCompleted,
            onChanged: (value) {
              textConfig.onChanged?.call(
                LoginData(name: widget.name, secret: value),
              );
            },
            onSubmitted: onCompleted,
            onAppPrivateCommand: textConfig.onAppPrivateCommand,
            onClipboardFound: textConfig.onClipboardFound,
            onLongPress: textConfig.onLongPress,
            onTap: textConfig.onTap,
            onTapOutside: textConfig.onTapOutside,
            animationCurve: textConfig.animationCurve,
            animationDuration:
                textConfig.animationDuration ?? kThemeAnimationDuration,
            autofocus: textConfig.autofocus,
            closeKeyboardWhenCompleted: textConfig.closeKeyboardWhenCompleted,
            contextMenuBuilder: textConfig.contextMenuBuilder,
            crossAxisAlignment: textConfig.crossAxisAlignment,
            cursor: textConfig.cursor,
            disabledPinTheme: textConfig.disabledPinTheme,
            enableIMEPersonalizedLearning:
                textConfig.enableIMEPersonalizedLearning,
            enableSuggestions: textConfig.enableSuggestions,
            enabled: textConfig.enabled,
            errorBuilder: textConfig.errorBuilder,
            errorText: textConfig.errorText,
            errorTextStyle: textConfig.errorTextStyle,
            keyboardType: textConfig.keyboardType,
            focusNode: textConfig.focusNode,
            followingPinTheme: textConfig.followingPinTheme,
            forceErrorState: textConfig.forceErrorState,
            hapticFeedbackType: textConfig.hapticFeedbackType,
            inputFormatters: textConfig.inputFormatters,
            isCursorAnimationEnabled: textConfig.isCursorAnimationEnabled,
            keyboardAppearance: textConfig.keyboardAppearance,
            mainAxisAlignment: textConfig.mainAxisAlignment,
            mouseCursor: textConfig.mouseCursor,
            obscureText: textConfig.obscureText,
            obscuringCharacter: textConfig.obscuringCharacter,
            obscuringWidget: textConfig.obscuringWidget,
            pinContentAlignment: textConfig.pinContentAlignment,
            pinputAutovalidateMode: textConfig.pinputAutovalidateMode,
            preFilledWidget: textConfig.preFilledWidget,
            readOnly: textConfig.readOnly,
            restorationId: textConfig.restorationId,
            scrollPadding: textConfig.scrollPadding,
            selectionControls: textConfig.selectionControls,
            separatorBuilder: textConfig.separatorBuilder,
            showCursor: textConfig.showCursor,
            slideTransitionBeginOffset: textConfig.slideTransitionBeginOffset,
            submittedPinTheme: textConfig.submittedPinTheme,
            textCapitalization: textConfig.textCapitalization,
            textInputAction: textConfig.textInputAction,
            toolbarEnabled: textConfig.toolbarEnabled,
            useNativeKeyboard: textConfig.useNativeKeyboard,
            validator: textConfig.validator,
          ),
          const SizedBox(height: 20),
          if (!isOtpExpired)
            Text(
              '${widget.formMessages.resendOTP} (${otpExpirationTimeLeft.inMinutes.toDigital}:${(otpExpirationTimeLeft.inSeconds % 60).toDigital})',
              style: textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            )
          else
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: constraints.maxWidth >= 600
                  ? 200
                  : constraints.maxWidth * 0.5,
              child: AutoLoadingButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(
                    constraints.maxWidth >= 600
                        ? 200
                        : constraints.maxWidth * 0.5,
                    48,
                  ),
                  textStyle: config.buttonTextStyle ?? textTheme.titleMedium,
                ),
                onPressed: () async {
                  final response = await widget.onResendOtp
                      ?.call(LoginData(name: widget.name, secret: null));
                  if (context.mounted) {
                    if (response.isNotEmptyOrNull) {
                      context.error('Error', description: response);
                    } else {
                      setState(() {
                        _otpExpirationTimer?.cancel();
                        _otpExpirationTimer = Timer.periodic(
                          const Duration(seconds: 1),
                          (timer) {
                            if (timer.tick ==
                                _otpExpirationDuration.inSeconds) {
                              _otpExpirationTimer?.cancel();
                            }
                            setState(() {});
                          },
                        );
                      });
                    }
                  }
                },
                child:
                    config.resendButton ?? Text(widget.formMessages.resendOTP),
              ),
            ),
          config.footer ??
              OAuthWidget(
                footerWidget: widget.footerWidget,
                termsAndConditions: widget.termsAndConditions,
              ),
        ],
      ),
    );
  }
}
