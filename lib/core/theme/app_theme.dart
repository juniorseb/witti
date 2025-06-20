import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';

/// Configuration du thème global de l'application MyWitti
/// Utilise les couleurs et polices définies dans les fichiers constants
class AppTheme {
  // Constructeur privé pour empêcher l'instanciation
  AppTheme._();

  // ==========================================
  // THÈME PRINCIPAL
  // ==========================================

  /// Thème principal de l'application MyWitti
  static ThemeData get theme {
    return ThemeData(
      // Configuration de base
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Couleurs principales
      primarySwatch: _createMaterialColor(AppColors.goldenBorder),
      primaryColor: AppColors.goldenBorder,
      scaffoldBackgroundColor: AppColors.welcomeBackground,
      canvasColor: AppColors.welcomeBackground,
      
      // Couleurs de surface
      colorScheme: _colorScheme,
      
      // Configuration de l'AppBar
      appBarTheme: _appBarTheme,
      
      // Configuration des boutons
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      
      // Configuration des champs de texte
      inputDecorationTheme: _inputDecorationTheme,
      
      // Configuration de la navigation bottom
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      
      // Configuration des cartes
      cardTheme: _cardTheme,
      
      // Configuration des dialogues
      dialogTheme: _dialogTheme,
      
      // Configuration des snackbars
      snackBarTheme: _snackBarTheme,
      
      // Configuration des dividers
      dividerTheme: _dividerTheme,
      
      // Configuration des switch et checkbox
      switchTheme: _switchTheme,
      checkboxTheme: _checkboxTheme,
      
      // Configuration du texte global
      textTheme: _textTheme,
      
      // Configuration des icônes
      iconTheme: _iconTheme,
      
      // Configuration des indicateurs de progression
      progressIndicatorTheme: _progressIndicatorTheme,
      
      // Extensions personnalisées
      extensions: [
        _customColors,
      ],
    );
  }

  // ==========================================
  // COLOR SCHEME
  // ==========================================

  static ColorScheme get _colorScheme {
    return ColorScheme.fromSeed(
      seedColor: AppColors.goldenBorder,
      brightness: Brightness.dark,
      primary: AppColors.goldenBorder,
      onPrimary: AppColors.startButtonText,
      primaryContainer: AppColors.inputBackground,
      onPrimaryContainer: AppColors.whiteText,
      secondary: AppColors.categoryStarBackground,
      onSecondary: AppColors.whiteText,
      tertiary: AppColors.depositColor,
      onTertiary: AppColors.whiteText,
      error: AppColors.withdrawColor,
      onError: AppColors.whiteText,
      surface: AppColors.transactionBackground,
      onSurface: AppColors.depositWithdrawText,
      background: AppColors.welcomeBackground,
      onBackground: AppColors.whiteText,
      outline: AppColors.inputBorder,
      shadow: AppColors.black23,
    );
  }

