import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/const/sensei_const.dart';
import '../../config/fonts/fonts.dart';

class ExpansionTileComponent extends StatefulWidget {

  const ExpansionTileComponent({
    required this.leadingIcon, required this.title, required this.subtitle, required this.children, super.key,
    this.useInBorderRadius = false,
    this.useMargin = false,
  });
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final List<Widget> children;
  final bool useInBorderRadius;
  final bool useMargin;

  @override
  State<ExpansionTileComponent> createState() => _ExpansionTileComponentState();
}

class _ExpansionTileComponentState extends State<ExpansionTileComponent> {
  @override
  Widget build(final BuildContext context) => Container(
      margin: widget.useMargin
          ? EdgeInsets.only(top: SenseiConst.margin.h)
          : null,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(
          widget.useInBorderRadius
              ? SenseiConst.inBorderRadius
              : SenseiConst.outBorderRadius,
        ),
      ),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(SenseiConst.padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
          child: Icon(widget.leadingIcon, size: SenseiConst.iconSize),
        ),
        title: Text(widget.title),
        subtitle: Text(widget.subtitle, style: AppTextStyle.subtitle(context)),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            widget.useInBorderRadius
                ? SenseiConst.inBorderRadius
                : SenseiConst.outBorderRadius,
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
          ),
        ),
        children: widget.children,
      ),
    );
}
