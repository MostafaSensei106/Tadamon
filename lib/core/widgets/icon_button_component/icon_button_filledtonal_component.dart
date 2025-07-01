import 'package:flutter/material.dart';
import '../../config/const/sensei_const.dart';
import 'icon_button_component.dart';

class IconButtonFilledTonalComponent extends IconButtonComponent {
  const IconButtonFilledTonalComponent({
    required super.icon,
    required super.onPressed,
    required this.color,
    super.key,
    this.useInBorderRadius = false,
  });
  final bool useInBorderRadius;
  final Color color;

  @override
  Widget build(final BuildContext context) => IconButton.filledTonal(
    icon: Icon(icon),
    onPressed: () => onPressed(),
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(color),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: useInBorderRadius
              ? BorderRadius.circular(SenseiConst.inBorderRadius)
              : BorderRadius.circular(SenseiConst.outBorderRadius),
        ),
      ),
    ),
  );
}
