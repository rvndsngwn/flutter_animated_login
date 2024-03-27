import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

extension IntExtinction on int {
  /// Returns the double value of the integer. 0 => 00, 1 => 01, 10 => 10
  String get toDigital => this < 10 ? '0$this' : '$this';
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
