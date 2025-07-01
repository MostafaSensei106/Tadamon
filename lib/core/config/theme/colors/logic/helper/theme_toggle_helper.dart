import 'dart:ui' show Brightness;

import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter/widgets.dart' show BuildContext, MediaQuery;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/theme_cubit.dart'
    show ThemeCubit;

import '../cubit/theme_state.dart' show ThemeState;

/// Toggles the theme between dark and light mode.
///
/// When [value] is true, the theme is set to the system theme.
/// When [value] is false, the theme is set to dark or light mode depending on
/// the current [MediaQuery] platform brightness.
///
/// Persists the chosen theme to SharedPreferences.
///
/// Emits a new [ThemeState] with the chosen [isDark] and [ThemeMode].
void toggleTheme(final bool value, final BuildContext context) {
  if (value) {
    context.read<ThemeCubit>().setSystemTheme();
  } else {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    context.read<ThemeCubit>().toggleTheme(isDarkMode);
  }
}
