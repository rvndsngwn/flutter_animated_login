import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animated_login/flutter_animated_login.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';
import 'package:pinput/pinput.dart';

class FlutterAnimatedVerify extends StatefulWidget {
  final Future<void> Function()? onPressed;
  final String value;
  const FlutterAnimatedVerify({
    super.key,
    this.onPressed,
    this.value = 'arvind@mohesu.com',
  });

  @override
  State<FlutterAnimatedVerify> createState() => _FlutterAnimatedVerifyState();
}

class _FlutterAnimatedVerifyState extends State<FlutterAnimatedVerify> {
  final TextEditingController textController = TextEditingController();

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

  @override
  void initState() {
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
      isEmail = widget.value.contains('@') && widget.value.contains('.');
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    _otpExpirationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final borderColor = theme.colorScheme.primary;
    final errorColor = theme.colorScheme.error;
    final fillColor = theme.colorScheme.primary.withOpacity(0.1);
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
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleWidget(
            title: 'Enter OTP sent to your ${isEmail ? 'email' : 'phone'}',
            titleStyle: textTheme.titleLarge,
            subtitle: '#${widget.value}',
            subtitleStyle: textTheme.titleMedium,
            titleGap: const SizedBox(height: 6),
            child: Icon(
              isEmail ? Icons.email : Icons.phone_iphone,
              size: 100,
              color: theme.colorScheme.secondary,
            ),
          ),
          Pinput(
            length: 6,
            pinAnimationType: PinAnimationType.scale,
            controller: textController,
            // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
            autofillHints: const [AutofillHints.oneTimeCode],
            focusedPinTheme: defaultPinTheme.copyWith(
              height: 68,
              width: 64,
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: borderColor),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyWith(
              decoration: BoxDecoration(
                color: errorColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            defaultPinTheme: defaultPinTheme,
            onCompleted: (value) async {
              print(value);
            },
          ),
          const SizedBox(height: 20),
          if (!isOtpExpired)
            Text(
              'Resend OTP (${otpExpirationTimeLeft.inMinutes.toDigital}:${(otpExpirationTimeLeft.inSeconds % 60).toDigital})',
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
              child: TextAutoLoadingButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(
                    constraints.maxWidth >= 600
                        ? 200
                        : constraints.maxWidth * 0.5,
                    55,
                  ),
                  textStyle: textTheme.titleLarge,
                ),
                onPressed: () async {
                  await Future.delayed(
                    const Duration(seconds: 2),
                    () {
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
                    },
                  );
                },
                child: const Text("Resend OTP"),
              ),
            ),
          const OAuthWidget(),
        ],
      ),
    );
  }
}
