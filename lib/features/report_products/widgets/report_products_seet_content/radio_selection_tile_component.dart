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
  final List<String> _options = [
    'لا أعرف',
    'مقاطعة',
    'لا يدعم الكيان الصهيوني',
  ];

  @override
  Widget build(final BuildContext context) => ExpansionTileComponent(
    leadingIcon: Icons.handshake_outlined,
    useInBorderRadius: true,
    title: 'الحالة',
    subtitle: selectedValue,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          onChanged: (final String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedValue = newValue;
              });
              widget.onChanged?.call(newValue);
            }
          },
          items: _options
              .map<DropdownMenuItem<String>>(
                (final String value) =>
                    DropdownMenuItem<String>(value: value, child: Text(value)),
              )
              .toList(),
        ),
      ),
    ],
  );
}
