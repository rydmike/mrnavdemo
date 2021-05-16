import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods/theme_pods.dart';
import '../utils/app_theme.dart';

// This is a theme selector ListTile Popup-up menu theme
// selection widget. It will not be used in released product, but we can use
// to try different themes easily during product development.
class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Size the width of the theme selector with this constant. A value
    // of 0.5 will make it round, 1 will make it a stadium which is double
    // as wide as it is high.
    const double _widthScale = 0.7;

    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final int selected = watch(schemePod).state;

    return PopupMenuButton<int>(
      padding: const EdgeInsets.all(0),
      onSelected: (int newTheme) {
        context.read(schemePod).state = newTheme;
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        for (int i = 0; i < AppTheme.schemes.length; i++)
          PopupMenuItem<int>(
            value: i,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(AppTheme.schemes[i].name),
              leading: SizedBox(
                width: 50 * _widthScale * 2,
                child: FlexThemeModeOptionButton(
                  flexSchemeColor: isLight
                      ? AppTheme.schemes[i].light
                      : AppTheme.schemes[i].dark,
                  selected: true,
                  selectedBorder: BorderSide(
                    color: isLight
                        ? AppTheme.schemes[i].light.primary
                        : AppTheme.schemes[i].dark.primary,
                    width: 1.5,
                  ),
                  backgroundColor: scheme.background,
                  width: 50 * _widthScale,
                  height: 50 / 2,
                  padding: EdgeInsets.zero,
                  borderRadius: 0,
                  optionButtonPadding: EdgeInsets.zero,
                  optionButtonMargin: EdgeInsets.zero,
                  optionButtonBorderRadius: 50,
                ),
              ),
            ),
          )
      ],
      child: ListTile(
        title: Text('${AppTheme.schemes[selected].name} theme'),
        subtitle: Text(AppTheme.schemes[selected].description),
        trailing: SizedBox(
          width: 50 * _widthScale * 2,
          child: FlexThemeModeOptionButton(
            flexSchemeColor: FlexSchemeColor(
              primary: scheme.primary,
              primaryVariant: scheme.primaryVariant,
              secondary: scheme.secondary,
              secondaryVariant: scheme.secondaryVariant,
            ),
            selected: true,
            selectedBorder: BorderSide(
              color: scheme.primary,
              width: 1.5,
            ),
            backgroundColor: scheme.background,
            width: 50 * _widthScale,
            height: 50 / 2,
            padding: EdgeInsets.zero,
            borderRadius: 0,
            optionButtonPadding: EdgeInsets.zero,
            optionButtonMargin: EdgeInsets.zero,
            optionButtonBorderRadius: 50,
          ),
        ),
      ),
    );
  }
}
