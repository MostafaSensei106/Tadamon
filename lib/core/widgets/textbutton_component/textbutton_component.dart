import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class TextButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isClose;
  final bool useInBorderRadius;
  final bool useBorderSide;

  const TextButtonComponent({
    super.key,
    required this.text,
    required this.onPressed,
    this.isClose = false,
    this.useInBorderRadius = false,
    this.useBorderSide = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: useInBorderRadius
              ? BorderRadius.circular(SenseiConst.inBorderRadius)
              : BorderRadius.circular(SenseiConst.outBorderRadius),
        ),
        elevation: 0,
        enableFeedback: true,
        enabledMouseCursor: SystemMouseCursors.click,
        side: BorderSide(
          color: useBorderSide
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
        )
      ),
      child: Text(text),
    );
  }
}
