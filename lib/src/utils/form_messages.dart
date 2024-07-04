class FormMessages {
  final String signUp;
  final String signIn;
  final String createAccountLong;
  final String confirmPassword;
  final String reEnterPassword;
  final String passwordsUnmatched;
  final String invalidFormData;

  final String passwordIsrequired;
  final String enterYourPassword;
  final String password;

  final String loginFieldEnterPhone;
  final String loginFieldEnterEmailOrPhone;
  final String phone;
  final String emailOrPhone;
  final String loginFieldEnterPhoneValidatorYour;
  final String loginFieldEnterPhoneValidatorA;

  const FormMessages({
    this.signUp = 'Create Account',
    this.signIn = 'Sign In',
    this.createAccountLong = 'Create an account to get started with our app.',
    this.confirmPassword = 'Confirm Password*',
    this.reEnterPassword = 'Re-enter your password',
    this.passwordsUnmatched = 'Password does not match',
    this.invalidFormData = 'Invalid form data, fill all required fields',
    this.passwordIsrequired = 'Password is required',
    this.enterYourPassword = 'Enter your password',
    this.password = 'Password*',
    this.loginFieldEnterPhone = 'Enter your phone',
    this.loginFieldEnterEmailOrPhone = 'Enter your email or phone',
    this.phone = 'Phone*',
    this.emailOrPhone = 'Email or Phone*',
    this.loginFieldEnterPhoneValidatorYour =
        'Please enter your email or phone number',
    this.loginFieldEnterPhoneValidatorA =
        'Please enter a valid email or phone number',
  });
}
