import 'package:flutter/material.dart'
    show
        BorderRadius,
        BorderSide,
        BuildContext,
        Color,
        Icon,
        IconData,
        RoundedRectangleBorder,
        Text,
        TextButton,
        Theme,
        Widget;
import '../../../config/const/sensei_const.dart';
import 'text_button_component.dart' show TextButtonComponent;

class TextIconButtonComponent extends TextButtonComponent {
  const TextIconButtonComponent({
    required super.onPressed,
    required super.text,
    required this.icon,
    this.color,
    super.key,
    super.useInBorderRadius = false,
  });
  final IconData icon;
  final Color? color;

  @override
  Widget build(final BuildContext context) => TextButton.icon(
    style: TextButton.styleFrom(
      backgroundColor: color ?? Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: useInBorderRadius
            ? BorderRadius.circular(SenseiConst.inBorderRadius)
            : BorderRadius.circular(SenseiConst.outBorderRadius),
      ),
      side: BorderSide(
        color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
      ),
    ),
    icon: Icon(icon),
    onPressed: onPressed,
    label: Text(text),
  );
}
