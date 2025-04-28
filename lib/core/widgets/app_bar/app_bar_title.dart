import 'package:flutter/material.dart';
import 'package:tadamon/core/config/fonts/fonts.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override

  /// Returns an [AnimatedSwitcher] which displays the [title] within a [Text]
  /// widget. When the [title] changes, the widget is animated out by sliding
  /// upwards and fading out, before the new widget is animated in by sliding
  /// downwards and fading in. The animation is curve is a ease-in-out curve.
  ///
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 550),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: Text(
        title,
        key: ValueKey<String>(title),
        style: AppTextStyle.headline2(context).copyWith(color: Colors.white),
      ),
    );
  }
}
