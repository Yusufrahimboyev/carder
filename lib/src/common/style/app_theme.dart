import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: lightColorScheme,
    extensions: [ColorExtension(phoneColor: Colors.black)],
    fontFamily: 'Roboto',
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: darkColorScheme,
    extensions: [ColorExtension(phoneColor: Colors.white)],
    fontFamily: 'Roboto',
  );
}

class ColorExtension extends ThemeExtension<ColorExtension> {
  const ColorExtension({required this.phoneColor});

  final Color phoneColor;

  @override
  ThemeExtension<ColorExtension> copyWith({Color? phoneColor}) =>
      ColorExtension(phoneColor: phoneColor ?? this.phoneColor);

  @override
  ThemeExtension<ColorExtension> lerp(
    covariant ThemeExtension<ColorExtension>? other,
    double t,
  ) {
    if (other is! ColorExtension) {
      return this;
    }

    return ColorExtension(
      phoneColor: Color.lerp(phoneColor, other.phoneColor, t)!,
    );
  }
}

/// Light [ColorScheme] made with FlexColorScheme v8.4.0.
/// Requires Flutter 3.22.0 or later.
const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF2D3FE7),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFB4E6FF),
  onPrimaryContainer: Color(0xFF000000),
  primaryFixed: Color(0xFFDAE8F4),
  primaryFixedDim: Color(0xFFB2CEE8),
  onPrimaryFixed: Color(0xFF144775),
  onPrimaryFixedVariant: Color(0xFF165084),
  secondary: Color(0xFF202B6D),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF99CCF9),
  onSecondaryContainer: Color(0xFF000000),
  secondaryFixed: Color(0xFFCACEE4),
  secondaryFixedDim: Color(0xFF9EA5CB),
  onSecondaryFixed: Color(0xFF070918),
  onSecondaryFixedVariant: Color(0xFF0B0F26),
  tertiary: Color(0xFF514239),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFBAA99D),
  onTertiaryContainer: Color(0xFF000000),
  tertiaryFixed: Color(0xFFDBD6D3),
  tertiaryFixedDim: Color(0xFFBCB3AE),
  onTertiaryFixed: Color(0xFF110E0C),
  onTertiaryFixedVariant: Color(0xFF1B1614),
  error: Color(0xFFB00020),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFCD9DF),
  onErrorContainer: Color(0xFF000000),
  surface: Color(0xFFFCFCFC),
  onSurface: Color(0xFF111111),
  surfaceDim: Color(0xFFE0E0E0),
  surfaceBright: Color(0xFFFDFDFD),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFF8F8F8),
  surfaceContainer: Color(0xFFF3F3F3),
  surfaceContainerHigh: Color(0xFFEDEDED),
  surfaceContainerHighest: Color(0xFFE7E7E7),
  onSurfaceVariant: Color(0xFF393939),
  outline: Color(0xFF919191),
  outlineVariant: Color(0xFFD1D1D1),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF2A2A2A),
  onInverseSurface: Color(0xFFF1F1F1),
  inversePrimary: Color(0xFFDDFEFF),
  surfaceTint: Color(0xFF4496E0),
);

/// Dark [ColorScheme] made with FlexColorScheme v8.4.0.
/// Requires Flutter 3.22.0 or later.
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFB4E6FF),
  onPrimary: Color(0xFF000000),
  primaryContainer: Color(0xFF1E8FDB),
  onPrimaryContainer: Color(0xFFFFFFFF),
  primaryFixed: Color(0xFFDAE8F4),
  primaryFixedDim: Color(0xFFB2CEE8),
  onPrimaryFixed: Color(0xFF144775),
  onPrimaryFixedVariant: Color(0xFF165084),
  secondary: Color(0xFF99CCF9),
  onSecondary: Color(0xFF000000),
  secondaryContainer: Color(0xFF202B6D),
  onSecondaryContainer: Color(0xFFFFFFFF),
  secondaryFixed: Color(0xFFCACEE4),
  secondaryFixedDim: Color(0xFF9EA5CB),
  onSecondaryFixed: Color(0xFF070918),
  onSecondaryFixedVariant: Color(0xFF0B0F26),
  tertiary: Color(0xFFBAA99D),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFF514239),
  onTertiaryContainer: Color(0xFFFFFFFF),
  tertiaryFixed: Color(0xFFDBD6D3),
  tertiaryFixedDim: Color(0xFFBCB3AE),
  onTertiaryFixed: Color(0xFF110E0C),
  onTertiaryFixedVariant: Color(0xFF1B1614),
  error: Color(0xFFCF6679),
  onError: Color(0xFF000000),
  errorContainer: Color(0xFFB1384E),
  onErrorContainer: Color(0xFFFFFFFF),
  surface: Color(0xFF080808),
  onSurface: Color(0xFFF1F1F1),
  surfaceDim: Color(0xFF060606),
  surfaceBright: Color(0xFF2C2C2C),
  surfaceContainerLowest: Color(0xFF010101),
  surfaceContainerLow: Color(0xFF0E0E0E),
  surfaceContainer: Color(0xFF151515),
  surfaceContainerHigh: Color(0xFF1D1D1D),
  surfaceContainerHighest: Color(0xFF282828),
  onSurfaceVariant: Color(0xFFCACACA),
  outline: Color(0xFF777777),
  outlineVariant: Color(0xFF414141),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFFE8E8E8),
  onInverseSurface: Color(0xFF2A2A2A),
  inversePrimary: Color(0xFF52666B),
  surfaceTint: Color(0xFFB4E6FF),
);
