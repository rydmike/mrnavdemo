import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/app_theme.dart';

// All theming related providers in this file.

/// themeModeProvider represents a [StateProvider] to provide the state of
/// the [ThemeMode], so to be able to toggle the application wide theme mode
final StateProvider<ThemeMode> themeModePod =
    StateProvider<ThemeMode>((ProviderReference ref) {
  return ThemeMode.system;
});

final StateProvider<int> schemePod =
    StateProvider<int>((ProviderReference ref) {
  return 0;
});

final StateProvider<FlexAppBarStyle> lightAppBarStylePod =
    StateProvider<FlexAppBarStyle>((ProviderReference ref) {
  return FlexAppBarStyle.background;
});

final StateProvider<FlexAppBarStyle> darkAppBarStylePod =
    StateProvider<FlexAppBarStyle>((ProviderReference ref) {
  return FlexAppBarStyle.background;
});

final StateProvider<FlexSurface> surfaceStylePod =
    StateProvider<FlexSurface>((ProviderReference ref) {
  return FlexSurface.heavy;
});

final StateProvider<ThemeData> lightThemePod =
    StateProvider<ThemeData>((ProviderReference ref) {
  final int usedTheme = ref.watch(schemePod).state;
  final FlexAppBarStyle appBarStyle = ref.watch(lightAppBarStylePod).state;
  final FlexSurface surfaceStyle = ref.watch(surfaceStylePod).state;
  return AppTheme.light(
    usedTheme: usedTheme,
    appBarStyle: appBarStyle,
    surfaceStyle: surfaceStyle,
  );
});

final StateProvider<ThemeData> darkThemePod =
    StateProvider<ThemeData>((ProviderReference ref) {
  final int usedTheme = ref.watch(schemePod).state;
  final FlexAppBarStyle appBarStyle = ref.watch(darkAppBarStylePod).state;
  final FlexSurface surfaceStyle = ref.watch(surfaceStylePod).state;
  return AppTheme.dark(
    usedTheme: usedTheme,
    appBarStyle: appBarStyle,
    surfaceStyle: surfaceStyle,
  );
});
