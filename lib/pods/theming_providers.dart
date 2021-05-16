import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/theme.dart';

// All theming related providers in this file.

/// themeModeProvider represents a [StateProvider] to provide the state of
/// the [ThemeMode], so to be able to toggle the application wide theme mode
final StateProvider<ThemeMode> themeModePod =
    StateProvider<ThemeMode>((ProviderReference ref) {
  return ThemeMode.system;
});

final StateProvider<double> appBarOpacityProvider =
    StateProvider<double>((ProviderReference ref) {
  return 0.85;
});

final StateProvider<int> schemeProvider =
    StateProvider<int>((ProviderReference ref) {
  return 0;
});

final StateProvider<FlexAppBarStyle> lightAppBarStyleProvider =
    StateProvider<FlexAppBarStyle>((ProviderReference ref) {
  return FlexAppBarStyle.primary;
});

final StateProvider<FlexAppBarStyle> darkAppBarStyleProvider =
    StateProvider<FlexAppBarStyle>((ProviderReference ref) {
  return FlexAppBarStyle.background;
});

final StateProvider<FlexSurface> surfaceStyleProvider =
    StateProvider<FlexSurface>((ProviderReference ref) {
  return FlexSurface.medium;
});

final StateProvider<ThemeData> lightThemePod =
    StateProvider<ThemeData>((ProviderReference ref) {
  final int usedTheme = ref.watch(schemeProvider).state;
  final FlexAppBarStyle appBarStyle = ref.watch(lightAppBarStyleProvider).state;
  final FlexSurface surfaceStyle = ref.watch(surfaceStyleProvider).state;
  return AppTheme.light(
    usedTheme: usedTheme,
    appBarStyle: appBarStyle,
    surfaceStyle: surfaceStyle,
  );
});

final StateProvider<ThemeData> darkThemePod =
    StateProvider<ThemeData>((ProviderReference ref) {
  final int usedTheme = ref.watch(schemeProvider).state;
  final FlexAppBarStyle appBarStyle = ref.watch(darkAppBarStyleProvider).state;
  final FlexSurface surfaceStyle = ref.watch(surfaceStyleProvider).state;
  return AppTheme.dark(
    usedTheme: usedTheme,
    appBarStyle: appBarStyle,
    surfaceStyle: surfaceStyle,
  );
});
