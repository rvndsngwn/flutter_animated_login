library;

import 'package:flutter/material.dart';

export 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
export 'package:pinput/pinput.dart';

export 'src/login.dart';
export 'src/utils/form_messages.dart';
export 'src/utils/login_config.dart';
export 'src/utils/login_data.dart';
export 'src/utils/login_provider.dart';
export 'src/utils/page_config.dart';
export 'src/utils/password_config.dart';
export 'src/utils/reset_config.dart';
export 'src/utils/signup_config.dart';
export 'src/utils/signup_data.dart';
export 'src/utils/verify_config.dart';
export 'src/verify.dart';
export 'src/widget/page.dart';
export 'src/widget/title.dart';

class TextFieldController extends TextEditingController {
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  bool get isDisposed => _isDisposed;
}
