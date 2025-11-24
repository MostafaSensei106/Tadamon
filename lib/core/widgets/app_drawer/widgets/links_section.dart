import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../config/const/app_enums.dart';
import '../../../config/const/sensei_const.dart';
import '../../../services/url_services/url_services.dart';
import '../../list_tile_components/list_tile_icon_component.dart';

class LinksSection extends StatelessWidget {
  const LinksSection({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      _buildReadMe(context),
      _buildLetestUpdate(context),
      _buildGithubToken(context),
      _buildTelegramChannel(context),
    ],
  );

  Widget _buildReadMe(final BuildContext context) => ListTileIconComponent(
    groupType: ListTileGroupType.top,
    iconLeading: Icons.description_outlined,
    title: S.of(context).readMe,
    subtitle: S.of(context).readMeMassage,
    trailing: Icon(
      Icons.link_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () {
      Navigator.pop(context);
      launchURL(SenseiConst.devReadMeLink);
    },
  );

  Widget _buildLetestUpdate(final BuildContext context) =>
      ListTileIconComponent(
        groupType: ListTileGroupType.middle,
        iconLeading: Icons.update_outlined,
        title: S.of(context).letastUpdate,
        subtitle: S.of(context).letestUpdateMassage,
        trailing: Icon(
          Icons.link_rounded,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
        ),
        onTap: () {
          Navigator.pop(context);
          launchURL(SenseiConst.devReleaseAppLink);
        },
      );

  Widget _buildGithubToken(final BuildContext context) => ListTileIconComponent(
    groupType: ListTileGroupType.middle,
    iconLeading: Icons.live_help_outlined,
    title: S.of(context).githubTiket,
    subtitle: S.of(context).githubTiketMassage,
    trailing: Icon(
      Icons.link_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () {
      Navigator.pop(context);
      launchURL(SenseiConst.devGitHubIssuesLink);
    },
  );

  Widget _buildTelegramChannel(final BuildContext context) =>
      ListTileIconComponent(
        groupType: ListTileGroupType.bottom,
        iconLeading: Icons.telegram_rounded,
        title: S.of(context).telegramChannel,
        subtitle: S.of(context).telegramChannelMassage,
        trailing: Icon(
          Icons.link_rounded,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
        ),
        onTap: () {
          Navigator.pop(context);
          launchURL(SenseiConst.tadamonTelegramLink);
        },
      );
}
