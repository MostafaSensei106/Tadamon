import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/config/fonts/fonts.dart';

class ExpansionTileComponent extends StatefulWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final List<Widget> children;
  final bool useInBorderRadius;
  final bool useMargin;

  const ExpansionTileComponent({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.children,
    this.useInBorderRadius = false,
    this.useMargin = false,
  });

  @override
  State<ExpansionTileComponent> createState() => _ExpansionTileComponentState();
}

class _ExpansionTileComponentState extends State<ExpansionTileComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          widget.useMargin ? EdgeInsets.only(top: SenseiConst.margin.h) : null,
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
          child: Icon(
            widget.leadingIcon,
            size: SenseiConst.iconSize,
          ),
        ),
        title: Text(widget.title),
        subtitle: Text(
          widget.subtitle,
          style: AppTextStyle.subtitle(context),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        enableFeedback: true,
        showTrailingIcon: true,
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
}
