/// Classe contenant tous les chemins vers les assets de l'application MyWitti
/// Centralise les images, icônes, animations et autres ressources
class AppAssets {
  // Constructeur privé pour empêcher l'instanciation
  AppAssets._();

  // ==========================================
  // DOSSIERS DE BASE
  // ==========================================

  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = 'assets/icons';
  static const String _animationsPath = 'assets/animations';

  // ==========================================
  // IMAGES PRINCIPALES
  // ==========================================

  /// Logo principal de l'application
  static const String logo = '$_imagesPath/logo.png';
  
  /// Logo en version SVG (optionnel)
  static const String logoSvg = '$_imagesPath/logo.svg';
  
  /// Background pour l'onboarding
  static const String onboardingBackground = '$_imagesPath/onboarding_bg.png';
  
  /// Avatar par défaut pour les utilisateurs
  static const String avatarPlaceholder = '$_imagesPath/avatar_placeholder.png';
  
  /// Image de placeholder pour les récompenses
  static const String rewardPlaceholder = '$_imagesPath/reward_placeholder.png';
  
  /// Background dégradé pour les écrans
  static const String gradientBackground = '$_imagesPath/gradient_bg.png';

  // ==========================================
  // IMAGES DES CATÉGORIES
  // ==========================================

  /// Images des catégories de fidélité
  static const String categoryExecutive = '$_imagesPath/categories/executive.png';
  static const String categoryExecutivePlus = '$_imagesPath/categories/executive_plus.png';
  static const String categoryFirstClass = '$_imagesPath/categories/first_class.png';
  static const String categoryEcoPremium = '$_imagesPath/categories/eco_premium.png';
  
  /// Badges des catégories
  static const String badgeExecutive = '$_imagesPath/badges/executive_badge.png';
  static const String badgeExecutivePlus = '$_imagesPath/badges/executive_plus_badge.png';
  static const String badgeFirstClass = '$_imagesPath/badges/first_class_badge.png';
  static const String badgeEcoPremium = '$_imagesPath/badges/eco_premium_badge.png';

  // ==========================================
  // IMAGES DES RÉCOMPENSES
  // ==========================================

  /// Types de récompenses
  static const String rewardVoucher = '$_imagesPath/rewards/voucher.png';
  static const String rewardDiscount = '$_imagesPath/rewards/discount.png';
  static const String rewardGift = '$_imagesPath/rewards/gift.png';
  static const String rewardExperience = '$_imagesPath/rewards/experience.png';
  static const String rewardTravel = '$_imagesPath/rewards/travel.png';
  static const String rewardFood = '$_imagesPath/rewards/food.png';
  static const String rewardShopping = '$_imagesPath/rewards/shopping.png';

  // ==========================================
  // ICÔNES SVG
  // ==========================================

  /// Icône de l'application
  static const String appIcon = '$_iconsPath/app_icon.png';
  static const String appIconSvg = '$_iconsPath/app_icon.svg';
  
  /// Étoiles et ratings
  static const String starFilled = '$_iconsPath/star_filled.svg';
  static const String starOutline = '$_iconsPath/star_outline.svg';
  static const String starHalf = '$_iconsPath/star_half.svg';
  
  /// Actions financières
  static const String depositIcon = '$_iconsPath/deposit.svg';
  static const String withdrawalIcon = '$_iconsPath/withdrawal.svg';
  static const String transferIcon = '$_iconsPath/transfer.svg';
  static const String walletIcon = '$_iconsPath/wallet.svg';
  
  /// Navigation et interface
  static const String homeIcon = '$_iconsPath/home.svg';
  static const String dashboardIcon = '$_iconsPath/dashboard.svg';
  static const String rewardsIcon = '$_iconsPath/rewards.svg';
  static const String chatIcon = '$_iconsPath/chat.svg';
  static const String profileIcon = '$_iconsPath/profile.svg';
  static const String historyIcon = '$_iconsPath/history.svg';
  static const String notificationIcon = '$_iconsPath/notification.svg';
  static const String settingsIcon = '$_iconsPath/settings.svg';
  
  /// Actions utilisateur
  static const String editIcon = '$_iconsPath/edit.svg';
  static const String deleteIcon = '$_iconsPath/delete.svg';
  static const String shareIcon = '$_iconsPath/share.svg';
  static const String copyIcon = '$_iconsPath/copy.svg';
  static const String downloadIcon = '$_iconsPath/download.svg';
  static const String uploadIcon = '$_iconsPath/upload.svg';
  
  /// Flèches et navigation
  static const String arrowLeft = '$_iconsPath/arrow_left.svg';
  static const String arrowRight = '$_iconsPath/arrow_right.svg';
  static const String arrowUp = '$_iconsPath/arrow_up.svg';
  static const String arrowDown = '$_iconsPath/arrow_down.svg';
  static const String chevronLeft = '$_iconsPath/chevron_left.svg';
  static const String chevronRight = '$_iconsPath/chevron_right.svg';
  
