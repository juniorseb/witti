/// Classe contenant toutes les chaînes de caractères de l'application MyWitti
/// Organisée par écrans et fonctionnalités pour faciliter la maintenance
class AppStrings {
  // Constructeur privé pour empêcher l'instanciation
  AppStrings._();

  // ==========================================
  // GÉNÉRAL / COMMUN
  // ==========================================

  static const String appName = 'MyWitti';
  static const String appSlogan = 'Votre programme de fidélité digital';
  
  // Boutons communs
  static const String buttonStart = 'Démarrer';
  static const String buttonLogin = 'Se connecter';
  static const String buttonBack = 'Retour';
  static const String buttonCancel = 'Annuler';
  static const String buttonConfirm = 'Confirmer';
  static const String buttonContinue = 'Continuer';
  static const String buttonSave = 'Enregistrer';
  
  // Messages communs
  static const String loading = 'Chargement...';
  static const String error = 'Une erreur est survenue';
  static const String success = 'Opération réussie';
  static const String noData = 'Aucune donnée disponible';

  // ==========================================
  // ONBOARDING
  // ==========================================

  static const String onboardingWelcome = 'BIENVENUE';
  static const String onboardingDescription = 'Découvrez une nouvelle façon de\ngérer vos récompenses et jetons';
  static const String onboardingSubtitle = 'Avec MyWitti, accumulez des jetons et débloquez des récompenses exclusives';

  // ==========================================
  // AUTHENTIFICATION / CONNEXION
  // ==========================================

  static const String loginTitle = 'CONNEXION';
  static const String loginSubtitle = 'Connectez-vous à votre compte';
  
  // Champs de formulaire
  static const String clientCodeLabel = 'Code client';
  static const String clientCodeHint = 'Entrez votre code client';
  static const String passwordLabel = 'Mot de passe';
  static const String passwordHint = 'Entrez votre mot de passe';
  
  // Options de connexion
  static const String rememberMe = 'Se souvenir de moi';
  static const String forgotPassword = 'Mot de passe oublié ?';
  
  // Conditions d'utilisation
  static const String termsPrefix = 'En vous connectant, vous acceptez nos ';
  static const String termsOfUse = 'Conditions d\'utilisation';
  static const String termsAnd = ' et notre ';
  static const String privacyPolicy = 'Politique de confidentialité';
  
  // Messages d'erreur de connexion
  static const String invalidCredentials = 'Code client ou mot de passe incorrect';
  static const String connectionError = 'Erreur de connexion. Vérifiez votre réseau.';
  static const String emptyFields = 'Veuillez remplir tous les champs';

  // ==========================================
  // DASHBOARD
  // ==========================================

  static const String dashboardTitle = 'Mon dashboard';
  static const String welcomeUser = 'Bienvenue M. AKPA'; // Remplacer par variable dynamique
  static const String tokensAvailable = 'Vous disposez de';
  static const String tokensUnit = 'jetons';
  
  // Section catégorie
  static const String categoryTitle = 'Votre catégorie';
  static const String categoryExecutive = 'Executive';
  static const String categoryExecutivePlus = 'Executive+';
  static const String categoryFirstClass = 'First Class';
  static const String categoryEcoPremium = 'Eco Premium';
  static const String categoryProgress = 'A 800 jetons du prochain palier !';
  
  // Actions rapides
  static const String deposit = 'Dépôt';
  static const String withdrawal = 'Retrait';
  
  // Transactions
  static const String recentTransactions = 'Mes transactions récentes';
  static const String transactionDeposit = 'Dépôt';
  static const String transactionWithdrawal = 'Retrait';
  static const String transactionMethod = 'Virement bancaire';
  
  // Timestamps
  static const String yesterday = 'Hier';
  static const String dayBeforeYesterday = 'Avant-hier';
  static const String daysAgo = 'Il y a {count} jours';
  static const String hoursAgo = 'Il y a {count} heures';
  static const String minutesAgo = 'Il y a {count} minutes';
  
  // Navigation
  static const String navDashboard = 'Dashboard';
  static const String navRewards = 'Récompenses';
  static const String navChat = 'Chat';
  static const String navProfile = 'Profil';
  static const String navHistory = 'Historique';

  // ==========================================
  // HISTORIQUE
  // ==========================================

  static const String historyTitle = 'HISTORIQUE';
  static const String trendsTitle = 'Tendance des transactions';
  
