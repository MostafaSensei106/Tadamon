import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/textbutton_component/textbutton_component.dart';

class TextbuttonIconComponent extends TextButtonComponent {
  final IconData icon;

  const TextbuttonIconComponent({
    super.key,
    required super.onPressed,
    required super.text,
    super.useInBorderRadius = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
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
}
