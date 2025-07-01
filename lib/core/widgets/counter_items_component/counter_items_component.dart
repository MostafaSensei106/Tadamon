import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/const/sensei_const.dart';
import '../../config/fonts/fonts.dart';

class CounterItemsComponent extends StatefulWidget {

  const CounterItemsComponent({
    required this.icon, required this.title, required this.targetValue, super.key,
  });
  final IconData icon;
  final String title;
  final int targetValue;

  @override
  State<CounterItemsComponent> createState() => _CounterItemsComponentState();
}

class _CounterItemsComponentState extends State<CounterItemsComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  int _currentValue = 0;

  @override
  /// Initializes the state of the widget.
  ///
  /// This is called when the widget is inserted into the tree.
  ///
  /// It initializes the animation controller with a duration of 1000 milliseconds
  /// and sets the `vsync` to this state. It then updates the animation with the
  /// target value by calling `_updateAnimation`.
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _updateAnimation(widget.targetValue);
  }

  @override
  /// Called when the widget is rebuilt with new properties.
  ///
  /// This method is called when the [CounterItemsComponent] widget is rebuilt
  /// with new properties. If the target value has changed, the animation is
  /// updated to animate to the new target value.
  ///
  /// This is important in case the target value changes while the animation is
  /// still running. In that case, the animation should be updated to animate
  /// to the new target value.
  void didUpdateWidget(final CounterItemsComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.targetValue != oldWidget.targetValue) {
      _updateAnimation(widget.targetValue);
    }
  }

  void _updateAnimation(final int targetValue) {
    _animation =
        IntTween(begin: _currentValue, end: targetValue).animate(_controller)
          ..addListener(() {
            setState(() {
              _currentValue = _animation.value;
            });
          });

    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  /// Builds a [Container] widget with a [Column] widget as child.
  ///
  /// The [Container] widget has a margin of [SenseiConst.margin] on the top only,
  /// a padding of [SenseiConst.padding] on all sides, and a decoration of a
  /// [BoxDecoration] with a [BorderRadius] of [SenseiConst.outBorderRadius] and a
  /// color of [Theme.of(context).colorScheme.surfaceContainer].
  ///
  /// The [Column] widget is configured with a [crossAxisAlignment] of
  /// [CrossAxisAlignment.center].
  ///
  /// The [Column] widget has three children:
  ///
  /// 1. A [Container] widget with a padding of [SenseiConst.padding] on all
  /// sides, and a decoration of a [BoxDecoration] with a [BorderRadius] of
  /// [SenseiConst.inBorderRadius] and a color of
  /// [Theme.of(context).colorScheme.primaryContainer].
  ///
  ///    This widget contains an [Icon] widget with the given [icon], a size of
  ///    [SenseiConst.iconSize], and a color of
  ///    [Theme.of(context).colorScheme.onPrimaryContainer].
  ///
  /// 2. A [SizedBox] widget with a height of 4 logical pixels.
  ///
  /// 3. A [Text] widget with the given [title], and a [textAlign] of
  ///    [TextAlign.center].
  ///
  /// 4. A [SizedBox] widget with a height of 4 logical pixels.
  ///
  /// 5. A [Text] widget with the current value of the counter, a style of a
  ///    [TextStyle] with a [fontSize] of 18 logical pixels, a [fontWeight] of
  ///    [FontWeight.bold], and a [textAlign] of [TextAlign.center].
  Widget build(final BuildContext context) => Container(
      margin: EdgeInsets.only(top: SenseiConst.margin.h),
      padding: const EdgeInsets.all(SenseiConst.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(SenseiConst.padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Icon(
              widget.icon,
              size: SenseiConst.iconSize.sp,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(height: 4.h),
          Text(widget.title, textAlign: TextAlign.center),
          SizedBox(height: 4.h),
          Text(
            _currentValue.toString(),
            style: AppTextStyle(context).subtitle.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
}
