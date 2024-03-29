import 'package:flutter/material.dart';
import 'package:flutter_animated_login/flutter_animated_login.dart';
import 'package:flutter_animated_login/src/utils/extension.dart';
import 'package:universal_io/io.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<bool> isFormValidNotifier;
  final EmailFiledConfig emailConfig;
  final bool autofocus;
  const EmailField({
    super.key,
    required this.controller,
    required this.isFormValidNotifier,
    required this.emailConfig,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return TextFormField(
      autofocus: autofocus,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: emailConfig.decoration ??
          const InputDecoration(
            hintText: 'Enter your email or phone',
            // prefixIcon: controller.text.isEmpty
            //     ? null
            //     : controller.text.contains(RegExp(r'^[+]?[0-9]+$'))
            //         ? const Icon(Icons.phone_iphone)
            //         : const Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
      style: emailConfig.style ??
          textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.secondary,
            fontSize: 20,
          ),
      onChanged: (text) {
        print(text);
      },
      validator: emailConfig.validator ??
          (value) {
            if (value.isEmptyOrNull) {
              return 'Please enter your email or phone';
            }
            if (!value.isEmail) {
              return 'Please enter a valid email';
            }
            return null;
          },
      autofillHints: emailConfig.autofillHints ??
          const [
            AutofillHints.email,
            AutofillHints.telephoneNumber,
            AutofillHints.telephoneNumberNational,
          ],
      keyboardType: emailConfig.keyboardType ??
          (Platform.isAndroid
              ? TextInputType.visiblePassword
              : const TextInputType.numberWithOptions()),
      textInputAction: emailConfig.textInputAction ?? TextInputAction.done,
    );
  }
}
