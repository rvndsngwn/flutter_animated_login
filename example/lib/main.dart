import 'package:flutter/material.dart';
import 'package:flutter_animated_login/flutter_animated_login.dart';
import 'package:go_router/go_router.dart';

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
      builder: (context, value, child) => MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Animated Login',
        themeMode: value ? ThemeMode.dark : ThemeMode.light,
        theme: value ? ThemeData.dark() : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Scaffold(
            body: child,
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

final GoRouter router = GoRouter(
  initialLocation: '/signin',
  routes: [
    GoRoute(
      path: '/signin',
      pageBuilder: (context, state) {
        return CustomSlideTransition(
          key: state.pageKey,
          child: FlutterAnimatedLogin(
            onPressed: () => Future.delayed(
              const Duration(seconds: 2),
              () => context.go('/verify-otp'),
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: '/verify-otp',
      pageBuilder: (context, state) {
        return CustomSlideTransition(
          key: state.pageKey,
          child: FlutterAnimatedVerify(
            onPressed: () => Future.delayed(
              const Duration(seconds: 2),
              () => context.go('/signin'),
            ),
          ),
        );
      },
    ),
  ],
);

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 10),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
