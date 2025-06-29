import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/dilog_components/dilog_component.dart';

class DilogWatingComponent extends DilogComponent {
  const DilogWatingComponent({
    super.key,
    required super.title,
    required super.message,
    super.icon,
    super.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.info_outline_rounded, size: SenseiConst.iconSize),
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LinearProgressIndicator(),
          const SizedBox(height: 16),
          Text(message),
        ],
      ),
    );
  }
}
