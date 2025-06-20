import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Classe contenant tous les styles de texte de l'application MyWitti
/// Basée sur les spécifications typographiques du fichier "Information code couleur.txt"
class AppFonts {
  // Constructeur privé pour empêcher l'instanciation
  AppFonts._();

  // ==========================================
  // POPPINS FONT STYLES
  // ==========================================

  /// POPPINS BOLD - Utilisé pour les titres principaux
  static TextStyle poppinsBold({
    double fontSize = 16,
    Color color = AppColors.whiteText,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// POPPINS SEMIBOLD - Utilisé pour les sous-titres importants
  static TextStyle poppinsSemiBold({
    double fontSize = 16,
    Color color = AppColors.whiteText,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// POPPINS MEDIUM - Utilisé pour les textes moyennement importants
  static TextStyle poppinsMedium({
    double fontSize = 16,
    Color color = AppColors.whiteText,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// POPPINS REGULAR - Utilisé pour le texte de base
  static TextStyle poppinsRegular({
    double fontSize = 16,
    Color color = AppColors.whiteText,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// POPPINS ITALIC - Utilisé pour les timestamps
  static TextStyle poppinsItalic({
    double fontSize = 16,
    Color color = AppColors.whiteText,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // ==========================================
  // INTER FONT STYLES
  // ==========================================

  /// INTER BOLD - Utilisé pour les catégories et pourcentages
  static TextStyle interBold({
    double fontSize = 16,
    Color color = AppColors.black,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// INTER EXTRA BOLD - Utilisé pour les pourcentages importants
  static TextStyle interExtraBold({
    double fontSize = 16,
    Color color = AppColors.black,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// INTER MEDIUM - Utilisé pour la navigation
  static TextStyle interMedium({
    double fontSize = 16,
    Color color = AppColors.whiteText,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// INTER REGULAR - Utilisé pour les descriptions
  static TextStyle interRegular({
    double fontSize = 16,
    Color color = AppColors.black,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // ==========================================
  // ROBOTO FONT STYLES
  // ==========================================

  /// ROBOTO BOLD - Utilisé pour les filtres
  static TextStyle robotoBold({
    double fontSize = 16,
    Color color = AppColors.whiteText,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// ROBOTO MEDIUM - Utilisé pour les montants et périodes
  static TextStyle robotoMedium({
    double fontSize = 16,
    Color color = AppColors.depositWithdrawText,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// ROBOTO REGULAR - Utilisé pour les valeurs de période
  static TextStyle robotoRegular({
    double fontSize = 16,
    Color color = AppColors.periodValue,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // ==========================================
  // STYLES PRÉDÉFINIS PAR ÉCRAN
  // ==========================================

  // ONBOARDING STYLES
  static TextStyle get onboardingTitle => poppinsSemiBold(
        fontSize: 28,
        color: AppColors.whiteText,
        letterSpacing: 2,
      );

  static TextStyle get onboardingSubtitle => poppinsRegular(
        fontSize: 16,
        color: AppColors.white80,
        height: 1.5,
      );

  static TextStyle get welcomeText => poppinsSemiBold(
        fontSize: 32,
        color: AppColors.whiteText,
      );

  static TextStyle get logoText => poppinsBold(
        fontSize: 48,
        color: AppColors.whiteText,
        height: 1.0,
      );

  // LOGIN STYLES
  static TextStyle get loginTitle => poppinsBold(
        fontSize: 32,
        color: AppColors.whiteText,
      );

  static TextStyle get inputLabel => poppinsBold(
        fontSize: 16,
        color: AppColors.whiteText,
      );

  static TextStyle get inputText => poppinsSemiBold(
        fontSize: 16,
        color: AppColors.whiteText,
      );

  static TextStyle get inputHint => poppinsSemiBold(
        fontSize: 16,
        color: AppColors.white50,
      );

  static TextStyle get forgotPassword => poppinsSemiBold(
        fontSize: 14,
        color: AppColors.white80,
      );

  static TextStyle get rememberMeText => poppinsRegular(
        fontSize: 14,
        color: AppColors.whiteText,
      );

  static TextStyle get termsText => poppinsRegular(
        fontSize: 12,
        color: AppColors.termsText,
      );

  static TextStyle get buttonText => poppinsRegular(
        fontSize: 18,
        color: AppColors.startButtonText,
      );

  // DASHBOARD STYLES
  static TextStyle get dashboardTitle => poppinsBold(
        fontSize: 24,
        color: AppColors.whiteText,
      );

  static TextStyle get welcomeUser => poppinsBold(
        fontSize: 16,
        color: AppColors.white80,
      );

  static TextStyle get tokenAmount => poppinsBold(
        fontSize: 48,
        color: AppColors.whiteText,
      );

  static TextStyle get tokenLabel => poppinsRegular(
        fontSize: 16,
        color: AppColors.whiteText,
      );

  static TextStyle get categoryTitle => poppinsBold(
        fontSize: 18,
        color: AppColors.whiteText,
      );

  static TextStyle get categoryName => interBold(
        fontSize: 16,
        color: AppColors.startButtonText,
      );

  static TextStyle get categoryPercentage => interBold(
        fontSize: 16,
        color: AppColors.startButtonText,
      );

  static TextStyle get categoryProgress => interRegular(
        fontSize: 12,
        color: AppColors.startButtonText,
      );

  static TextStyle get transactionTitle => poppinsBold(
        fontSize: 18,
        color: AppColors.whiteText,
      );

  static TextStyle get transactionType => poppinsMedium(
        fontSize: 14,
        color: AppColors.depositWithdrawText,
      );

  static TextStyle get transactionMethod => poppinsRegular(
        fontSize: 12,
        color: AppColors.transferMethodText,
      );

  static TextStyle get transactionAmount => robotoMedium(
        fontSize: 14,
        color: AppColors.depositWithdrawText,
      );

  static TextStyle get transactionTime => poppinsItalic(
        fontSize: 11,
        color: AppColors.transferMethodText,
      );

  // NAVIGATION STYLES
  static TextStyle get navigationLabel => interMedium(
        fontSize: 12,
        color: AppColors.activeTab,
      );

  static TextStyle get navigationLabelInactive => interMedium(
        fontSize: 12,
        color: AppColors.inactiveTab,
      );

  // HISTORY STYLES
  static TextStyle get historyTitle => poppinsBold(
        fontSize: 20,
        color: AppColors.whiteText,
      );

  static TextStyle get trendsTitle => poppinsBold(
        fontSize: 18,
        color: AppColors.trendsTitle,
      );

  static TextStyle get periodLabel => robotoMedium(
        fontSize: 14,
        color: AppColors.periodLabel,
      );

  static TextStyle get periodValue => robotoRegular(
        fontSize: 14,
        color: AppColors.periodValue,
      );

  static TextStyle get chartPercentage => interExtraBold(
        fontSize: 16,
        color: AppColors.whiteText,
      );

  static TextStyle get filterActiveText => robotoBold(
        fontSize: 12,
        color: AppColors.activeFilterText,
      );

  static TextStyle get filterInactiveText => robotoBold(
        fontSize: 12,
        color: AppColors.inactiveFilterText,
      );

  // ==========================================
  // MÉTHODES UTILITAIRES
  // ==========================================

  /// Retourne un style de texte adaptatif selon la taille d'écran
  static TextStyle responsive({
    required BuildContext context,
    required TextStyle baseStyle,
    double? mobileScale,
    double? tabletScale,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    double scale = 1.0;

    if (screenWidth < 600) {
      // Mobile
      scale = mobileScale ?? 1.0;
    } else if (screenWidth < 1024) {
      // Tablet
      scale = tabletScale ?? 1.1;
    } else {
      // Desktop
      scale = 1.2;
    }

    return baseStyle.copyWith(
      fontSize: (baseStyle.fontSize ?? 16) * scale,
    );
  }

  /// Retourne un style avec une couleur personnalisée
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Retourne un style avec une taille personnalisée
  static TextStyle withSize(TextStyle style, double fontSize) {
    return style.copyWith(fontSize: fontSize);
  }

  /// Retourne un style avec une hauteur de ligne personnalisée
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }

  /// Applique un style de bouton selon l'état
  static TextStyle getButtonStyle({
    required bool isActive,
    double fontSize = 16,
  }) {
    return isActive
        ? poppinsSemiBold(
            fontSize: fontSize,
            color: AppColors.startButtonText,
          )
        : poppinsRegular(
            fontSize: fontSize,
            color: AppColors.white50,
          );
  }

  /// Retourne le style approprié pour un type de transaction
  static TextStyle getTransactionStyle(String transactionType) {
    final color = AppColors.getTransactionColor(transactionType);
    return poppinsMedium(
      fontSize: 14,
      color: color,
    );
  }
}