  // ==========================================
  // APP BAR THEME
  // ==========================================

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      backgroundColor: AppColors.navigationBackground,
      foregroundColor: AppColors.whiteText,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: AppFonts.dashboardTitle,
      iconTheme: const IconThemeData(
        color: AppColors.whiteText,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: AppColors.whiteText,
        size: 24,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  // ==========================================
  // BUTTON THEMES
  // ==========================================

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.goldenBorder,
        foregroundColor: AppColors.startButtonText,
        elevation: 0,
        shadowColor: AppColors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: AppFonts.buttonText,
        minimumSize: const Size(double.infinity, 56),
      ),
    );
  }

  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.whiteText,
        side: const BorderSide(
          color: AppColors.goldenBorder,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: AppFonts.buttonText.copyWith(color: AppColors.whiteText),
        minimumSize: const Size(double.infinity, 56),
      ),
    );
  }

  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.termsText,
        textStyle: AppFonts.termsText,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }

  // ==========================================
  // INPUT DECORATION THEME
  // ==========================================

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.inputBorder,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.inputBorder,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.goldenBorder,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.withdrawColor,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.withdrawColor,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.all(16),
      hintStyle: AppFonts.inputHint,
      labelStyle: AppFonts.inputLabel,
      floatingLabelStyle: AppFonts.inputLabel.copyWith(
        color: AppColors.goldenBorder,
      ),
      prefixIconColor: AppColors.white50,
      suffixIconColor: AppColors.white50,
    );
  }

  // ==========================================
  // BOTTOM NAVIGATION THEME
  // ==========================================

  static BottomNavigationBarThemeData get _bottomNavigationBarTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: AppColors.navigationBackground,
      selectedItemColor: AppColors.activeTab,
      unselectedItemColor: AppColors.inactiveTab,
      selectedLabelStyle: AppFonts.navigationLabel,
      unselectedLabelStyle: AppFonts.navigationLabelInactive,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      enableFeedback: true,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  // ==========================================
  // CARD THEME
  // ==========================================

  static CardThemeData get _cardTheme {
    return CardThemeData(
      color: AppColors.transactionBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(8),
    );
  }

  // ==========================================
  // DIALOG THEME
  // ==========================================

  static DialogThemeData get _dialogTheme {
    return DialogThemeData(
      backgroundColor: AppColors.transactionBackground,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: AppFonts.dashboardTitle.copyWith(
        color: AppColors.depositWithdrawText,
      ),
      contentTextStyle: AppFonts.poppinsRegular(
        color: AppColors.depositWithdrawText,
      ),
    );
  }

  // ==========================================
  // SNACKBAR THEME
  // ==========================================

  static SnackBarThemeData get _snackBarTheme {
    return SnackBarThemeData(
      backgroundColor: AppColors.navigationBackground,
      contentTextStyle: AppFonts.poppinsRegular(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    );
  }

  // ==========================================
  // DIVIDER THEME
  // ==========================================

  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: AppColors.transactionSeparator,
      thickness: 1,
      space: 1,
    );
  }

  // ==========================================
  // SWITCH & CHECKBOX THEMES
  // ==========================================

  static SwitchThemeData get _switchTheme {
    return SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.goldenBorder;
        }
        return AppColors.white50;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.rememberMeButton;
        }
        return AppColors.inputBackground;
      }),
    );
  }

  static CheckboxThemeData get _checkboxTheme {
    return CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.rememberMeButton;
        }
        return AppColors.transparent;
      }),
      checkColor: MaterialStateProperty.all(AppColors.whiteText),
      side: const BorderSide(
        color: AppColors.rememberMeButton,
        width: 2,
      ),
    );
  }

  // ==========================================
  // TEXT THEME
  // ==========================================

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: AppFonts.poppinsBold(fontSize: 32),
      displayMedium: AppFonts.poppinsBold(fontSize: 28),
      displaySmall: AppFonts.poppinsBold(fontSize: 24),
      headlineLarge: AppFonts.poppinsSemiBold(fontSize: 22),
      headlineMedium: AppFonts.poppinsSemiBold(fontSize: 20),
      headlineSmall: AppFonts.poppinsSemiBold(fontSize: 18),
      titleLarge: AppFonts.poppinsMedium(fontSize: 16),
      titleMedium: AppFonts.poppinsMedium(fontSize: 14),
      titleSmall: AppFonts.poppinsMedium(fontSize: 12),
      bodyLarge: AppFonts.poppinsRegular(fontSize: 16),
      bodyMedium: AppFonts.poppinsRegular(fontSize: 14),
      bodySmall: AppFonts.poppinsRegular(fontSize: 12),
      labelLarge: AppFonts.interMedium(fontSize: 14),
      labelMedium: AppFonts.interMedium(fontSize: 12),
      labelSmall: AppFonts.interMedium(fontSize: 10),
    );
  }

  // ==========================================
  // ICON THEME
  // ==========================================

  static IconThemeData get _iconTheme {
    return const IconThemeData(
      color: AppColors.whiteText,
      size: 24,
    );
  }

  // ==========================================
  // PROGRESS INDICATOR THEME
  // ==========================================

  static ProgressIndicatorThemeData get _progressIndicatorTheme {
    return const ProgressIndicatorThemeData(
      color: AppColors.goldenBorder,
      linearTrackColor: AppColors.white50,
      circularTrackColor: AppColors.white50,
    );
  }

  // ==========================================
  // CUSTOM COLORS EXTENSION
  // ==========================================

  static CustomColors get _customColors {
    return const CustomColors(
      golden: AppColors.goldenBorder,
      deposit: AppColors.depositColor,
      withdraw: AppColors.withdrawColor,
      notification: AppColors.notificationBackground,
      alert: AppColors.alertBackground,
      executive: AppColors.executiveBackground,
      executivePlus: AppColors.executivePlusBackground,
      firstClass: AppColors.firstClassBackground,
      ecoPremium: AppColors.ecoPremiumBackground,
    );
  }

  // ==========================================
  // MÉTHODES UTILITAIRES
  // ==========================================

  /// Crée un MaterialColor à partir d'une Color
  static MaterialColor _createMaterialColor(Color color) {
    List<double> strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (double strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }

  /// Applique le thème sombre personnalisé
  static SystemUiOverlayStyle get systemOverlayStyle {
    return const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.navigationBackground,
      systemNavigationBarIconBrightness: Brightness.light,
    );
  }

  /// Retourne des decorations communes
  static BoxDecoration get goldenBorderDecoration {
    return BoxDecoration(
      border: Border.all(
        color: AppColors.titleBlockBorder,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(16),
    );
  }

  static BoxDecoration get cardDecoration {
    return BoxDecoration(
      color: AppColors.transactionBackground,
      borderRadius: BorderRadius.circular(12),
    );
  }

  static BoxDecoration get gradientDecoration {
    return const BoxDecoration(
      gradient: AppColors.primaryGradient,
    );
  }
}

