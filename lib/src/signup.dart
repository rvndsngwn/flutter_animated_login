import 'package:flutter/material.dart';

import 'widget/page.dart';

class FlutterAnimatedSignup extends StatefulWidget {
  final void Function()? onPressed;
  const FlutterAnimatedSignup({
    super.key,
    this.onPressed,
  });

  @override
  State<FlutterAnimatedSignup> createState() => _FlutterAnimatedSignupState();
}

class _FlutterAnimatedSignupState extends State<FlutterAnimatedSignup> {
  @override
  Widget build(BuildContext context) {
    return PageWidget(
      builder: (context, constraints) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Hello, World!'),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text('This is a signup page.'),
          ),
          TextButton(
            onPressed: widget.onPressed,
            child: const Text("Login"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Forgot password?"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("OTP Login"),
          ),
        ],
      ),
    );
  }
}