  // Période
  static const String periodLabel = 'Période';
  static const String currentMonth = 'Mars 2025'; // Remplacer par variable dynamique
  
  // Statistiques
  static const String depositsPercentage = '85%';
  static const String withdrawalsPercentage = '15%';
  static const String deposits = 'Dépôts';
  static const String withdrawals = 'Retraits';
  
  // Filtres
  static const String filterThisWeek = 'Cette semaine';
  static const String filterThisMonth = 'Ce mois';
  static const String filterCustom = 'Personnalisé';
  
  // Périodes de temps
  static const String today = 'Aujourd\'hui';
  static const String thisWeek = 'Cette semaine';
  static const String thisMonth = 'Ce mois';
  static const String lastWeek = 'Semaine dernière';
  static const String lastMonth = 'Mois dernier';

  // ==========================================
  // RÉCOMPENSES
  // ==========================================

  static const String rewardsTitle = 'Récompenses';
  static const String availableRewards = 'Récompenses disponibles';
  static const String myRewards = 'Mes récompenses';
  static const String rewardPoints = 'points';
  static const String rewardClaim = 'Récupérer';
  static const String rewardClaimed = 'Récupérée';
  static const String rewardExpires = 'Expire le';
  
  // Types de récompenses
  static const String rewardVoucher = 'Bon d\'achat';
  static const String rewardDiscount = 'Réduction';
  static const String rewardGift = 'Cadeau';
  static const String rewardExperience = 'Expérience';

  // ==========================================
  // PROFIL
  // ==========================================

  static const String profileTitle = 'Profil';
  static const String personalInfo = 'Informations personnelles';
  static const String accountSettings = 'Paramètres du compte';
  static const String notifications = 'Notifications';
  static const String language = 'Langue';
  static const String support = 'Support';
  static const String logout = 'Déconnexion';
  
  // Informations personnelles
  static const String firstName = 'Prénom';
  static const String lastName = 'Nom';
  static const String email = 'Email';
  static const String phone = 'Téléphone';
  static const String birthday = 'Date de naissance';
  static const String address = 'Adresse';

  // ==========================================
  // CHAT / SUPPORT
  // ==========================================

  static const String chatTitle = 'Chat';
  static const String chatSupport = 'Support client';
  static const String chatBot = 'Assistant virtuel';
  static const String messageHint = 'Tapez votre message...';
  static const String messageSend = 'Envoyer';
  static const String chatEmpty = 'Aucun message pour le moment';
  static const String chatOffline = 'Support hors ligne';
  static const String chatOnline = 'Support en ligne';

  // ==========================================
  // NOTIFICATIONS
  // ==========================================

  static const String notificationsTitle = 'Notifications';
  static const String notificationDeposit = 'Dépôt effectué';
  static const String notificationWithdrawal = 'Retrait effectué';
  static const String notificationReward = 'Nouvelle récompense disponible';
  static const String notificationPromotion = 'Promotion spéciale';
  static const String notificationEmpty = 'Aucune notification';
  static const String markAsRead = 'Marquer comme lu';
  static const String markAllAsRead = 'Tout marquer comme lu';

  // ==========================================
  // FORMULAIRES ET VALIDATION
  // ==========================================

  // Messages d'erreur de validation
  static const String requiredField = 'Ce champ est obligatoire';
  static const String invalidEmail = 'Email invalide';
  static const String invalidPhone = 'Numéro de téléphone invalide';
  static const String passwordTooShort = 'Le mot de passe doit contenir au moins 8 caractères';
  static const String passwordsNotMatch = 'Les mots de passe ne correspondent pas';
  static const String invalidAmount = 'Montant invalide';
  static const String insufficientBalance = 'Solde insuffisant';

  // ==========================================
  // MONTANTS ET DEVISES
  // ==========================================

  static const String currency = 'FCFA';
  static const String currencySymbol = 'F';
  static const String amount = 'Montant';
  static const String balance = 'Solde';
  static const String total = 'Total';
  static const String fee = 'Frais';
  static const String freeTransaction = 'Gratuit';

  // ==========================================
  // DATES ET HEURES
  // ==========================================

  // Jours de la semaine
  static const String monday = 'Lundi';
  static const String tuesday = 'Mardi';
  static const String wednesday = 'Mercredi';
  static const String thursday = 'Jeudi';
  static const String friday = 'Vendredi';
  static const String saturday = 'Samedi';
  static const String sunday = 'Dimanche';

