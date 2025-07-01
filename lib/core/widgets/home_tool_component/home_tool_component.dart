import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/const/sensei_const.dart';
import '../../config/fonts/fonts.dart';

class HomeToolsComponent extends StatelessWidget {
  const HomeToolsComponent({
    required this.icon,
    required this.title,
    required this.onTapped,
    super.key,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTapped;

  @override
  /// Builds a [HomeToolsComponent].
  ///
  /// This function returns a [Padding] widget with a [Material] widget as child.
  ///
  /// The [Material] widget is configured with a transparent color and an
  /// [InkWell] widget as child.
  ///
  /// The [InkWell] widget is configured with a rounded border with the
  /// [SenseiConst.inBorderRadius] radius, and an [onTap] callback that calls
  /// [onTapped] with the given [context].
  ///
  /// The [InkWell] widget has a [Container] widget as child, which is
  /// configured with a padding of [SenseiConst.padding] on all sides.
  ///
  /// The [Container] widget has a [Column] widget as child, which is
  /// configured with a mainAxisAlignment of [MainAxisAlignment.center].
  ///
  /// The [Column] widget has two children:
  ///
  /// 1. A [Container] widget with a rounded border with the
  ///    [SenseiConst.inBorderRadius] radius, and a color of
  ///    [Theme.of(context).colorScheme.primaryContainer].
  ///
  ///    The [Container] widget has an [Icon] widget as child, which is
  ///    configured with the given [icon], a size of [SenseiConst.iconSize],
  ///    and a color of
  ///    [Theme.of(context).colorScheme.onPrimaryContainer].
  ///
  /// 2. A [SizedBox] widget with a height of [SenseiConst.padding].
  ///
  /// 3. A [Text] widget with the given [title], and a [textAlign] of
  ///    [TextAlign.center].
  ///
  ///    The [Text] widget is configured with a maxLines of 2, and an
  ///    [overflow] of [TextOverflow.fade].
  Widget build(final BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
      onTap: onTapped,
      child: Container(
        padding: const EdgeInsets.all(3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(SenseiConst.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Icon(
                icon,
                size: SenseiConst.iconSize.sp,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            SizedBox(height: SenseiConst.padding.h),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.fade,
              style: AppTextStyle(context).subtitle,
            ),
          ],
        ),
      ),
    ),
  );
}
