import 'package:flutter/material.dart';

import '../utils/login_config.dart';

class PasswordTextField extends StatelessWidget {
  final ValueNotifier<bool> isFormValidNotifier;
  final EmailPhoneTextFiledConfig config;
  const PasswordTextField({
    super.key,
    required this.isFormValidNotifier,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final isObscure = ValueNotifier<bool>(true);
    return ValueListenableBuilder(
      valueListenable: isObscure,
      builder: (context, obscure, child) {
        return TextFormField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () => isObscure.value = !obscure,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        );
      },
    );
  }
}
