import 'package:flutter/material.dart';
import 'package:flutter_animated_login/flutter_animated_login.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';


class FlutterAnimatedLogin extends StatefulWidget {
  final Future<void> Function()? onPressed;
  const FlutterAnimatedLogin({
    super.key,
    this.onPressed,
  });

  @override
  State<FlutterAnimatedLogin> createState() => _FlutterAnimatedLoginState();
}

class _FlutterAnimatedLoginState extends State<FlutterAnimatedLogin> {
  final TextEditingController textController = TextEditingController();
  final ValueNotifier<bool> isPhone = ValueNotifier(false);
  bool isStartTyping = false;
  final ValueNotifier<bool> isFormValid = ValueNotifier(false);

  @override
  void initState() {
    textController.addListener(() {
      final text = textController.text;
      if (text.isNotEmpty) {
        /// Check if the text is a international phone number
        isPhone.value =
            text.contains(RegExp(r'^[+]?[0-9]+$')) && text.length > 5;
      } else if (text.isEmpty || text.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
        isPhone.value = false;
      }
      if (textController.text.isNotEmpty) {
        isStartTyping = true;
      }
      isFormValid.value =
          text.contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'));
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    isPhone.dispose();
    isFormValid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return PageWidget(
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TitleWidget(),
          ValueListenableBuilder(
            valueListenable: isPhone,
            builder: (context, value, child) {
              return value
                  ? IntlPhoneField(
                      controller: textController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter your phone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                        isFormValid.value = phone.isValidNumber();
                      },
                    )
                  : TextFormField(
                      autofocus: isStartTyping,
                      controller: textController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email or phone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      onChanged: (text) {
                        print(text);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email or phone';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    );
            },
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: isFormValid,
            builder: (context, value, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: constraints.maxWidth >= 600
                    ? 200
                    : constraints.maxWidth * 0.5,
                child: FilledAutoLoadingButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      constraints.maxWidth >= 600
                          ? 200
                          : constraints.maxWidth * 0.5,
                      55,
                    ),
                    textStyle: textTheme.titleLarge,
                  ),
                  onPressed: value ? widget.onPressed : null,
                  child: const Text("Continue"),
                ),
              );
            },
          ),
          OAuthWidget(onPressed: widget.onPressed),
        ],
      ),
    );
  }
}
