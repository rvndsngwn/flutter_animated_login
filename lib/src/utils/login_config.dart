import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intl_phone_field/countries.dart';
import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';

import '../widget/title.dart';
import 'password_config.dart';

class LoginConfig {
  final Widget? logo;
  final Widget? header;
  final Widget? footer;
  final String? title;
  final String? subtitle;
  final TitleWidget? titleWidget;
  final Widget? buttonText;
  final TextStyle? buttonTextStyle;
  final String? termsAndConditions;
  final String? privacyPolicy;
  final EmailPhoneTextFiledConfig textFiledConfig;
  final PasswordTextFiledConfig passwordConfig;

  const LoginConfig({
    this.logo,
    this.header,
    this.footer,
    this.title,
    this.subtitle,
    this.titleWidget,
    this.buttonText,
    this.buttonTextStyle,
    this.termsAndConditions,
    this.privacyPolicy,
    this.textFiledConfig = const EmailPhoneTextFiledConfig(),
    this.passwordConfig = const PasswordTextFiledConfig(),
  });

  LoginConfig copyWith({
    Widget? logo,
    Widget? header,
    Widget? footer,
    String? title,
    String? subtitle,
    TitleWidget? titleWidget,
    Widget? buttonText,
    TextStyle? buttonTextStyle,
    String? termsAndConditions,
    String? privacyPolicy,
    EmailPhoneTextFiledConfig? textFiledConfig,
    PasswordTextFiledConfig? passwordConfig,
  }) {
    return LoginConfig(
      logo: logo ?? this.logo,
      header: header ?? this.header,
      footer: footer ?? this.footer,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      titleWidget: titleWidget ?? this.titleWidget,
      buttonText: buttonText ?? this.buttonText,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      textFiledConfig: textFiledConfig ?? this.textFiledConfig,
      passwordConfig: passwordConfig ?? this.passwordConfig,
    );
  }
}

class EmailPhoneTextFiledConfig {
  /// The TextFormField key.
  final GlobalKey<FormFieldState>? formFieldKey;

