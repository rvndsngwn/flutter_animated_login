import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

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

extension Toastification on BuildContext {
  ToastificationItem success(String title, {String? description}) =>
      toastification.show(
        context: this,
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        title: Text(title),
        description: description != null ? Text(description) : null,
        alignment: Alignment.bottomCenter,
        autoCloseDuration: const Duration(seconds: 4),
        applyBlurEffect: true,
        showProgressBar: false,
      );

  ToastificationItem info(String title, {String? description}) =>
      toastification.show(
        context: this,
        type: ToastificationType.info,
        style: ToastificationStyle.flat,
        title: Text(title),
        description: description != null ? Text(description) : null,
        alignment: Alignment.bottomCenter,
        autoCloseDuration: const Duration(seconds: 4),
        applyBlurEffect: true,
        showProgressBar: false,
      );

  ToastificationItem error(String title, {String? description}) =>
      toastification.show(
        context: this,
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: Text(title),
        description: description != null ? Text(description) : null,
        alignment: Alignment.bottomCenter,
        autoCloseDuration: const Duration(seconds: 4),
        applyBlurEffect: true,
        showProgressBar: false,
      );

  ToastificationItem warning(String title, {String? description}) =>
      toastification.show(
        context: this,
        type: ToastificationType.warning,
        style: ToastificationStyle.flat,
        title: Text(title),
        description: description != null ? Text(description) : null,
        alignment: Alignment.bottomCenter,
        autoCloseDuration: const Duration(seconds: 4),
        applyBlurEffect: true,
        showProgressBar: false,
      );
}
