import 'package:flutter/material.dart';
import 'package:flutter_animated_login/flutter_animated_login.dart';

void main() {
  runApp(const MyApp());
}

ValueNotifier<bool> isDark = ValueNotifier<bool>(true);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDark,
      builder: (context, value, child) => MaterialApp(
        title: 'Flutter Animated Login',
        themeMode: value ? ThemeMode.dark : ThemeMode.light,
        theme: value ? ThemeData.dark() : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: FlutterAnimatedLogin(
          onLogin: () => Future.delayed(
            const Duration(seconds: 2),
            () => 'Login Successful',
          ),
          config: const LoginConfig(
            title: 'Mohesu Enterprise',
            subtitle: 'Let\'s Sign In',
          ),
        ),
        builder: (context, child) {
          return Scaffold(
            body: SingleChildScrollView(child: child),
            floatingActionButton: IconButton.filled(
              onPressed: () => isDark.value = !isDark.value,
              icon: value
                  ? const Icon(Icons.dark_mode)
                  : const Icon(Icons.light_mode),
            ),
          );
        },
      ),
    );
  }
}
