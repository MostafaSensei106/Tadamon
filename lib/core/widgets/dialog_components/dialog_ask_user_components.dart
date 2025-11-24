import 'package:flutter/material.dart';
import '../../config/const/sensei_const.dart';

class DialogAskUserComponents extends StatelessWidget {
  const DialogAskUserComponents({
    required this.title,
    required this.question,
    required this.icon,
    required this.actions,
    super.key,
  });

  final String title;
  final String question;
  final IconData icon;
  final List<Widget> actions;

  Future<void> show(final BuildContext context) async => showDialog<void>(
    context: context,
    builder: (final BuildContext context) => this,
  );

  @override
  Widget build(final BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
      ),
      contentPadding: EdgeInsets.zero,

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 32, bottom: 24),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(SenseiConst.waterMelonCoverImage),
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(SenseiConst.outBorderRadius),
              ),
            ),
            child: Icon(
              icon,
              size: SenseiConst.iconSize + 20,
              color: colorScheme.primary,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(SenseiConst.padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: SenseiConst.padding,
              children: [
                Text(
                  title,
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(SenseiConst.padding),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(
                      SenseiConst.inBorderRadius,
                    ),
                  ),
                  child: Text(
                    question,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }
}
