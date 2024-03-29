import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  final Widget? Function(BuildContext context, BoxConstraints constraints)?
      builder;
  const PageWidget({
    super.key,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            constraints: const BoxConstraints(maxWidth: 600),
            margin: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: isMobile
                  ? null
                  : const [
                      BoxShadow(
                        blurRadius: 100,
                        spreadRadius: 1,
                      ),
                    ],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: isMobile ? 0 : 40,
                ),
                child: builder?.call(context, constraints),
              ),
            ),
          ),
        );
      },
    );
  }
}
