# Flutter Animated Login

[![Pub Version](https://img.shields.io/pub/v/flutter_animated_login?color=blue&style=plastic)](https://pub.dev/packages/flutter_animated_login)
[![GitHub Repo stars](https://img.shields.io/github/stars/rvndsngwn/flutter_animated_login?color=gold&style=plastic)](https://github.com/rvndsngwn/flutter_animated_login/stargazers)
[![GitHub Repo forks](https://img.shields.io/github/forks/rvndsngwn/flutter_animated_login?color=slateblue&style=plastic)](https://github.com/rvndsngwn/flutter_animated_login/fork)
[![GitHub Repo issues](https://img.shields.io/github/issues/rvndsngwn/flutter_animated_login?color=coral&style=plastic)](https://github.com/rvndsngwn/flutter_animated_login/issues)
[![GitHub Repo contributors](https://img.shields.io/github/contributors/rvndsngwn/flutter_animated_login?color=green&style=plastic)](https://github.com/rvndsngwn/flutter_animated_login/graphs/contributors)

A Flutter package to create a beautiful animated login screen with phone/email otp, password, and social login options. It also includes a phone number with country code picker.

## Screenshots

### Email OTP

<table>
<td><img src="https://raw.githubusercontent.com/rvndsngwn/flutter_animated_login/master/image-1.png" width=270 height=520 alt=""></td>
<td><img src="https://raw.githubusercontent.com/rvndsngwn/flutter_animated_login/master/image-2.png" width=270 height=520 alt=""></td>
</tr>
</table>

### Phone OTP

<table>
<td><img src="https://raw.githubusercontent.com/rvndsngwn/flutter_animated_login/master/image-3.png" width=270 height=520 alt=""></td>
<td><img src="https://raw.githubusercontent.com/rvndsngwn/flutter_animated_login/master/image-4.png" width=270 height=520 alt=""></td>
</tr>
</table>

### Dark Theme

<table>
<td><img src="https://raw.githubusercontent.com/rvndsngwn/flutter_animated_login/master/image-5.png" width=270 height=520 alt=""></td>
<td><img src="https://raw.githubusercontent.com/rvndsngwn/flutter_animated_login/master/image-6.png" width=270 height=520 alt=""></td>
</tr>
</table>

### Video Demo

<table>
<td><video width="270" height="520" controls>
  <source src="https://raw.githubusercontent.com/rvndsngwn/flutter_animated_login/master/video-1.mov" type="video/mp4">
</video></td>
</table>

## Installing

To use this package run this command:

```yaml
flutter pub add flutter_animated_login
```

Or, add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_animated_login: ^<latest_version>
```

Sometimes you may want to use the latest version of the package, instead of a published version. To do that, use the `git` syntax:

```yaml
dependencies:
  flutter_animated_login:
    git:
      url: git://github.com/rvndsngwn/flutter_animated_login.git
      ref: main
```

## How to Use

Simply create a `FlutterAnimatedLogin` widget, and pass the required params:

```dart
FlutterAnimatedLogin(
    onLogin: (loginData) async {
        print(loginData);
        return "";
    },
)
```

See the `example` directory for a complete sample app.

### Parameters of the MapLocationPicker

```dart
  /// The callback triggered after login
  final LoginCallback? onLogin;

  /// The callback triggered after signup
  final SignupCallback? onSignup;

  /// [VerifyCallback] triggered after the user has verified the OTP
  /// The result is an error message, callback successes if message is null
  final VerifyCallback? onVerify;

  /// [ResendOtpCallback] triggered after the user has resent the OTP
  final ResendOtpCallback? onResendOtp;

  /// The configuration for the login text field
  final LoginConfig loginConfig;

  /// The header widget for the login page
  final Widget? headerWidget;

  /// The footer widget for the login page
  final Widget? footerWidget;

  /// The list of login providers for the oauth
  final List<LoginProvider>? providers;

  /// The login type, default is [LoginType.loginWithOTP]
  final LoginType loginType;

  /// The configuration for the verify page
  final VerifyConfig verifyConfig;

  /// The terms and conditions for the login/signup page
  final TextSpan? termsAndConditions;
```

## LICENSE

This project is licensed under the MIT license. See [LICENSE](LICENSE) for more information.

## You can help me by Donating

[![BuyMeACoffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/rvndsngwn) [![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://paypal.me/rvndsngwn?country.x=IN&locale.x=en_GB) [![Ko-Fi](https://img.shields.io/badge/Ko--fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/rvndsngwn)

## 👨🏻‍💻 Contribute to the project

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

[![GitHub](https://img.shields.io/badge/GitHub-0f0f0f?style=for-the-badge&logo=github&logoColor=white)](https://github.com/rvndsngwn/flutter_animated_login)

## 👨🏻‍💻Contributors

<a href="https://github.com/rvndsngwn/flutter_animated_login/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=rvndsngwn/flutter_animated_login" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
