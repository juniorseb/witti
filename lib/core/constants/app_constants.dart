import 'package:flutter/material.dart';

/// Classe contenant toutes les constantes générales de l'application MyWitti
/// Configuration, URLs, dimensions, durées, etc.
class AppConstants {
  // Constructeur privé pour empêcher l'instanciation
  AppConstants._();

  // ==========================================
  // INFORMATIONS DE L'APPLICATION
  // ==========================================

  /// Nom de l'application
  static const String appName = 'MyWitti';
  
  /// Version actuelle de l'application
  static const String appVersion = '1.0.0';
  
  /// Code de version (build number)
  static const int appBuildNumber = 1;
  
  /// Description de l'application
  static const String appDescription = 'Programme de fidélité digital - Gestion de jetons et récompenses';
  
  /// Package name / Bundle ID
  static const String packageName = 'com.mywitti.app';

  // ==========================================
  // CONFIGURATION RÉSEAU
  // ==========================================

  /// URL de base de l'API en production
  static const String baseUrlProd = 'https://api.mywitti.com';
  
  /// URL de base de l'API en développement
  static const String baseUrlDev = 'https://dev-api.mywitti.com';
  
  /// URL de base de l'API en staging
  static const String baseUrlStaging = 'https://staging-api.mywitti.com';
  
  /// URL de base actuelle (à changer selon l'environnement)
  static const String baseUrl = baseUrlDev; // Changez selon l'environnement
  
  /// Version de l'API
  static const String apiVersion = 'v1';
  
  /// URL complète de l'API
  static const String apiBaseUrl = '$baseUrl/api/$apiVersion';
  
  /// Timeout pour les requêtes HTTP (en millisecondes)
  static const int httpTimeout = 30000; // 30 secondes
  
  /// Timeout pour la connexion (en millisecondes)
  static const int connectTimeout = 15000; // 15 secondes
  
  /// Timeout pour la réception (en millisecondes)
  static const int receiveTimeout = 30000; // 30 secondes

  // ==========================================
  // ENDPOINTS API
  // ==========================================

  /// Endpoints d'authentification
  static const String loginEndpoint = '/auth/login';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  
  /// Endpoints utilisateur
  static const String userProfileEndpoint = '/user/profile';
  static const String updateProfileEndpoint = '/user/update';
  static const String dashboardEndpoint = '/user/dashboard';
  
  /// Endpoints transactions
  static const String transactionsEndpoint = '/transactions';
  static const String transactionStatsEndpoint = '/transactions/stats';
  static const String depositEndpoint = '/transactions/deposit';
  static const String withdrawalEndpoint = '/transactions/withdrawal';
  
  /// Endpoints récompenses
  static const String rewardsEndpoint = '/rewards';
  static const String claimRewardEndpoint = '/rewards/claim';
  static const String userRewardsEndpoint = '/user/rewards';
  
  /// Endpoints notifications
  static const String notificationsEndpoint = '/notifications';
  static const String markAsReadEndpoint = '/notifications/mark-read';

  // ==========================================
  // DIMENSIONS ET TAILLES
  // ==========================================

  /// Padding et margins standards
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 32.0;
  
  /// BorderRadius standards
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusExtraLarge = 20.0;
  
  /// Épaisseur des bordures
  static const double borderWidthThin = 1.0;
  static const double borderWidthMedium = 2.0;
  static const double borderWidthThick = 3.0;
  
  /// Hauteurs des composants
  static const double buttonHeight = 56.0;
  static const double inputFieldHeight = 56.0;
  static const double appBarHeight = 60.0;
  static const double bottomNavHeight = 80.0;
  
  /// Tailles des icônes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeExtraLarge = 48.0;
  
  /// Tailles des avatars
  static const double avatarSizeSmall = 32.0;
  static const double avatarSizeMedium = 48.0;
  static const double avatarSizeLarge = 64.0;
  static const double avatarSizeExtraLarge = 96.0;
  
  /// Tailles d'images selon vos spécifications
  static const double categoryImageWidth = 270.0;
  static const double categoryImageHeight = 330.0;
  static const double categoryImageRadius = 40.0;

  // ==========================================
  // DURÉES D'ANIMATIONS
  // ==========================================

