import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animated_login/src/utils/extension.dart';
import 'package:flutter_animated_login/src/widget/button.dart';
import 'package:flutter_animated_login/src/widget/email_phone_field.dart';

import '../flutter_animated_login.dart';

class ForgotPassword extends StatefulWidget {
  final TextEditingController textController;
  final PageConfig pageConfig;

  // final bool navigateBack;
  //final ValueNotifier<int> nextPageNotifier;
  final Recovercallback onRecover;
  final ValueNotifier<bool> isFormValidNotifier;
  final LoginConfig config;

  final ValueNotifier<int> nextPageNotifier;
  const ForgotPassword({
    super.key,
    required this.nextPageNotifier,
    required this.onRecover,
    required this.textController,
    required this.isFormValidNotifier,
    required this.config,
    required this.pageConfig,
  });
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController controller;

  // bool _isRecover = false;

  @override
  void initState() {
    super.initState();
    controller = widget.textController;
    // textController = TextEditingController();
    // final texxt = textController.text;
    // textController.addListener(() {
    //   final text = textController.text;
    //   if (texxt.isEmptyOrNull || text.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
    //     print('valid');
    //     //_isPhoneNotifier.value = false;
    //   }
    //   //_isFormValidNotifier.value = text.isEmail;
    // });
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  Future<bool> submitRecover(
    String email,
    void Function() onSubmitCompleted,
  ) async {
    // verification logic here
    if (!email.isEmail) {
      return false;
    }
    await simulateRecoveryProcess();

    onSubmitCompleted();
    return true;
  }

  Future<void> simulateRecoveryProcess() async {
    // Simulate password recovery process
    await Future.delayed(const Duration(seconds: 3));
  }

  Widget _recoverNameField(double width) {
    return EmailPhoneTextField(
        isPhoneNotifier: ValueNotifier<bool>(false),
        isFormValidNotifier: ValueNotifier<bool>(false),
        config: const EmailPhoneTextFiledConfig(),
        controller: controller);
  }

  Widget _recoverButton(ThemeData theme) {
    // Define the 'constraints' variable
    return SignInButton(
      formNotifier: widget.isFormValidNotifier,
      onPressed: () async {
        bool recoveryResult = await submitRecover('ankit@gmail.com', () {
          print('button clicked');
        });
        if (recoveryResult) {
          context.success(
              'Password recovery link was sent to ${widget.textController.text} email.',
              description: null);
          print('sucess');
          Future.delayed(Duration(seconds: 2), () {
            widget.nextPageNotifier.value = 0;
          });
          //widget.nextPageNotifier.value = 0;
        } else {
          print('failed else');
          // widget.nextPageNotifier.value = 6;
          // Show error message
        }
        return null;
      },
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context)
            .size
            .width, // Set maximum width to screen width
      ),
      buttonText: 'Recover',
    );
    // MaterialButton(
    //   onPressed: null,
    //   child: Text('recover'),
    // );
  }

  Widget _buildBackButton(
    ThemeData theme,
  ) {
    return MaterialButton(
      onPressed: () {
        widget.nextPageNotifier.value = 0;
      },
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //textColor: loginTheme?.switchAuthTextColor ?? calculatedTextColor,
      child: const Text('BACK'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    theme.colorScheme.primary.withOpacity(0.1);
    final deviceSize = MediaQuery.of(context).size;
    final cardWidth = min(deviceSize.width * 0.75, 360.0);
    const cardPadding = 16.0;
    final textFieldWidth = cardWidth - cardPadding * 2;

    return PageWidget(
      config: widget.pageConfig,
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: FittedBox(
              child: Card(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: cardPadding,
                    top: cardPadding + 10.0,
                    right: cardPadding,
                    bottom: cardPadding,
                  ),
                  width: cardWidth,
                  alignment: Alignment.center,
                  child: Form(
                      child: Column(
                    children: [
                      Text(
                        "Reset Password here",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),
                      _recoverNameField(textFieldWidth),
                      const SizedBox(height: 20),
                      _recoverButton(theme),
                      const SizedBox(height: 20),
                      _buildBackButton(theme)
                    ],
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
