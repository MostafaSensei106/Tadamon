import 'package:flutter/material.dart';
import '../../../../core/widgets/expansion_tile_component/expansion_tile_component.dart';

class RadioSelectionTileComponent extends StatefulWidget {

  const RadioSelectionTileComponent({super.key, this.onChanged});
  final Function(String)? onChanged;

  @override
  State<RadioSelectionTileComponent> createState() =>
      _RadioSelectionTileComponentState();
}

class _RadioSelectionTileComponentState
    extends State<RadioSelectionTileComponent> {
  String selectedValue = 'لا أعرف';

  @override
  Widget build(final BuildContext context) => ExpansionTileComponent(
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

  Widget buildRadio(final String title) => RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: selectedValue,
      onChanged: (final value) {
        setState(() {
          selectedValue = value!;
        });
        widget.onChanged?.call(value!);
      },
    );
}
