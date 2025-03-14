import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../flutter_animated_login.dart';
import '../utils/extension.dart';
import '../utils/loading_state.dart';

final signInButtonIsLoading = signal(false);

class SignInButton extends StatelessWidget {
  final Future<String?> Function()? onPressed;
  final LoginConfig config;
  final BoxConstraints constraints;
  final LoginType loginType;

  const SignInButton({
    super.key,
    required this.onPressed,
    required this.config,
    required this.constraints,
    required this.loginType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Watch.builder(
      builder: (context) {
        final isFormValid = isFormValidNotifier.value;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: constraints.maxWidth >= 600 ? 300 : constraints.maxWidth * 0.5,
          child: AutoLoadingButton(
            isLoading: signInButtonIsLoading(),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                constraints.maxWidth >= 600 ? 300 : constraints.maxWidth * 0.5,
                48,
              ),
              textStyle: config.buttonTextStyle ?? textTheme.titleMedium,
            ),
            onPressed: isFormValid ? onPressed : null,
            child: config.buttonText ??
                (loginType == LoginType.otp ||
                        loginType == LoginType.otpAndPassword
                    ? const Text("Continue")
                    : const Text('Sign In')),
          ),
        );
      },
    );
  }
}

class SignUpAndForgetButton extends StatelessWidget {
  const SignUpAndForgetButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => nextPageNotifier.value = 2,
          child: const Text('Sign Up'),
        ),
        TextButton(
          onPressed: () => nextPageNotifier.value = 3,
          child: const Text('Forget Password?'),
        ),
      ],
    );
  }
}
