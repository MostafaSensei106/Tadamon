import 'package:flutter/material.dart';

class IconButtonComponent extends StatelessWidget {
  const IconButtonComponent({
    required this.icon,
    required this.onPressed,
    super.key,
  });
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) =>
      IconButton(icon: Icon(icon), onPressed: () => onPressed());
}
