import 'package:flutter/material.dart';
import 'app_themes.dart';

/// Mixin pour faciliter l'utilisation des couleurs du thème
mixin ThemeAware {
  
  /// Couleurs personnalisées du thème
  CustomColors getCustomColors(BuildContext context) {
    return Theme.of(context).extension<CustomColors>()!;
  }
  
  /// Couleur primaire du thème
  Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }
  
  /// Couleur de surface du thème (cartes, containers)
  Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).cardColor;
  }
  
  /// Couleur de fond du thème
  Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }
  
  /// Couleur de texte principal
  Color getTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }
  
  /// Couleur de texte secondaire
  Color getSecondaryTextColor(BuildContext context) {
    return getCustomColors(context).textSecondary;
  }
  
  /// Couleur de succès
  Color getSuccessColor(BuildContext context) {
    return getCustomColors(context).success;
  }
  
  /// Gradient principal
  List<Color> getPrimaryGradient(BuildContext context) {
    return getCustomColors(context).gradient;
  }
  
  /// Gradient de succès
  List<Color> getSuccessGradient(BuildContext context) {
    return getCustomColors(context).successGradient;
  }
  
  /// Style de texte principal
  TextStyle getPrimaryTextStyle(BuildContext context, {
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: getTextColor(context),
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
  
  /// Style de texte secondaire
  TextStyle getSecondaryTextStyle(BuildContext context, {
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: getSecondaryTextColor(context),
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
  
  /// Decoration pour les containers avec thème
  BoxDecoration getCardDecoration(BuildContext context, {
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: getSurfaceColor(context),
      borderRadius: borderRadius ?? BorderRadius.circular(15),
      boxShadow: boxShadow ?? [
        BoxShadow(
          color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
  
  /// Decoration pour les gradients
  BoxDecoration getGradientDecoration(BuildContext context, {
    BorderRadius? borderRadius,
    List<Color>? colors,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: colors ?? getPrimaryGradient(context),
      ),
      borderRadius: borderRadius ?? BorderRadius.circular(15),
    );
  }
}