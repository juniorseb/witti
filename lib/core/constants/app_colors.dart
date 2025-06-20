import 'package:flutter/material.dart';

/// Classe contenant toutes les couleurs de l'application MyWitti
/// Basée sur le fichier "Information code couleur.txt"
class AppColors {
  // Constructeur privé pour empêcher l'instanciation
  AppColors._();

  // ==========================================
  // ONBOARDING COLORS
  // ==========================================
  
  /// Bordure dorée : DBC680
  static const Color goldenBorder = Color(0xFFDBC680);
  
  /// Fond de bienvenue : 262E55 (71%) (variante de bleu)
  static const Color welcomeBackground = Color(0xFF262E55);
  
  /// Texte "Démarrer" : 04102C (variante de bleu nuit)
  static const Color startButtonText = Color(0xFF04102C);
  
  /// Couleur de texte : FFFFFF (blanc)
  static const Color whiteText = Color(0xFFFFFFFF);

  // ==========================================
  // PAGE DE PUBLICITÉ COLORS
  // ==========================================
  
  /// Couleur des points : FFFFFF (blanc) et E0CD68 (doré)
  static const Color adDotsWhite = Color(0xFFFFFFFF);
  static const Color adDotsGolden = Color(0xFFE0CD68);
  
  /// Couleur de barre de progression : FFFFFF (blanc)
  static const Color progressBarBackground = Color(0xFFFFFFFF);
  
  /// Couleur de progression : E0CD68 (doré)
  static const Color progressBarFill = Color(0xFFE0CD68);

  // ==========================================
  // PAGE DE CONNEXION COLORS
  // ==========================================
  
  /// Contour de input : DBC680 (doré)
  static const Color inputBorder = Color(0xFFDBC680);
  
  /// Fond de input : 0F2562 (variante de bleu)
  static const Color inputBackground = Color(0xFF0F2562);
  
  /// Couleur du bouton "Se souvenir de moi" : F8AA1E (jaune)
  static const Color rememberMeButton = Color(0xFFF8AA1E);
  
  /// Texte "Conditions d'utilisation" et "politique de confidentialité" : FFF940 79% (jaune)
  static const Color termsText = Color(0xFFFFF940);

  // ==========================================
  // DASHBOARD COLORS
  // ==========================================
  
  /// Fond icon notification : FBC525 (jaune)
  static const Color notificationBackground = Color(0xFFFBC525);
  
  /// Fond icon alerte : ED4719 (rouge)
  static const Color alertBackground = Color(0xFFED4719);
  
  /// Arrière plan étoile de catégorie : 00B8C4 (bleu ciel)
  static const Color categoryStarBackground = Color(0xFF00B8C4);
  
  /// Fond catégorie executive : A5D5E6 (bleu ciel)
  static const Color executiveBackground = Color(0xFFA5D5E6);
  
  /// Fond catégorie executive + : D08027 (marron ciel)
  static const Color executivePlusBackground = Color(0xFFD08027);
  
  /// Fond catégorie first class : EC8700 (marron clair)
  static const Color firstClassBackground = Color(0xFFEC8700);
  
  /// Fond catégorie eco premium : 0D275A (bleu pur)
  static const Color ecoPremiumBackground = Color(0xFF0D275A);
  
  /// Fond icon retrait depot : FFFFFF (blanc)
  static const Color depositWithdrawIconBackground = Color(0xFFFFFFFF);
  
  /// Couleur de depot : 369F90 (vert)
  static const Color depositColor = Color(0xFF369F90);
  
  /// Couleur de retrait : B73815 (rouge)
  static const Color withdrawColor = Color(0xFFB73815);
  
  /// Trait entre les transactions : 000000 23% (gris sombre)
  static const Color transactionSeparator = Color(0x3D000000);
  
  /// Fond de transaction : F5F8FF (bleu blanchi)
  static const Color transactionBackground = Color(0xFFF5F8FF);
  
  /// Texte "depot" "retrait" : 151C2A 87% (bleu nuit)
  static const Color depositWithdrawText = Color(0xDE151C2A);
  
  /// Texte "Virement bancaire" : 7988A3
  static const Color transferMethodText = Color(0xFF7988A3);
  
  /// Fond barre de navigation : 0D275A (bleu nuit)
  static const Color navigationBackground = Color(0xFF0D275A);
  
  /// Onglet actif : FFFFFF (blanc)
  static const Color activeTab = Color(0xFFFFFFFF);
  
