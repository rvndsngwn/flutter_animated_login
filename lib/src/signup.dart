import 'package:flutter/material.dart';

import 'utils/extension.dart';
import 'widget/page.dart';

class FlutterAnimatedSignup extends StatelessWidget {
  const FlutterAnimatedSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => nextPageNotifier.value = 0,
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