  /// Durées d'animations standards
  static const Duration animationDurationFast = Duration(milliseconds: 150);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);
  static const Duration animationDurationExtraSlow = Duration(milliseconds: 800);
  
  /// Durées pour les transitions de pages
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  
  /// Durée pour les snackbars
  static const Duration snackBarDuration = Duration(seconds: 3);
  
  /// Durée pour les splash screens
  static const Duration splashDuration = Duration(seconds: 2);
  
  /// Délai avant auto-logout (en minutes)
  static const int autoLogoutDelay = 30;

  // ==========================================
  // PAGINATION ET LIMITES
  // ==========================================

  /// Nombre d'éléments par page
  static const int itemsPerPage = 20;
  
  /// Nombre maximum de transactions à afficher
  static const int maxTransactionsDisplay = 100;
  
  /// Nombre de transactions récentes sur le dashboard
  static const int recentTransactionsCount = 5;
  
  /// Nombre maximum de récompenses en cache
  static const int maxRewardsCache = 50;
  
  /// Limite de caractères pour les messages
  static const int maxMessageLength = 500;
  
  /// Limite de fichiers uploadés
  static const int maxFileUploadSize = 5 * 1024 * 1024; // 5 MB

  // ==========================================
  // CLÉS DE STOCKAGE LOCAL
  // ==========================================

  /// Clés pour SharedPreferences
  static const String keyAuthToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserEmail = 'user_email';
  static const String keyRememberMe = 'remember_me';
  static const String keyOnboardingCompleted = 'onboarding_completed';
  static const String keyBiometricEnabled = 'biometric_enabled';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyDarkModeEnabled = 'dark_mode_enabled';
  static const String keyLanguageCode = 'language_code';
  static const String keyLastLoginDate = 'last_login_date';
  static const String keyAppLaunchCount = 'app_launch_count';

  // ==========================================
  // CATÉGORIES UTILISATEUR
  // ==========================================

  /// Types de catégories selon vos spécifications
  static const String categoryExecutive = 'executive';
  static const String categoryExecutivePlus = 'executive_plus';
  static const String categoryFirstClass = 'first_class';
  static const String categoryEcoPremium = 'eco_premium';
  
  /// Seuils de jetons pour chaque catégorie
  static const Map<String, int> categoryThresholds = {
    categoryExecutive: 0,
    categoryExecutivePlus: 1000,
    categoryFirstClass: 5000,
    categoryEcoPremium: 10000,
  };
  
  /// Pourcentages de progression selon vos spécifications
  static const Map<String, double> categoryProgressColors = {
    categoryExecutive: 0.2, // 20%
    categoryExecutivePlus: 0.4,
    categoryFirstClass: 0.7,
    categoryEcoPremium: 1.0,
  };

  // ==========================================
  // TYPES DE TRANSACTIONS
  // ==========================================

  /// Types de transactions
  static const String transactionTypeDeposit = 'deposit';
  static const String transactionTypeWithdrawal = 'withdrawal';
  static const String transactionTypeTransfer = 'transfer';
  static const String transactionTypeReward = 'reward';
  
  /// Méthodes de paiement
  static const String paymentMethodBankTransfer = 'bank_transfer';
  static const String paymentMethodMobileMoney = 'mobile_money';
  static const String paymentMethodCard = 'card';
  
  /// Statuts de transaction
  static const String transactionStatusPending = 'pending';
  static const String transactionStatusCompleted = 'completed';
  static const String transactionStatusFailed = 'failed';
  static const String transactionStatusCancelled = 'cancelled';

  // ==========================================
  // TYPES DE RÉCOMPENSES
  // ==========================================

  /// Types de récompenses
  static const String rewardTypeVoucher = 'voucher';
  static const String rewardTypeDiscount = 'discount';
  static const String rewardTypeGift = 'gift';
  static const String rewardTypeExperience = 'experience';
  static const String rewardTypeTravel = 'travel';
  static const String rewardTypeFood = 'food';
  static const String rewardTypeShopping = 'shopping';
  
  /// Statuts de récompenses
  static const String rewardStatusAvailable = 'available';
  static const String rewardStatusClaimed = 'claimed';
  static const String rewardStatusExpired = 'expired';
  static const String rewardStatusUsed = 'used';

  // ==========================================
  // CONFIGURATION NOTIFICATIONS
  // ==========================================

  /// Types de notifications
  static const String notificationTypeTransaction = 'transaction';
  static const String notificationTypeReward = 'reward';
  static const String notificationTypePromotion = 'promotion';
  static const String notificationTypeSystem = 'system';
  
  /// Priorités de notifications
  static const String notificationPriorityLow = 'low';
  static const String notificationPriorityMedium = 'medium';
  static const String notificationPriorityHigh = 'high';
  static const String notificationPriorityUrgent = 'urgent';

  // ==========================================
  // FORMATS ET PATTERNS
  // ==========================================

  /// Formats de date
  static const String dateFormatFull = 'dd/MM/yyyy HH:mm';
  static const String dateFormatShort = 'dd/MM/yyyy';
  static const String dateFormatTime = 'HH:mm';
  static const String dateFormatMonth = 'MMMM yyyy';
  
  /// Patterns de validation
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[0-9]{8,15}$';
  static const String clientCodePattern = r'^[A-Z0-9]{6,12}$';
  
  /// Format de devise
  static const String currencySymbol = 'F';
  static const String currencyCode = 'FCFA';
  static const String currencyFormat = '#,##0';

  // ==========================================
  // BREAKPOINTS RESPONSIVE
  // ==========================================

  /// Breakpoints pour le responsive design
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;

  // ==========================================
  // CONFIGURATIONS DE DÉVELOPPEMENT
  // ==========================================

  /// Mode debug
  static const bool isDebugMode = true; // Changez en false pour la production
  
  /// Logging activé
  static const bool enableLogging = true;
  
  /// Analytics activées
  static const bool enableAnalytics = false; // Activez en production
  
  /// Crash reporting activé
  static const bool enableCrashReporting = false; // Activez en production

  // ==========================================
  // URLS EXTERNES
  // ==========================================

  /// URLs des politiques et support
  static const String privacyPolicyUrl = 'https://mywitti.com/privacy';
  static const String termsOfServiceUrl = 'https://mywitti.com/terms';
  static const String supportUrl = 'https://support.mywitti.com';
  static const String contactEmail = 'support@mywitti.com';
  static const String websiteUrl = 'https://mywitti.com';
  
  /// URLs des stores
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=$packageName';
  static const String appStoreUrl = 'https://apps.apple.com/app/id123456789';

  // ==========================================
  // MÉTHODES UTILITAIRES
  // ==========================================

  /// Retourne l'URL complète d'un endpoint
  static String getFullUrl(String endpoint) {
    return '$apiBaseUrl$endpoint';
  }

  /// Retourne le seuil de la catégorie suivante
  static int getNextCategoryThreshold(String currentCategory) {
    switch (currentCategory) {
      case categoryExecutive:
        return categoryThresholds[categoryExecutivePlus]!;
      case categoryExecutivePlus:
        return categoryThresholds[categoryFirstClass]!;
      case categoryFirstClass:
        return categoryThresholds[categoryEcoPremium]!;
      case categoryEcoPremium:
        return categoryThresholds[categoryEcoPremium]!; // Déjà au maximum
      default:
        return categoryThresholds[categoryExecutivePlus]!;
    }
  }

  /// Retourne la catégorie suivante
  static String getNextCategory(String currentCategory) {
    switch (currentCategory) {
      case categoryExecutive:
        return categoryExecutivePlus;
      case categoryExecutivePlus:
        return categoryFirstClass;
      case categoryFirstClass:
        return categoryEcoPremium;
      case categoryEcoPremium:
        return categoryEcoPremium; // Déjà au maximum
      default:
        return categoryExecutivePlus;
    }
  }

  /// Calcule les jetons nécessaires pour la catégorie suivante
  static int getTokensNeededForNextCategory(String currentCategory, int currentTokens) {
    int nextThreshold = getNextCategoryThreshold(currentCategory);
    return nextThreshold - currentTokens;
  }

  /// Calcule le pourcentage de progression vers la catégorie suivante
  static double getCategoryProgress(String currentCategory, int currentTokens) {
    int currentThreshold = categoryThresholds[currentCategory] ?? 0;
    int nextThreshold = getNextCategoryThreshold(currentCategory);
    
    if (nextThreshold == currentThreshold) return 1.0; // Catégorie maximale
    
    double progress = (currentTokens - currentThreshold) / (nextThreshold - currentThreshold);
    return progress.clamp(0.0, 1.0);
  }

  /// Vérifie si l'application est en mode debug
  static bool get isDebug {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  /// Retourne l'environnement actuel
  static String get environment {
    if (baseUrl == baseUrlProd) return 'production';
    if (baseUrl == baseUrlStaging) return 'staging';
    return 'development';
  }

  /// Validation d'email
  static bool isValidEmail(String email) {
    return RegExp(emailPattern).hasMatch(email);
  }

  /// Validation de téléphone
  static bool isValidPhone(String phone) {
    return RegExp(phonePattern).hasMatch(phone);
  }

  /// Validation de code client
  static bool isValidClientCode(String code) {
    return RegExp(clientCodePattern).hasMatch(code);
  }

  /// Formate un montant en devise locale
  static String formatCurrency(double amount) {
    String formattedAmount = amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]} ',
    );
    return '$formattedAmount $currencyCode';
  }

  /// Retourne la durée d'animation selon la complexité
  static Duration getAnimationDuration(String complexity) {
    switch (complexity.toLowerCase()) {
      case 'fast':
        return animationDurationFast;
      case 'medium':
        return animationDurationMedium;
      case 'slow':
        return animationDurationSlow;
      case 'extra_slow':
        return animationDurationExtraSlow;
      default:
        return animationDurationMedium;
    }
  }

  /// Retourne si l'appareil est considéré comme mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  /// Retourne si l'appareil est considéré comme tablette
  static bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Retourne si l'appareil est considéré comme desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }
}