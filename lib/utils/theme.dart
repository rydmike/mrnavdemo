import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

// The themes for this app.
class AppTheme {
  // This constructor prevents external instantiation and extension.
  AppTheme._();

  // The active used light theme.
  static ThemeData light({
    required int usedTheme,
    required FlexAppBarStyle appBarStyle,
    required FlexSurface surfaceStyle,
  }) {
    // We need to use the ColorScheme defined by used FlexColorScheme as input
    // to other theme's, so we create it first.
    final FlexColorScheme _flexScheme = FlexColorScheme.light(
      colors: schemes[usedTheme].light,
      appBarStyle: appBarStyle,
      surfaceStyle: surfaceStyle,
      appBarElevation: 0.5,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
    );
    // Currently just used in one sub-theme, but we will need it in more.
    final ColorScheme _colorScheme = _flexScheme.toScheme;
    return _flexScheme.toTheme.copyWith(
      // Add our custom button shape and padding theming.
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      textButtonTheme: textButtonTheme,
      toggleButtonsTheme: toggleButtonsTheme(_colorScheme),
      inputDecorationTheme: inputDecorationTheme(
        _colorScheme.primary.withOpacity(0.035),
      ),
    );
  }

  // The active used dark theme.
  static ThemeData dark({
    required int usedTheme,
    required FlexAppBarStyle appBarStyle,
    required FlexSurface surfaceStyle,
  }) {
    // We need to use the ColorScheme defined by used FlexColorScheme as input
    // to other theme's, so we create it first.
    final FlexColorScheme _flexScheme = FlexColorScheme.dark(
      colors: schemes[usedTheme].dark,
      appBarStyle: appBarStyle,
      surfaceStyle: surfaceStyle,
      appBarElevation: 0.5,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
    );
    // Currently just used in one sub-theme, but we will need it in more.
    final ColorScheme _colorScheme = _flexScheme.toScheme;
    return _flexScheme.toTheme.copyWith(
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      textButtonTheme: textButtonTheme,
      toggleButtonsTheme: toggleButtonsTheme(_colorScheme),
      inputDecorationTheme: inputDecorationTheme(
        _colorScheme.primary.withOpacity(0.06),
      ),
    );
  }

  // These theme definitions are used to give all Material buttons a
  // a Stadium rounded design, consistent with the rounded design of the app.
  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        shape: buttonShape,
        padding: roundButtonPadding,
      ));

  static OutlinedButtonThemeData get outlinedButtonTheme =>
      OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        shape: buttonShape,
        padding: roundButtonPadding,
      ));

  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
          style: TextButton.styleFrom(
        shape: buttonShape,
        padding: roundButtonPadding,
      ));

  // The stadium rounded buttons generally need a bit more padding to look good,
  // adjust here to tune the padding for all of them globally in the app.
  static const EdgeInsets roundButtonPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 16);

  // The shape of all the themed buttons in the app. Earlier we used
  // StadiumBorder() as shape, that makes them all a half circle like a
  // stadium end. With this version we can vary the rounding, but it if
  // we want a fully rounded look we should use the stadium border.
  static const OutlinedBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
  );

  /// ToggleButtons theme
  static ToggleButtonsThemeData toggleButtonsTheme(ColorScheme colorScheme) =>
      ToggleButtonsThemeData(
        selectedColor: colorScheme.onPrimary,
        color: colorScheme.primary.withOpacity(0.85),
        fillColor: colorScheme.primary.withOpacity(0.85),
        hoverColor: colorScheme.primary.withOpacity(0.2),
        focusColor: colorScheme.primary.withOpacity(0.3),
        borderWidth: 1.5,
        borderColor: colorScheme.primary,
        selectedBorderColor: colorScheme.primary,
        borderRadius: BorderRadius.circular(50),
        constraints: const BoxConstraints(minWidth: 50, minHeight: 50),
      );

  static InputDecorationTheme inputDecorationTheme(Color fillColor) =>
      InputDecorationTheme(
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      );

  // These colors came from Alessio's dragon image example
  static FlexSchemeColor get demoSchemeLight => FlexSchemeColor.from(
        primary: const Color(0xFF00AABE),
        secondary: const Color(0xFFF4461E),
      );
  // Add some new favorite colors to try a new theme here:

  // Create a list with all our experimental custom color schemes and add
  // all the FlexColorScheme built-in ones we can try them for inspiration.
  static List<FlexSchemeData> get schemes => <FlexSchemeData>[
        // Add all our schemes to the list of schemes, we just have one custom
        // scheme in this demo plus all the FlexColorScheme based schemes.
        // We do the same for our next custom scheme, BUT we create its matching
        // dark colors, from the light FlexSchemeColor with the toDark method.
        FlexSchemeData(
          name: 'Demo scheme',
          description: "Custom cyan and orange theme.",
          light: demoSchemeLight,
          dark: demoSchemeLight.toDark(),
        ),
        // Add all built in FlexColor schemes for inspiration.
        ...FlexColor.schemesList,
      ];
}
