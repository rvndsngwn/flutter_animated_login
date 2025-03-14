import 'package:flutter/material.dart';
import 'package:flutter_animated_login/src/utils/extension.dart';

import '../../flutter_animated_login.dart';
import '../utils/loading_state.dart';
import '../utils/login_provider.dart';
import 'divider.dart';

class OAuthWidget extends StatelessWidget {
  /// The list of login providers for the oauth
  final List<LoginProvider>? providers;

  /// The terms and conditions for the login/signup page
  final Widget? termsAndConditions;

  /// The footer widget for the login/signup page
  final Widget? footerWidget;
  const OAuthWidget({
    super.key,
    this.providers,
    this.termsAndConditions,
    this.footerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (providers.isNotEmptyOrNull) ...[
          const SizedBox(height: 18),
          const DividerText(),
          const SizedBox(height: 12),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: providers?.map((provider) {
                final index = providers?.indexOf(provider) ?? 0;
                final length = providers?.length ?? 0;
                return Padding(
                  padding:
                      EdgeInsets.only(right: (index == length - 1) ? 0 : 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AutoLoadingButton(
                        transitionDuration: provider.transitionDuration,
                        onPressed: () async {
                          final result = await provider.callback.call();
                          if (context.mounted) {
                            if (result.isNotEmptyOrNull) {
                              context.error("Error", description: result);
                            }
                          }
                        },
                        style: provider.style ??
                            ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              iconSize: 24,
                            ),
                        loadingColor: provider.loadingColor,
                        loading: provider.loading,
                        key: ValueKey(provider.label),
                        child: Icon(provider.icon),
                      ),
                      if (provider.label != null) provider.label.orShrink,
                    ],
                  ),
                );
              }).toList() ??
              [],
        ),
        termsAndConditions.orShrink,
        footerWidget.orShrink,
      ],
    );
  }
}