  /// États et feedback
  static const String checkIcon = '$_iconsPath/check.svg';
  static const String closeIcon = '$_iconsPath/close.svg';
  static const String warningIcon = '$_iconsPath/warning.svg';
  static const String errorIcon = '$_iconsPath/error.svg';
  static const String infoIcon = '$_iconsPath/info.svg';
  static const String successIcon = '$_iconsPath/success.svg';
  
  /// Sécurité et authentification
  static const String lockIcon = '$_iconsPath/lock.svg';
  static const String unlockIcon = '$_iconsPath/unlock.svg';
  static const String eyeIcon = '$_iconsPath/eye.svg';
  static const String eyeOffIcon = '$_iconsPath/eye_off.svg';
  static const String fingerprintIcon = '$_iconsPath/fingerprint.svg';
  static const String faceIdIcon = '$_iconsPath/face_id.svg';

  // ==========================================
  // ICÔNES PNG (Fallback)
  // ==========================================

  /// Versions PNG des icônes principales pour compatibilité
  static const String starFilledPng = '$_iconsPath/star_filled.png';
  static const String depositIconPng = '$_iconsPath/deposit.png';
  static const String withdrawalIconPng = '$_iconsPath/withdrawal.png';
  static const String notificationIconPng = '$_iconsPath/notification.png';

  // ==========================================
  // ANIMATIONS LOTTIE
  // ==========================================

  /// Animations de chargement
  static const String loadingAnimation = '$_animationsPath/loading.json';
  static const String splashAnimation = '$_animationsPath/splash.json';
  
  /// Animations de succès et erreur
  static const String successAnimation = '$_animationsPath/success.json';
  static const String errorAnimation = '$_animationsPath/error.json';
  static const String warningAnimation = '$_animationsPath/warning.json';
  
  /// Animations spécifiques à l'app
  static const String tokenAnimation = '$_animationsPath/token_animation.json';
  static const String rewardAnimation = '$_animationsPath/reward_animation.json';
  static const String confettiAnimation = '$_animationsPath/confetti.json';
  static const String starsAnimation = '$_animationsPath/stars.json';
  
  /// États vides
  static const String emptyStateAnimation = '$_animationsPath/empty_state.json';
  static const String noDataAnimation = '$_animationsPath/no_data.json';
  static const String noConnectionAnimation = '$_animationsPath/no_connection.json';

  // ==========================================
  // ILLUSTRATIONS ET GRAPHICS
  // ==========================================

  /// Illustrations pour les états vides
  static const String emptyTransactions = '$_imagesPath/illustrations/empty_transactions.svg';
  static const String emptyRewards = '$_imagesPath/illustrations/empty_rewards.svg';
  static const String emptyNotifications = '$_imagesPath/illustrations/empty_notifications.svg';
  
  /// Illustrations pour l'onboarding
  static const String onboardingStep1 = '$_imagesPath/illustrations/onboarding_1.svg';
  static const String onboardingStep2 = '$_imagesPath/illustrations/onboarding_2.svg';
  static const String onboardingStep3 = '$_imagesPath/illustrations/onboarding_3.svg';
  
  /// Graphics décoratifs
  static const String goldPattern = '$_imagesPath/graphics/gold_pattern.png';
  static const String starPattern = '$_imagesPath/graphics/star_pattern.png';

  // ==========================================
  // MÉTHODES UTILITAIRES
  // ==========================================

  /// Retourne le chemin de l'icône de catégorie selon le type
  static String getCategoryIcon(String categoryType) {
    switch (categoryType.toLowerCase()) {
      case 'executive':
        return categoryExecutive;
      case 'executive+':
      case 'executive plus':
        return categoryExecutivePlus;
      case 'first class':
      case 'firstclass':
        return categoryFirstClass;
      case 'eco premium':
      case 'ecopremium':
        return categoryEcoPremium;
      default:
        return categoryExecutive;
    }
  }

  /// Retourne le chemin du badge de catégorie selon le type
  static String getCategoryBadge(String categoryType) {
    switch (categoryType.toLowerCase()) {
      case 'executive':
        return badgeExecutive;
      case 'executive+':
      case 'executive plus':
        return badgeExecutivePlus;
      case 'first class':
      case 'firstclass':
        return badgeFirstClass;
      case 'eco premium':
      case 'ecopremium':
        return badgeEcoPremium;
      default:
        return badgeExecutive;
    }
  }

