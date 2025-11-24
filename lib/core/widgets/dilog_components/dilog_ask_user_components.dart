import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        StatelessWidget,
        Widget,
        AlertDialog,
        IconData,
        VoidCallback,
        Theme,
        showDialog;

import '../../config/const/sensei_const.dart' show SenseiConst;
import '../button_components/textbutton_components/text_button_component.dart';
import '../container_background_component/container_background_component.dart';

class DilogAskUserComponents extends StatelessWidget {
  const DilogAskUserComponents({
    required this.title,
    required this.question,
    required this.icon,
    required this.onYes,
    required this.onNo,
    required this.yesText,
    required this.noText,
    super.key,
  });

  final String title;
  final String question;
  final IconData icon;
  final VoidCallback onYes;
  final VoidCallback onNo;
  final String yesText;
  final String noText;

  Future<void> show(final BuildContext context) async => showDialog<void>(
    context: context,
    builder: (final BuildContext context) => this,
  );

  @override
  Widget build(final BuildContext context) => AlertDialog(
    elevation: 0,
    icon: Icon(icon, size: SenseiConst.iconSize),
    title: Text(title),
    content: ContainerBackgroundComponent(
      useInBorderRadius: true,
      padding: const EdgeInsets.all(SenseiConst.padding),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Text(question),
    ),
    actions: [
      TextButtonComponent(text: noText, onPressed: onNo),
      TextButtonComponent(text: yesText, onPressed: onYes),
    ],
  );
}
