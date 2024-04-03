class LoginData {
  /// The username/phone/email of the user, required field for login
  /// (depends on the login method)
  /// For example, if the login method is email, then this field should be email
  /// If the login method is phone, then this field should be phone
  /// If the login method is username, then this field should be username
  final String name;

  /// The password/otp of the user, optional field for login (depends on the login method)
  /// For example, if the login method is email, then this field should be password
  /// If the login method is phone/email with otp, then this field should be otp
  /// If the login method is username, then this field should be password
  /// If the login method is social, then this field should be null
  final String? secret;

  LoginData({required this.name, this.secret});

  @override
  String toString() {
    return 'LoginData($name, $secret)';
  }

  @override
  bool operator ==(Object other) {
    if (other is LoginData) {
      return name == other.name && secret == other.secret;
    }
    return false;
  }

  @override
  int get hashCode => name.hashCode ^ secret.hashCode;
}