// ==========================================
// EXTENSION POUR COULEURS PERSONNALISÉES
// ==========================================

/// Extension de couleurs personnalisées pour ThemeData
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.golden,
    required this.deposit,
    required this.withdraw,
    required this.notification,
    required this.alert,
    required this.executive,
    required this.executivePlus,
    required this.firstClass,
    required this.ecoPremium,
  });

  final Color golden;
  final Color deposit;
  final Color withdraw;
  final Color notification;
  final Color alert;
  final Color executive;
  final Color executivePlus;
  final Color firstClass;
  final Color ecoPremium;

  @override
  CustomColors copyWith({
    Color? golden,
    Color? deposit,
    Color? withdraw,
    Color? notification,
    Color? alert,
    Color? executive,
    Color? executivePlus,
    Color? firstClass,
    Color? ecoPremium,
  }) {
    return CustomColors(
      golden: golden ?? this.golden,
      deposit: deposit ?? this.deposit,
      withdraw: withdraw ?? this.withdraw,
      notification: notification ?? this.notification,
      alert: alert ?? this.alert,
      executive: executive ?? this.executive,
      executivePlus: executivePlus ?? this.executivePlus,
      firstClass: firstClass ?? this.firstClass,
      ecoPremium: ecoPremium ?? this.ecoPremium,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      golden: Color.lerp(golden, other.golden, t)!,
      deposit: Color.lerp(deposit, other.deposit, t)!,
      withdraw: Color.lerp(withdraw, other.withdraw, t)!,
      notification: Color.lerp(notification, other.notification, t)!,
      alert: Color.lerp(alert, other.alert, t)!,
      executive: Color.lerp(executive, other.executive, t)!,
      executivePlus: Color.lerp(executivePlus, other.executivePlus, t)!,
      firstClass: Color.lerp(firstClass, other.firstClass, t)!,
      ecoPremium: Color.lerp(ecoPremium, other.ecoPremium, t)!,
    );
  }
}

// ==========================================
// EXTENSION POUR ACCÉDER AUX COULEURS CUSTOM
// ==========================================

extension CustomColorsExtension on ThemeData {
  CustomColors get customColors =>
      extension<CustomColors>() ?? AppTheme._customColors;
}