  /// Whether to hide the text being edited (e.g., for passwords).
  final bool obscureText;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? textAlignVertical;
  final VoidCallback? onTap;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;
  final FormFieldSetter<({PhoneNumber? number, String? value})>? onSaved;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted], [onSelectionChanged]:
  ///    which are more specialized input change notifications.
  final ValueChanged<({PhoneNumber? number, String? value})>? onChanged;

  final ValueChanged<Country>? onCountryChanged;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field.  The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [EditableText.onSubmitted] for an example of how to handle moving to
  ///    the next/previous field when using [TextInputAction.next] and
  ///    [TextInputAction.previous] for [textInputAction].
  final void Function(String)? onSubmitted;

  /// If false the widget is "disabled": it ignores taps, the [TextFormField]'s
  /// [decoration] is rendered in grey,
  /// [decoration]'s [InputDecoration.counterText] is set to `""`,
  /// and the drop down icon is hidden no matter [showDropdownIcon] value.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool enabled;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.brightness].
  final Brightness? keyboardAppearance;

  /// Initial Value for the field.
  /// This property can be used to pre-fill the field.
  final String? initialValue;

  final String languageCode;

  /// 2 letter ISO Code or country dial code.
  ///
  /// ```dart
  /// initialCountryCode: 'IN', // India
  /// initialCountryCode: '+225', // Côte d'Ivoire
  /// ```
  final String? initialCountryCode;

  /// List of Country to display see countries.dart for format
  final List<Country>? countries;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration? decoration;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle? style;

  /// Disable view Min/Max Length check
  final bool? disableLengthCheck;

  /// Won't work if [enabled] is set to `false`.
  final bool showDropdownIcon;

  final BoxDecoration dropdownDecoration;

  /// The style use for the country dial code.
  final TextStyle? dropdownTextStyle;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  /// The input formatters to use for the text field.
  /// By default, the input formatters are [FilteringTextInputFormatter.digitsOnly].
  /// By default, the input formatters are [LengthLimitingTextInputFormatter] with the length of the selected country's max length.
  /// If you want to change InputFormatter, you can pass your own list of [TextInputFormatter].
  final List<TextInputFormatter>? inputFormatters;

  /// The text that describes the search input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on top of the input field (i.e., at the same location on the screen where text may be entered in the input field).
  /// When the input field receives focus (or if the field is non-empty), the label moves above (i.e., vertically adjacent to) the input field.
  final String searchText;

  /// Position of an icon [leading, trailing]
  final IconPosition dropdownIconPosition;

  /// Icon of the drop down button.
  ///
  /// Default is [Icon(Icons.arrow_drop_down)]
  final Icon dropdownIcon;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Autovalidate mode for text form field.
  ///
  /// If [AutovalidateMode.onUserInteraction], this FormField will only auto-validate after its content changes.
  /// If [AutovalidateMode.always], it will auto-validate even without user interaction.
  /// If [AutovalidateMode.disabled], auto-validation will be disabled.
  ///
  /// Defaults to [AutovalidateMode.onUserInteraction].
  final AutovalidateMode? autovalidateMode;

  /// Whether to show or hide country flag.
  ///
  /// Default value is `true`.
  final bool showCountryFlag;

  /// Message to be displayed on autoValidate error
  ///
  /// Default value is `Invalid Mobile Number`.
  final String? invalidMessage;

  /// The color of the cursor.
  final Color? cursorColor;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// How rounded the corners of the cursor should be.
  final Radius? cursorRadius;

  /// How thick the cursor will be.
  final double cursorWidth;

  /// Whether to show cursor.
  final bool? showCursor;

  /// The padding of the Flags Button.
  ///
  /// The amount of insets that are applied to the Flags Button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsetsGeometry flagsButtonPadding;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Optional set of styles to allow for customizing the country search
  /// & pick dialog
  final PickerDialogStyle? pickerDialogStyle;

  /// The margin of the country selector button.
  ///
  /// The amount of space to surround the country selector button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsets flagsButtonMargin;

  /// Enable the autofill hint for phone number.
  final Iterable<String>? autofillHints;

  /// If null, default magnification configuration will be used.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// The prefix icon to display in the input field.
  /// This icon will be placed before the input field and will be displayed in the decoration.
  /// If null, phone country dropdown will be displayed.
  /// If not null, phone country dropdown will be hidden.
  final Widget? prefixIcon;

  /// The type of dialog to show when the country selector button is pressed.
  /// If [DialogType.showDialog], a dialog will be shown.
  /// If [DialogType.showModalBottomSheet], a modal bottom sheet will be shown.
  /// Default is [DialogType.showDialog].
  final DialogType dialogType;

  /// The maximum number of characters (Unicode scalar values) to allow in the text field.
  final int? maxLength;

  /// The minimum number of lines to occupy when the content spans fewer lines.
  final int? minLines;

  /// The maximum number of lines to occupy when the content spans more lines.
  final int? maxLines;

  /// Expands the field to fill the parent.
  final bool expands;

  /// The strategy to use when the user has inserted more characters into the text field than are allowed by the current [maxLength].
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Builds the counter widget.
  final InputCounterWidgetBuilder? buildCounter;

  /// Called when the user submits data.
  final void Function()? onEditingComplete;

  const EmailPhoneTextFiledConfig({
    this.formFieldKey,
    this.initialCountryCode,
    this.languageCode = 'en',
    this.autofillHints,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.textAlignVertical,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.decoration,
    this.style,
    this.dropdownTextStyle,
    this.onSubmitted,
    this.onChanged,
    this.countries,
    this.onCountryChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance,
    @Deprecated('Use searchFieldInputDecoration of PickerDialogStyle instead')
    this.searchText = 'Search country',
    this.dropdownIconPosition = IconPosition.leading,
    this.dropdownIcon = const Icon(Icons.arrow_drop_down),
    this.autofocus = false,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.showCountryFlag = true,
    this.cursorColor,
    this.disableLengthCheck,
    this.flagsButtonPadding = EdgeInsets.zero,
    this.invalidMessage = 'Invalid Mobile Number',
    this.cursorHeight,
    this.cursorRadius = Radius.zero,
    this.cursorWidth = 2.0,
    this.showCursor = true,
    this.pickerDialogStyle,
    this.flagsButtonMargin = EdgeInsets.zero,
    this.magnifierConfiguration,
    this.prefixIcon,
    this.dialogType = DialogType.showDialog,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.expands = false,
    this.maxLengthEnforcement,
    this.buildCounter,
    this.onEditingComplete,
  });

  EmailPhoneTextFiledConfig copyWith({
    GlobalKey<FormFieldState>? formFieldKey,
    String? initialCountryCode,
    String? languageCode,
    List<String>? autofillHints,
    bool? obscureText,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    VoidCallback? onTap,
    bool? readOnly,
    String? initialValue,
    TextInputType? keyboardType,
    TextEditingController? controller,
    FocusNode? focusNode,
    InputDecoration? decoration,
    TextStyle? style,
    TextStyle? dropdownTextStyle,
    void Function(String)? onSubmitted,
    ValueChanged<({PhoneNumber? number, String? value})>? onChanged,
    List<Country>? countries,
    ValueChanged<Country>? onCountryChanged,
    FormFieldSetter<({PhoneNumber? number, String? value})>? onSaved,
    bool? showDropdownIcon,
    BoxDecoration? dropdownDecoration,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    Brightness? keyboardAppearance,
    String? searchText,
    IconPosition? dropdownIconPosition,
    Icon? dropdownIcon,
    bool? autofocus,
    AutovalidateMode? autovalidateMode,
    bool? showCountryFlag,
    Color? cursorColor,
    bool? disableLengthCheck,
    EdgeInsetsGeometry? flagsButtonPadding,
    String? invalidMessage,
    double? cursorHeight,
    Radius? cursorRadius,
    double? cursorWidth,
    bool? showCursor,
    PickerDialogStyle? pickerDialogStyle,
    EdgeInsets? flagsButtonMargin,
    TextMagnifierConfiguration? magnifierConfiguration,
    Widget? prefixIcon,
    DialogType? dialogType,
    int? maxLength,
    int? minLines,
    int? maxLines,
    bool? expands,
    MaxLengthEnforcement? maxLengthEnforcement,
    InputCounterWidgetBuilder? buildCounter,
    void Function()? onEditingComplete,
    TextInputAction? textInputAction,
  }) {
    return EmailPhoneTextFiledConfig(
      formFieldKey: formFieldKey ?? this.formFieldKey,
      initialCountryCode: initialCountryCode ?? this.initialCountryCode,
      languageCode: languageCode ?? this.languageCode,
      autofillHints: autofillHints ?? this.autofillHints,
      obscureText: obscureText ?? this.obscureText,
      textAlign: textAlign ?? this.textAlign,
      textAlignVertical: textAlignVertical ?? this.textAlignVertical,
      onTap: onTap ?? this.onTap,
      readOnly: readOnly ?? this.readOnly,
      initialValue: initialValue ?? this.initialValue,
      keyboardType: keyboardType ?? this.keyboardType,
      controller: controller ?? this.controller,
      focusNode: focusNode ?? this.focusNode,
      decoration: decoration ?? this.decoration,
      style: style ?? this.style,
      dropdownTextStyle: dropdownTextStyle ?? this.dropdownTextStyle,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      onChanged: onChanged ?? this.onChanged,
      countries: countries ?? this.countries,
      onCountryChanged: onCountryChanged ?? this.onCountryChanged,
      onSaved: onSaved ?? this.onSaved,
      showDropdownIcon: showDropdownIcon ?? this.showDropdownIcon,
      dropdownDecoration: dropdownDecoration ?? this.dropdownDecoration,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      enabled: enabled ?? this.enabled,
      keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
      dropdownIconPosition: dropdownIconPosition ?? this.dropdownIconPosition,
      dropdownIcon: dropdownIcon ?? this.dropdownIcon,
      autofocus: autofocus ?? this.autofocus,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      showCountryFlag: showCountryFlag ?? this.showCountryFlag,
      cursorColor: cursorColor ?? this.cursorColor,
      disableLengthCheck: disableLengthCheck ?? this.disableLengthCheck,
      flagsButtonPadding: flagsButtonPadding ?? this.flagsButtonPadding,
      invalidMessage: invalidMessage ?? this.invalidMessage,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      showCursor: showCursor ?? this.showCursor,
      pickerDialogStyle: pickerDialogStyle ?? this.pickerDialogStyle,
      flagsButtonMargin: flagsButtonMargin ?? this.flagsButtonMargin,
      magnifierConfiguration:
          magnifierConfiguration ?? this.magnifierConfiguration,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      dialogType: dialogType ?? this.dialogType,
      maxLength: maxLength ?? this.maxLength,
      minLines: minLines ?? this.minLines,
      maxLines: maxLines ?? this.maxLines,
      expands: expands ?? this.expands,
      maxLengthEnforcement: maxLengthEnforcement ?? this.maxLengthEnforcement,
      buildCounter: buildCounter ?? this.buildCounter,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      textInputAction: textInputAction ?? this.textInputAction,
    );
  }
}
