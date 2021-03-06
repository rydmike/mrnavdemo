import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods/theme_pods.dart';

/// Toggle the AppBar style of the application for light theme mode.
///
/// This toggle bakes in the Riverpod state provider and is tied to this app
/// implementation. This approach is easy to use since there is nothing to
/// pass around to set its value, just drop in the Widget anywhere in the app.
@immutable
class LightAppBarStyleSwitch extends ConsumerWidget {
  const LightAppBarStyleSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ThemeData theme = Theme.of(context);
    final FlexAppBarStyle style = watch(lightAppBarStylePod).state;
    final MaterialColor primarySwatch =
        FlexColorScheme.createPrimarySwatch(theme.colorScheme.primary);
    final List<bool> isSelected = <bool>[
      style == FlexAppBarStyle.primary,
      style == FlexAppBarStyle.material,
      style == FlexAppBarStyle.surface,
      style == FlexAppBarStyle.background,
      style == FlexAppBarStyle.custom,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        context.read(lightAppBarStylePod).state =
            FlexAppBarStyle.values[newIndex];
      },
      children: <Widget>[
        Icon(Icons.panorama_wide_angle_select,
            color: style == FlexAppBarStyle.primary
                ? primarySwatch.shade800
                : theme.colorScheme.primary),
        Icon(Icons.panorama_wide_angle_outlined,
            color: style == FlexAppBarStyle.material
                ? Colors.white
                : primarySwatch.shade50),
        Icon(Icons.panorama_wide_angle_select,
            color: Color.alphaBlend(
                theme.colorScheme.primary.withAlpha(40), Colors.white)),
        Icon(Icons.panorama_wide_angle_select,
            color: Color.alphaBlend(
                theme.colorScheme.primary.withAlpha(100), Colors.white)),
        Icon(Icons.panorama_wide_angle_select,
            color: theme.colorScheme.secondaryVariant),
      ],
    );
  }
}
