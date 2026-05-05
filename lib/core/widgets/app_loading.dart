import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoading {
  static OverlayEntry? _entry;

  static void toggle({required BuildContext context, required bool isLoading}) {
    if (isLoading) {
      if (_entry != null) return;
      _entry = OverlayEntry(
        builder: (context) => Container(
          color: Theme.of(context).colorScheme.scrim,
          child: Center(
            child: SpinKitFadingCircle(
              color: Theme.of(context).colorScheme.primary,
              size: 50,
            ),
          ),
        ),
      );
      Overlay.of(context).insert(_entry!);
    } else {
      _entry?.remove();
      _entry = null;
    }
  }
}