  /// Onglet non actif : FFFFFF 50%
  static const Color inactiveTab = Color(0x80FFFFFF);
  
  /// Contour block du titre : F6C54D (doré)
  static const Color titleBlockBorder = Color(0xFFF6C54D);
  
  /// Progression de catégorie : A6D5E7 (bleu ciel)
  static const Color categoryProgress = Color(0xFFA6D5E7);

  // ==========================================
  // HISTORIQUE COLORS
  // ==========================================
  
  /// Texte "Tendance des transactions" : 000000 (noir)
  static const Color trendsTitle = Color(0xFF000000);
  
  /// Fond du bloc de tendance de transactions : F5F8FF (bleu ciel)
  static const Color trendsBlockBackground = Color(0xFFF5F8FF);
  
  /// Fond de periode : FFFFFF (blanc)
  static const Color periodBackground = Color(0xFFFFFFFF);
  
  /// Contour période : C5C4C4
  static const Color periodBorder = Color(0xFFC5C4C4);
  
  /// "Periode" : 151C2A 87%
  static const Color periodLabel = Color(0xDE151C2A);
  
  /// "Mars 2025" : 7988A3
  static const Color periodValue = Color(0xFF7988A3);
  
  /// Fond filtre actif : D08027 (orange)
  static const Color activeFilterBackground = Color(0xFFD08027);
  
  /// Text filtre actif : FFFFFF (blanc)
  static const Color activeFilterText = Color(0xFFFFFFFF);
  
  /// Fond filtre inactif : FFFFFF (blanc)
  static const Color inactiveFilterBackground = Color(0xFFFFFFFF);
  
  /// Text filtre inactif : 333333 (gris) 33%
  static const Color inactiveFilterText = Color(0x54333333);
  
  /// Contour filtre inactif : 000000 (noir)
  static const Color inactiveFilterBorder = Color(0xFF000000);

  // ==========================================
  // COULEURS UTILITAIRES
  // ==========================================
  
  /// Transparent
  static const Color transparent = Colors.transparent;
  
  /// Noir complet
  static const Color black = Color(0xFF000000);
  
  /// Blanc complet
  static const Color white = Color(0xFFFFFFFF);

  // ==========================================
  // COULEURS AVEC OPACITÉ PRÉDÉFINIES
  // ==========================================
  
  /// Blanc 50% d'opacité
  static const Color white50 = Color(0x80FFFFFF);
  
  /// Blanc 80% d'opacité
  static const Color white80 = Color(0xCCFFFFFF);
  
  /// Noir 23% d'opacité
  static const Color black23 = Color(0x3D000000);
  
  /// Noir 87% d'opacité
  static const Color black87 = Color(0xDE000000);

  // ==========================================
  // GRADIENTS PRÉDÉFINIS
  // ==========================================
  
  /// Gradient principal de l'application (fond d'écran)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      welcomeBackground,
      Color(0xFF1A2042), // Version plus sombre pour le dégradé
    ],
  );
  
  /// Gradient doré
  static const LinearGradient goldenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      goldenBorder,
      adDotsGolden,
    ],
  );

  // ==========================================
  // MÉTHODES UTILITAIRES
  // ==========================================
  
  /// Retourne une couleur avec l'opacité spécifiée
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
  
  /// Retourne la couleur appropriée pour le texte selon le fond
  static Color getTextColorForBackground(Color backgroundColor) {
    // Calcul de la luminance pour déterminer si le fond est clair ou sombre
    final double luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? black : white;
  }
  
  /// Retourne la couleur de catégorie selon le type
  static Color getCategoryColor(String categoryType) {
    switch (categoryType.toLowerCase()) {
      case 'executive':
        return executiveBackground;
      case 'executive+':
      case 'executive plus':
        return executivePlusBackground;
      case 'first class':
      case 'firstclass':
        return firstClassBackground;
      case 'eco premium':
      case 'ecopremium':
        return ecoPremiumBackground;
      default:
        return executiveBackground;
    }
  }
  
  /// Retourne la couleur selon le type de transaction
  static Color getTransactionColor(String transactionType) {
    switch (transactionType.toLowerCase()) {
      case 'depot':
      case 'dépôt':
      case 'deposit':
        return depositColor;
      case 'retrait':
      case 'withdrawal':
        return withdrawColor;
      default:
        return black87;
    }
  }
}