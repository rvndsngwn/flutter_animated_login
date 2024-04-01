# Flutter Animated Login

[![Pub Version](https://img.shields.io/pub/v/flutter_animated_login?color=blue&style=plastic)](https://pub.dev/packages/flutter_animated_login)
[![GitHub Repo stars](https://img.shields.io/github/stars/rvndsngwn/flutter_animated_login?color=gold&style=plastic)](https://github.com/rvndsngwn/flutter_animated_login/stargazers)
[![GitHub Repo forks](https://img.shields.io/github/forks/rvndsngwn/flutter_animated_login?color=slateblue&style=plastic)](https://github.com/rvndsngwn/flutter_animated_login/fork)
[![GitHub Repo issues](https://img.shields.io/github/issues/rvndsngwn/flutter_animated_login?color=coral&style=plastic)](https://github.com/rvndsngwn/flutter_animated_login/issues)
[![GitHub Repo contributors](https://img.shields.io/github/contributors/rvndsngwn/flutter_animated_login?color=green&style=plastic)](https://github.com/rvndsngwn/flutter_animated_login/graphs/contributors)

A Flutter package to create a beautiful animated login screen with phone/email otp, password, and social login options. It also includes a phone number picker and country picker.

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
    loginType: LoginType.loginWithOTP,
    onLogin: (loginData) async {
        print(loginData);
    },
)
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## LICENSE

This project is licensed under the MIT license. See [LICENSE](LICENSE) for more information.
