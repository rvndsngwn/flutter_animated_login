import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';
import 'package:signals/signals.dart';

extension IntExtinction on int {
  /// Returns the double value of the integer. 0 => 00, 1 => 01, 10 => 10
  String get toDigital => this < 10 ? '0$this' : '$this';
}

extension StringExtinction on String? {
  /// Returns true if [this] is either null or empty string.
  bool get isEmptyOrNull {
    final value = this;
    return value == null || value.isEmpty;
  }

  /// Returns true if [this] is neither null nor empty string.
  bool get isNotEmptyOrNull {
    final value = this;
    return value != null && value.isNotEmpty;
  }

  /// Alias for [isNotEmptyOrNull]
  bool get hasContent => isNotEmptyOrNull;

  /// Returns [this] if it is not null, otherwise returns empty string.
  String get orEmpty => this ?? '';

  /// Returns true if [this] is a valid email address.
  bool get isEmail =>
      isNotEmptyOrNull &&
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this!);

  /// Returns true if [this] is a valid international phone number.
  bool get isIntlPhoneNumber =>
      isNotEmptyOrNull && RegExp(r'^[+]?[0-9]+$').hasMatch(this!);

  /// Returns true if [this] is a valid phone number.
  bool get isPhoneNumber =>
      isNotEmptyOrNull && RegExp(r'^[0-9]+$').hasMatch(this!);
}

extension ArrayExtinction<T> on List<T>? {
  /// Returns true if [this] is neither null or empty list.
  bool get isNotEmptyOrNull {
    final value = this;
    return value != null && value.isNotEmpty;
  }

  /// Returns true if [this] is either null or empty list.
  bool get isEmptyOrNull {
    final value = this;
    return value == null || value.isEmpty;
  }
}

extension WidgetExtinction on Widget? {
  /// Returns [this] if it is not null, otherwise returns [SizedBox.shrink].
  Widget get orShrink => this ?? const SizedBox.shrink();

  bool get isNotNull => this != null;

  bool get isNull => this == null;
}

// extension Toastification on BuildContext {
//   ToastificationItem success(String title, {String? description}) =>
//       toastification.show(
//         context: this,
//         type: ToastificationType.success,
//         style: ToastificationStyle.flat,
//         title: Text(title),
//         description: description != null ? Text(description) : null,
//         alignment: Alignment.topRight,
//         autoCloseDuration: const Duration(seconds: 4),
//         applyBlurEffect: true,
//         showProgressBar: false,
//       );

//   ToastificationItem info(String title, {String? description}) =>
//       toastification.show(
//         context: this,
//         type: ToastificationType.info,
//         style: ToastificationStyle.flat,
//         title: Text(title),
//         description: description != null ? Text(description) : null,
//         alignment: Alignment.topRight,
//         autoCloseDuration: const Duration(seconds: 4),
//         applyBlurEffect: true,
//         showProgressBar: false,
//       );

//   ToastificationItem error(String title, {String? description}) =>
//       toastification.show(
//         context: this,
//         type: ToastificationType.error,
//         style: ToastificationStyle.flat,
//         title: Text(title),
//         description: description != null ? Text(description) : null,
//         alignment: Alignment.topRight,
//         autoCloseDuration: const Duration(seconds: 4),
//         applyBlurEffect: true,
//         showProgressBar: false,
//       );

//   ToastificationItem warning(String title, {String? description}) =>
//       toastification.show(
//         context: this,
//         type: ToastificationType.warning,
//         style: ToastificationStyle.flat,
//         title: Text(title),
//         description: description != null ? Text(description) : null,
//         alignment: Alignment.topRight,
//         autoCloseDuration: const Duration(seconds: 4),
//         applyBlurEffect: true,
//         showProgressBar: false,
//       );
// }

extension Tost on BuildContext {
  void success(String title, {String? description}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: ListTile(
          title: Text(title),
          subtitle: description != null ? Text(description) : null,
          textColor: Colors.white,
        ),
        backgroundColor: Colors.green.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        showCloseIcon: true,
      ),
    );
  }

  void error(String title, {String? description}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: ListTile(
          title: Text(title),
          subtitle: description != null ? Text(description) : null,
          textColor: Colors.white,
        ),
        backgroundColor: Colors.red.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        showCloseIcon: true,
      ),
    );
  }

  void info(String title, {String? description}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: ListTile(
          title: Text(title),
          subtitle: description != null ? Text(description) : null,
          textColor: Colors.white,
        ),
        backgroundColor: Colors.blue.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        showCloseIcon: true,
      ),
    );
  }

  void warning(String title, {String? description}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: ListTile(
          title: Text(title),
          subtitle: description != null ? Text(description) : null,
          textColor: Colors.white,
        ),
        backgroundColor: Colors.orange.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        showCloseIcon: true,
      ),
    );
  }
}

@protected
final isPhoneNotifier = signal(false);

@protected
final isFormValidNotifier = signal(false);

@protected
final nextPageNotifier = signal(0);

@protected
final usernameNotifier = signal(
  PhoneNumber(
    countryISOCode: "",
    countryCode: "",
    number: "",
  ),
  debugLabel: 'Username',
);

class AnimatedStack<T extends int> extends StatefulWidget {
  const AnimatedStack({
    super.key,
    required this.value,
    required this.values,
    required this.builder,
    this.duration = const Duration(milliseconds: 300),
    this.switchInCurve = Curves.easeIn,
    this.switchOutCurve = Curves.easeOut,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
  });

  final T value;
  final List<T> values;
  final Widget Function(BuildContext context, T value) builder;
  final Duration duration;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final Widget Function(Widget child, Animation<double> animation)
      transitionBuilder;

  @override
  State<AnimatedStack<T>> createState() => _AnimatedStackState<T>();
}

class _AnimatedStackState<T extends int> extends State<AnimatedStack<T>> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.duration,
      switchInCurve: widget.switchInCurve,
      switchOutCurve: widget.switchOutCurve,
      transitionBuilder: widget.transitionBuilder,
      child: KeyedSubtree(
        key: ValueKey(widget.value),
        child: widget.builder(context, widget.value),
      ),
    );
  }
}