  /// Retourne l'icône de transaction selon le type
  static String getTransactionIcon(String transactionType) {
    switch (transactionType.toLowerCase()) {
      case 'deposit':
      case 'depot':
      case 'dépôt':
        return depositIcon;
      case 'withdrawal':
      case 'retrait':
        return withdrawalIcon;
      case 'transfer':
      case 'transfert':
        return transferIcon;
      default:
        return walletIcon;
    }
  }

  /// Retourne l'icône de récompense selon le type
  static String getRewardIcon(String rewardType) {
    switch (rewardType.toLowerCase()) {
      case 'voucher':
      case 'bon':
        return rewardVoucher;
      case 'discount':
      case 'reduction':
        return rewardDiscount;
      case 'gift':
      case 'cadeau':
        return rewardGift;
      case 'experience':
        return rewardExperience;
      case 'travel':
      case 'voyage':
        return rewardTravel;
      case 'food':
      case 'restaurant':
        return rewardFood;
      case 'shopping':
        return rewardShopping;
      default:
        return rewardPlaceholder;
    }
  }

  /// Retourne l'illustration d'état vide selon le contexte
  static String getEmptyStateIllustration(String context) {
    switch (context.toLowerCase()) {
      case 'transactions':
        return emptyTransactions;
      case 'rewards':
      case 'récompenses':
        return emptyRewards;
      case 'notifications':
        return emptyNotifications;
      default:
        return emptyStateAnimation;
    }
  }

  /// Retourne l'animation selon l'état
  static String getStateAnimation(String state) {
    switch (state.toLowerCase()) {
      case 'loading':
      case 'chargement':
        return loadingAnimation;
      case 'success':
      case 'succès':
        return successAnimation;
      case 'error':
      case 'erreur':
        return errorAnimation;
      case 'warning':
      case 'attention':
        return warningAnimation;
      case 'empty':
      case 'vide':
        return emptyStateAnimation;
      case 'no_connection':
      case 'pas_de_connexion':
        return noConnectionAnimation;
      default:
        return loadingAnimation;
    }
  }

  /// Vérifie si un asset est une image
  static bool isImage(String assetPath) {
    return assetPath.endsWith('.png') || 
           assetPath.endsWith('.jpg') || 
           assetPath.endsWith('.jpeg') || 
           assetPath.endsWith('.webp');
  }

  /// Vérifie si un asset est un SVG
  static bool isSvg(String assetPath) {
    return assetPath.endsWith('.svg');
  }

  /// Vérifie si un asset est une animation Lottie
  static bool isLottie(String assetPath) {
    return assetPath.endsWith('.json');
  }

  /// Retourne tous les assets d'images pour le preloading
  static List<String> getAllImages() {
    return [
      logo,
      onboardingBackground,
      avatarPlaceholder,
      rewardPlaceholder,
      categoryExecutive,
      categoryExecutivePlus,
      categoryFirstClass,
      categoryEcoPremium,
      badgeExecutive,
      badgeExecutivePlus,
      badgeFirstClass,
      badgeEcoPremium,
      rewardVoucher,
      rewardDiscount,
      rewardGift,
      rewardExperience,
      rewardTravel,
      rewardFood,
      rewardShopping,
      appIcon,
      starFilledPng,
      depositIconPng,
      withdrawalIconPng,
      notificationIconPng,
      goldPattern,
      starPattern,
    ];
  }

  /// Retourne tous les assets SVG
  static List<String> getAllSvgs() {
    return [
      logoSvg,
      appIconSvg,
      starFilled,
      starOutline,
      starHalf,
      depositIcon,
      withdrawalIcon,
      transferIcon,
      walletIcon,
      homeIcon,
      dashboardIcon,
      rewardsIcon,
      chatIcon,
      profileIcon,
      historyIcon,
      notificationIcon,
      settingsIcon,
      editIcon,
      deleteIcon,
      shareIcon,
      copyIcon,
      downloadIcon,
      uploadIcon,
      arrowLeft,
      arrowRight,
      arrowUp,
      arrowDown,
      chevronLeft,
      chevronRight,
      checkIcon,
      closeIcon,
      warningIcon,
      errorIcon,
      infoIcon,
      successIcon,
      lockIcon,
      unlockIcon,
      eyeIcon,
      eyeOffIcon,
      fingerprintIcon,
      faceIdIcon,
      emptyTransactions,
      emptyRewards,
      emptyNotifications,
      onboardingStep1,
      onboardingStep2,
      onboardingStep3,
    ];
  }

  /// Retourne toutes les animations Lottie
  static List<String> getAllAnimations() {
    return [
      loadingAnimation,
      splashAnimation,
      successAnimation,
      errorAnimation,
      warningAnimation,
      tokenAnimation,
      rewardAnimation,
      confettiAnimation,
      starsAnimation,
      emptyStateAnimation,
      noDataAnimation,
      noConnectionAnimation,
    ];
  }
}