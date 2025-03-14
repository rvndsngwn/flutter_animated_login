import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_login/flutter_animated_login.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Flutter Animated Login',
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

ValueNotifier<bool> loginTypeNotifier = ValueNotifier<bool>(true);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginDemoApp(),
              ),
            );
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}

class LoginDemoApp extends StatefulWidget {
  const LoginDemoApp({super.key});

  @override
  State<LoginDemoApp> createState() => _LoginDemoAppState();
}

class _LoginDemoAppState extends State<LoginDemoApp> {
  late TextFieldController _controller;
  late TextFieldController _otpController;

  @override
  void initState() {
    _controller = TextFieldController();
    _otpController = TextFieldController();
    if (kDebugMode) {
      _controller.text = '7012345678';
      _otpController.text = '123452';
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.isDisposed ? null : _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: loginTypeNotifier,
      builder: (context, value, child) => Scaffold(
        floatingActionButton: FilledButton(
          onPressed: () {
            loginTypeNotifier.value = !loginTypeNotifier.value;
          },
          child: value
              ? const Text("Login with OTP")
              : const Text("Login with Password"),
        ),
        body: FlutterAnimatedLogin(
          loginType: value ? LoginType.password : LoginType.otp,
          onLogin: (loginData) async {
            if (loginData.name == '+917012345678') {
              final result = await Future.delayed(
                const Duration(seconds: 2),
                () => '',
              );
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              TextInput.finishAutofillContext();
              return result;
            } else {
              return 'Invalid phone number, please try again.';
            }
          },
          onVerify: (otp) async {
            if (otp.secret == '123456') {
              final result = await Future.delayed(
                const Duration(seconds: 2),
                () => '',
              );
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              TextInput.finishAutofillContext();
              return result;
            } else {
              return 'Invalid OTP, please try again.';
            }
          },
          loginConfig: LoginConfig(
            title: 'Mohesu Enterprises',
            subtitle: 'Let\'s Sign In',
            textFiledConfig: EmailPhoneTextFiledConfig(
              controller: _controller,
            ),
          ),
          verifyConfig: VerifyConfig(
            textFiledConfig: OtpTextFiledConfig(
              controller: _otpController,
            ),
          ),
          providers: [
            LoginProvider(
              icon: Icons.reddit,
              label: const Text('Reddit'),
              callback: () async {
                await Future.delayed(const Duration(seconds: 3), () {
                  print('Reddit login');
                });
                return "";
              },
            ),
            LoginProvider(
              icon: Icons.apple,
              label: const Text('Apple'),
              callback: () async {
                return "";
              },
            ),
            LoginProvider(
              icon: Icons.facebook,
              label: const Text('Facebook'),
              callback: () async {
                return "";
              },
            ),
          ],
        ),
      ),
    );
  }
}
