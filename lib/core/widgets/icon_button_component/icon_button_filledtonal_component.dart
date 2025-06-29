import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/icon_button_component/icon_button_component.dart';

class IconButtonFilledTonalComponent extends IconButtonComponent {
  final bool useInBorderRadius;
  final Color color;
  const IconButtonFilledTonalComponent({
    super.key,
    this.useInBorderRadius = false,
    required super.icon,
    required super.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
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
}
