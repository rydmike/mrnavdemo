import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods/theme_pods.dart';

/// Toggle the AppBar style of the application for dark theme mode.
///
/// This toggle bakes in the Riverpod state provider and is tied to this app
/// implementation. This approach is easy to use since there is nothing to
/// pass around to set its value, just drop in the Widget anywhere in the app.
@immutable
class DarkAppBarStyleSwitch extends ConsumerWidget {
  const DarkAppBarStyleSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final FlexAppBarStyle style = watch(darkAppBarStylePod).state;
    final MaterialColor primarySwatch =
        FlexColorScheme.createPrimarySwatch(colorScheme.primary);
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
        context.read(darkAppBarStylePod).state =
            FlexAppBarStyle.values[newIndex];
      },
      children: <Widget>[
        Icon(Icons.panorama_wide_angle_select,
            color: style == FlexAppBarStyle.primary
                ? primarySwatch.shade900
                : theme.colorScheme.primary),
        Icon(Icons.panorama_wide_angle_outlined,
            color: style == FlexAppBarStyle.material
                ? Colors.black87
                : primarySwatch.shade800),
        Icon(Icons.panorama_wide_angle_select,
            color: Color.alphaBlend(
                colorScheme.primary.withAlpha(60), Colors.black)),
        Icon(Icons.panorama_wide_angle_select,
            color: Color.alphaBlend(
                colorScheme.primary.withAlpha(90), Colors.black)),
        Icon(Icons.panorama_wide_angle_select,
            color: colorScheme.secondaryVariant),
      ],
    );
  }
}
