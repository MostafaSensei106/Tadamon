import 'package:flutter/material.dart';
import 'package:tadamon/core/widgets/expansion_tile_component/expansion_tile_component.dart';

class RadioSelectionTileComponent extends StatefulWidget {
  final Function(String)? onChanged;

  const RadioSelectionTileComponent({super.key, this.onChanged});

  @override
  State<RadioSelectionTileComponent> createState() =>
      _RadioSelectionTileComponentState();
}

class _RadioSelectionTileComponentState
    extends State<RadioSelectionTileComponent> {
  String selectedValue = 'لا أعرف';

  @override
  Widget build(BuildContext context) {
    return ExpansionTileComponent(
      leadingIcon: Icons.handshake_outlined,
      useInBorderRadius: true,
      title: 'الحالة',
      subtitle: selectedValue,
      children: [
        buildRadio('لا أعرف'),
        buildRadio('مقاطعة'),
        buildRadio('لا يدعم الكيان الصهيوني'),
      ],
    );
  }

  Widget buildRadio(String title) {
    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
        widget.onChanged?.call(value!);
      },
    );
  }
}
