import 'package:flutter/material.dart';

class PersistentScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, ScrollableDetails details) {
    // This ensures that the scrollbar is always visible
    return child;
  }

  @override
  Scrollbar buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return Scrollbar(
      thumbVisibility: true, // Always show the scrollbar
      child: child,
    );
  }
}
