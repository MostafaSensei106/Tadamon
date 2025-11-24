import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
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
    icon: Icons.description_outlined,
    title: AppLocalizations.of(context)!.readMe,
    subtitle: AppLocalizations.of(context)!.readMeMassage,
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
        icon: Icons.update_outlined,
        title: AppLocalizations.of(context)!.letastUpdate,
        subtitle: AppLocalizations.of(context)!.letestUpdateMassage,
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
    icon: Icons.live_help_outlined,
    title: AppLocalizations.of(context)!.githubTiket,
    subtitle: AppLocalizations.of(context)!.githubTiketMassage,
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
        icon: Icons.telegram_rounded,
        title: AppLocalizations.of(context)!.telegramChannel,
        subtitle: AppLocalizations.of(context)!.telegramChannelMassage,
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
