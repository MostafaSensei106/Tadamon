import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../config/const/app_enums.dart';
import '../../../routing/routes.dart';
import '../../list_tile_components/list_tile_icon_component.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(final BuildContext context) =>
      Column(children: [_buildDeveloper(context), _buildAbout(context)]);

  Widget _buildDeveloper(final BuildContext context) => ListTileIconComponent(
    groupType: ListTileGroupType.top,
    iconLeading: Icons.verified_outlined,
    title: S.of(context).developer,
    subtitle: S.of(context).mostafaMahmoud,
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () => {
      Navigator.pop(context),
      Navigator.pushNamed(context, Routes.chatWithDev),
    },
  );

  Widget _buildAbout(final BuildContext context) => ListTileIconComponent(
    groupType: ListTileGroupType.bottom,
    iconLeading: Icons.info_outline,
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    title: S.of(context).about,
    subtitle: S.of(context).about,
    onTap: () => {
      Navigator.pop(context),
      Navigator.pushNamed(context, Routes.appInfo),
    },
  );
}
