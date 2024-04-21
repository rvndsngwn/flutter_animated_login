import 'package:flutter/material.dart';

class PageConfig {
  /// The padding for the card
  final EdgeInsetsGeometry? cardPadding;

  /// The margin for the card
  final EdgeInsetsGeometry? cardMargin;

  /// The constraints for the card
  final BoxConstraints? cardConstraints;

  /// The decoration for the card
  final Decoration? cardDecoration;

  /// The begin alignment for the gradient
  final AlignmentGeometry begin;

  /// The end alignment for the gradient
  final AlignmentGeometry end;

  /// The colors for the gradient on the background
  final List<Color>? colors;

  /// The background widget for the page  (default is a gradient)
  /// If you want to use a custom background, you can use this property.
  /// When this property is set, the gradient is not shown.
  final Widget? background;

  /// The behavior for the keyboard dismiss
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  const PageConfig({
    this.cardPadding,
    this.cardMargin,
    this.cardConstraints,
    this.cardDecoration,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.colors,
    this.background,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  PageConfig copyWith({
    EdgeInsetsGeometry? cardPadding,
    EdgeInsetsGeometry? cardMargin,
    BoxConstraints? cardConstraints,
    Decoration? cardDecoration,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    List<Color>? colors,
    Widget? background,
    ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior,
  }) {
    return PageConfig(
      cardPadding: cardPadding ?? this.cardPadding,
      cardMargin: cardMargin ?? this.cardMargin,
      cardConstraints: cardConstraints ?? this.cardConstraints,
      cardDecoration: cardDecoration ?? this.cardDecoration,
      begin: begin ?? this.begin,
      end: end ?? this.end,
      colors: colors ?? this.colors,
      background: background ?? this.background,
      keyboardDismissBehavior:
          keyboardDismissBehavior ?? this.keyboardDismissBehavior,
    );
  }
}
