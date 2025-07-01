import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/config/const/sensei_const.dart';
import '../../../../../core/config/fonts/fonts.dart';
import '../../../../../generated/l10n.dart';

class HomeTip extends StatefulWidget {
  const HomeTip({super.key});

  @override
  HomeTipState createState() => HomeTipState();
}

class HomeTipState extends State<HomeTip> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  /// Initializes the state of the widget.
  ///
  /// This is called when the widget is inserted into the tree.
  ///
  /// It initializes the animation controller and the animation object,
  /// and then starts the animation by calling [_controller.forward].
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  /// When the close button is pressed, this function is called.
  ///
  /// It will call [HapticFeedback.vibrate] to generate a haptic feedback,
  /// and then reverse the animation by calling [_controller.reverse].
  ///
  /// After the animation is finished, it will call [setState] to reset
  /// the animation value to 0.0.
  void _onClosePressed() {
    HapticFeedback.vibrate();
    _controller.reverse().then((_) {
      setState(() {
        _controller.value = 0.0;
      });
    });
  }

  @override
  /// Disposes of the animation controller and calls [super.dispose].
  ///
  /// This is called when the widget is removed from the tree.
  ///
  /// It is important to call [dispose] to free up resources when the widget
  /// is no longer needed.
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  /// Returns a [FadeTransition] widget with a [SizeTransition] widget as child.
  ///
  /// The [FadeTransition] widget is configured with the [_animation] as opacity.
  ///
  /// The [SizeTransition] widget is configured with the [_animation] as sizeFactor,
  /// and an [axisAlignment] of -1.0.
  ///
  /// The [SizeTransition] widget has a [GestureDetector] widget as child,
  /// which is configured with an [onDoubleTap] callback that calls [_onClosePressed].
  ///
  /// The [GestureDetector] widget has a [Container] widget as child, which is
  /// configured with a margin of [SenseiConst.margin] on the bottom only, and
  /// a padding of [SenseiConst.padding] on all sides.
  ///
  /// The [Container] widget has a [ListTile] widget as child, which is
  /// configured with a subtitleTextStyle of a [TextStyle] with a color of
  /// [Theme.of(context).colorScheme.onSecondaryContainer].
  ///
  /// The [ListTile] widget has an [Icon] widget as leading, which is
  /// configured with an [Icons.lightbulb_outline_rounded] icon, a size of
  /// [SenseiConst.iconSize], and a color of
  /// [Theme.of(context).colorScheme.onSecondaryContainer].
  ///
  /// The [ListTile] widget has a [Text] widget as title, which is configured
  /// with the [S.of(context).AppName] text, and a style of a [TextStyle] with
  /// a color of [Theme.of(context).colorScheme.onSecondaryContainer].
  ///
  /// The [ListTile] widget has a [Text] widget as subtitle, which is
  /// configured with the [S.of(context).AppDescription] text.
  Widget build(final BuildContext context) => FadeTransition(
      opacity: _animation,
      child: SizeTransition(
        sizeFactor: _animation,
        axisAlignment: -1.0,
        child: GestureDetector(
          onDoubleTap: _onClosePressed,
          child: Container(
            margin: const EdgeInsets.only(bottom: SenseiConst.margin),
            padding: const EdgeInsets.all(SenseiConst.padding),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
              ),
              borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: ListTile(
              subtitleTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              leading: Icon(
                Icons.lightbulb_outline_rounded,
                size: SenseiConst.iconSize,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: Text(S.of(context).appName),
              subtitle: Text(
                S.of(context).appDescription,
                style: AppTextStyle.subtitle(context),
              ),
            ),
          ),
        ),
      ),
    );
}