  // Mois
  static const String january = 'Janvier';
  static const String february = 'Février';
  static const String march = 'Mars';
  static const String april = 'Avril';
  static const String may = 'Mai';
  static const String june = 'Juin';
  static const String july = 'Juillet';
  static const String august = 'Août';
  static const String september = 'Septembre';
  static const String october = 'Octobre';
  static const String november = 'Novembre';
  static const String december = 'Décembre';

  // ==========================================
  // MESSAGES DE CONFIRMATION
  // ==========================================

  static const String confirmLogout = 'Êtes-vous sûr de vouloir vous déconnecter ?';
  static const String confirmDelete = 'Êtes-vous sûr de vouloir supprimer cet élément ?';
  static const String confirmTransaction = 'Confirmer cette transaction ?';
  static const String transactionSuccess = 'Transaction effectuée avec succès';
  static const String transactionFailed = 'Échec de la transaction';

  // ==========================================
  // STATUTS
  // ==========================================

  static const String statusPending = 'En attente';
  static const String statusCompleted = 'Terminé';
  static const String statusFailed = 'Échoué';
  static const String statusCancelled = 'Annulé';
  static const String statusProcessing = 'En cours';

  // ==========================================
  // ACTIONS ET INSTRUCTIONS
  // ==========================================

  static const String pullToRefresh = 'Tirez pour actualiser';
  static const String releaseToRefresh = 'Relâchez pour actualiser';
  static const String swipeToDelete = 'Glissez pour supprimer';
  static const String tapToSelect = 'Appuyez pour sélectionner';
  static const String doubleTapToConfirm = 'Double-tap pour confirmer';

  // ==========================================
  // MÉTHODES UTILITAIRES
  // ==========================================

  /// Formate un montant avec la devise
  static String formatAmount(double amount) {
    if (amount >= 0) {
      return '+${amount.toStringAsFixed(0)} $currency';
    } else {
      return '${amount.toStringAsFixed(0)} $currency';
    }
  }

  /// Retourne le nom du jour en français
  static String getDayName(int weekday) {
    switch (weekday) {
      case 1: return monday;
      case 2: return tuesday;
      case 3: return wednesday;
      case 4: return thursday;
      case 5: return friday;
      case 6: return saturday;
      case 7: return sunday;
      default: return '';
    }
  }

  /// Retourne le nom du mois en français
  static String getMonthName(int month) {
    switch (month) {
      case 1: return january;
      case 2: return february;
      case 3: return march;
      case 4: return april;
      case 5: return may;
      case 6: return june;
      case 7: return july;
      case 8: return august;
      case 9: return september;
      case 10: return october;
      case 11: return november;
      case 12: return december;
      default: return '';
    }
  }

  /// Formate une durée relative (il y a X temps)
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 2) {
      return daysAgo.replaceAll('{count}', difference.inDays.toString());
    } else if (difference.inDays == 1) {
      return yesterday;
    } else if (difference.inHours >= 1) {
      return hoursAgo.replaceAll('{count}', difference.inHours.toString());
    } else if (difference.inMinutes >= 1) {
      return minutesAgo.replaceAll('{count}', difference.inMinutes.toString());
    } else {
      return 'À l\'instant';
    }
  }

  /// Retourne le message de bienvenue personnalisé
  static String getWelcomeMessage(String userName) {
    return 'Bienvenue $userName';
  }

  /// Retourne le texte de progression de catégorie
  static String getCategoryProgressText(int tokensNeeded) {
    return 'A $tokensNeeded jetons du prochain palier !';
  }

  /// Retourne le nom de la catégorie formaté
  static String getCategoryDisplayName(String categoryType) {
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

  /// Retourne le texte du type de transaction
  static String getTransactionTypeText(String type) {
    switch (type.toLowerCase()) {
      case 'deposit':
      case 'depot':
      case 'dépôt':
        return transactionDeposit;
      case 'withdrawal':
      case 'retrait':
        return transactionWithdrawal;
      default:
        return type;
    }
  }

  /// Valide et retourne un message d'erreur pour un champ
  static String? validateField(String? value, String fieldType) {
    if (value == null || value.isEmpty) {
      return requiredField;
    }

    switch (fieldType) {
      case 'email':
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return invalidEmail;
        }
        break;
      case 'phone':
        if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(value)) {
          return invalidPhone;
        }
        break;
      case 'password':
        if (value.length < 8) {
          return passwordTooShort;
        }
        break;
    }

    return null;
  }
}