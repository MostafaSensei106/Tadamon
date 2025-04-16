import 'package:flutter/material.dart';
import 'package:tadamon/core/widgets/textbutton_component/textbutton_component.dart';

class TextbuttonIconComponent extends TextButtonComponent {
  final IconData icon;
  
  const TextbuttonIconComponent({
    super.key,
    required super.onPressed,
    required super.text,
    required this.icon,  
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(icon),
      onPressed: onPressed,
      label: Text(text),
    );
  }
}
