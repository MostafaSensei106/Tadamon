import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../config/const/app_enums.dart';
import '../../../config/theme/colors/logic/cubit/theme_cubit.dart';
import '../../../config/theme/colors/logic/cubit/theme_state.dart';
import '../../../config/theme/colors/logic/helper/theme_toggle_helper.dart';
import '../../list_tile_components/list_tile_icon_component.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(final BuildContext context) =>
      Column(children: [_buildThemeSwitch(context), _buildModeSwitch(context)]);

  Widget _buildThemeSwitch(final BuildContext context) =>
      BlocBuilder<ThemeCubit, ThemeState>(
        buildWhen: (final previous, final current) =>
            previous.themeMode != current.themeMode,
        builder: (final context, final state) => ListTileIconComponent(
          groupType: state.themeMode != ThemeMode.system
              ? ListTileGroupType.top
              : ListTileGroupType.single,
          iconLeading: Icons.brightness_auto_outlined,
          title: S.of(context).systemTheme,
          subtitle: S.of(context).followSystemTheme,
          trailing: Switch(
            thumbIcon: _thumbIcon(context),
            value: state.themeMode == ThemeMode.system,
            onChanged: (final bool value) {
              toggleTheme(isSystemTheme: value, context: context);
            },
          ),
          onTap: () {
            final newValue = !(state.themeMode == ThemeMode.system);
            toggleTheme(isSystemTheme: newValue, context: context);
          },
        ),
      );

  Widget _buildModeSwitch(final BuildContext context) =>
      BlocBuilder<ThemeCubit, ThemeState>(
        buildWhen: (final previous, final current) =>
            previous.isDark != current.isDark ||
            previous.themeMode != current.themeMode,
        builder: (final context, final state) =>
            state.themeMode == ThemeMode.system
            ? const SizedBox.shrink()
            : ListTileIconComponent(
                key: ValueKey(state.isDark),
                groupType: ListTileGroupType.bottom,
                iconLeading: state.isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                title: state.isDark
                    ? S.of(context).darkTheme
                    : S.of(context).lightTheme,
                subtitle: state.isDark
                    ? S.of(context).switchToLightTheme
                    : S.of(context).switchToDarkTheme,
                trailing: Switch(
                  thumbIcon: _thumbIcon(context),
                  value: state.isDark,
                  onChanged: (final bool value) {
                    context.read<ThemeCubit>().toggleTheme(isDark: value);
                  },
                ),
                onTap: () {
                  context.read<ThemeCubit>().toggleTheme(isDark: !state.isDark);
                },
              ),
      );

  WidgetStateProperty<Icon> _thumbIcon(final BuildContext context) =>
      WidgetStateProperty.resolveWith<Icon>((final Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Icon(
            Icons.check,
            color: Theme.of(context).colorScheme.primary,
          );
        }
        return const Icon(Icons.close);
      });
}
