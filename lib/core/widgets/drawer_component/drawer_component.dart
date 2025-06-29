import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/config/fonts/fonts.dart';
import 'package:tadamon/core/widgets/divider.dart';

class ListTileComponent extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final Widget? trailingWidget;
  final VoidCallback? onTapped;
  final bool selected;
  final bool useMargin;
  final bool useSingeGroup;
  final bool useGroupTop;
  final bool useGroupMiddle;
  final bool useGroupBottom;
  final bool useDivider;
  final bool useinBorderRadius;

  const ListTileComponent({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.trailingWidget,
    this.onTapped,
    this.selected = false,
    this.useMargin = false,
    this.useDivider = false,
    this.useGroupTop = false,
    this.useGroupMiddle = false,
    this.useGroupBottom = false,
    this.useSingeGroup = false,
    this.useinBorderRadius = false,
  });

  /// Get the border radius based on the given group properties.
  ///
  /// This function returns a [BorderRadius] with the following rules:
  ///
  /// - If [useGroupTop] is true, return a [BorderRadius] with only the top
  ///   left and right corners rounded.
  ///
  /// - If [useGroupBottom] is true, return a [BorderRadius] with only the
  ///   bottom left and right corners rounded.
  ///
  /// - If [useSingeGroup] is true, return a [BorderRadius] with all corners
  ///   rounded.
  ///
  /// - If [useGroupMiddle] is true, return a [BorderRadius] with no corners rounded.
  ///
  /// Otherwise, return a [BorderRadius] with all corners rounded.
  BorderRadius _getBorderRadius() {
    double borderRadius = useinBorderRadius
        ? SenseiConst.inBorderRadius
        : SenseiConst.outBorderRadius;
    if (useGroupTop) {
      return BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
      );
    } else if (useGroupBottom) {
      return BorderRadius.only(
        bottomLeft: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius),
      );
    } else if (useSingeGroup) {
      return BorderRadius.circular(borderRadius);
    } else if (useGroupMiddle) {
      return BorderRadius.zero;
    }
    return BorderRadius.circular(borderRadius);
  }

  @override
  /// Builds a [ListTileComponent].
  ///
  /// This function returns a [Container] widget with a margin and decoration
  /// based on the given properties.
  ///
  /// The [Container] widget contains a [Column] widget with a
  /// [InkWell] widget and a [SenseiDivider] widget if [useDivider] is true.
  ///
  /// The [InkWell] widget is configured with a rounded border with the
  /// [SenseiConst.outBorderRadius] radius, and an [onTap] callback that calls
  /// [onTapped] with the given [context].
  ///
  /// The [InkWell] widget has a [ListTile] widget as child, which is
  /// configured with a horizontal title gap of 13 logical pixels, and a
  /// content padding of 8 logical pixels on the left and right sides.
  ///
  /// The [ListTile] widget has a [Container] widget with a rounded border and
  /// a transparent color as the leading widget.
  ///
  /// The [Container] widget has a [Icon] widget as child, which is configured
  /// with the given [leadingIcon] and a size of [SenseiConst.iconSize].
  ///
  /// The [ListTile] widget has a [Text] widget as title, which is configured
  /// with the given [title].
  ///
  /// The [ListTile] widget has a [Text] widget as subtitle, which is
  /// configured with the given [subtitle] and an [overflow] of
  /// [TextOverflow.ellipsis].
  ///
  /// The [ListTile] widget has the given [trailingWidget] as trailing widget.
  ///
  /// The [ListTile] widget is selected if [selected] is true.
  Widget build(BuildContext context) {
    return Container(
      margin: useMargin ? const EdgeInsets.only(top: SenseiConst.margin) : null,
      decoration: BoxDecoration(
        borderRadius: _getBorderRadius(),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: _getBorderRadius(),
              enableFeedback: true,
              customBorder: RoundedRectangleBorder(
                borderRadius: _getBorderRadius(),
              ),
              onTap: onTapped,
              child: ListTile(
                horizontalTitleGap: 13.w,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SenseiConst.padding.w,
                  vertical: 0,
                ),
                leading: Container(
                  padding: const EdgeInsets.all(SenseiConst.padding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      SenseiConst.inBorderRadius,
                    ),
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                  ),
                  child: Icon(leadingIcon, size: SenseiConst.iconSize.sp),
                ),
                title: Text(title),
                subtitle: Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.subtitle(context),
                ),
                trailing: trailingWidget,
                selected: selected,
              ),
            ),
          ),
          if (useDivider) const SenseiDivider(),
        ],
      ),
    );
  }
}
