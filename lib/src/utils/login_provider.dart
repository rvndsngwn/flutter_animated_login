import 'package:flutter/material.dart';
import 'package:flutter_animated_login/flutter_animated_login.dart';

class LoginProvider {
  /// The icon shown on the provider button
  ///
  /// NOTE: Both [button] and [icon] can be added to [LoginProvider],
  /// but [button] will take preference over [icon]
  final IconData icon;

  /// The label shown under the provider
  final String? label;

  /// A Function called when the provider button is pressed.
  /// It must return null on success, or a `String` describing the error on failure.
  final ProviderAuthCallback callback;

  /// Optional
  ///
  /// Requires that the `additionalSignUpFields` argument is passed to `FlutterLogin`.
  /// When given, this callback must return a `Future<bool>`.
  /// If it evaluates to `true` the card containing the additional signup fields is shown, right after the evaluation of `callback`.
  /// If not given the default behaviour is not to show the signup card.
  final ProviderNeedsSignUpCallback? providerNeedsSignUpCallback;

  /// Enable or disable the animation of the button.
  ///
  /// Default: true
  final bool animated;

  /// Provide a list of errors to not display when a login has failed.
  /// For example, if the login is cancelled and you don't want to show a error
  /// message that the login is cancelled. If you provide the error message to this list
  /// the error is not shown
  ///
  /// Default: null
  final List<String>? errorsToExcludeFromErrorMessage;

  const LoginProvider({
    required this.icon,
    required this.callback,
    this.errorsToExcludeFromErrorMessage,
    this.label = '',
    this.providerNeedsSignUpCallback,
    this.animated = true,
  });
}
