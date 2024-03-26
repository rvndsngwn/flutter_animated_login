import 'package:flutter/material.dart';
import 'package:flutter_animated_login/flutter_animated_login.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';

class SignInButton extends StatelessWidget {
  final ValueNotifier<bool> formNotifier;
  final Future<String?> Function()? onPressed;
  final LoginConfig config;
  final BoxConstraints constraints;

  const SignInButton({
    super.key,
    required this.formNotifier,
    required this.onPressed,
    required this.config,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return ValueListenableBuilder(
      valueListenable: formNotifier,
      builder: (context, isFormValid, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: constraints.maxWidth >= 600 ? 200 : constraints.maxWidth * 0.5,
          child: FilledAutoLoadingButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                constraints.maxWidth >= 600 ? 200 : constraints.maxWidth * 0.5,
                55,
              ),
              textStyle: config.buttonTextStyle ?? textTheme.titleLarge,
            ),
            onPressed: isFormValid ? onPressed : null,
            child: config.buttonText ?? const Text("Continue"),
          ),
        );
      },
    );
  }
}
