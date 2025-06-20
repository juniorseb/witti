import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Core imports
import 'core/constants/app_constants.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';

// Real screens
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';

/// Configuration principale de l'application MyWitti
/// Gère le thème, la navigation et l'état initial de l'application
class MyWittiApp extends StatefulWidget {
  const MyWittiApp({
    super.key,
    required this.onboardingCompleted,
    required this.isUserLoggedIn,
    required this.isDarkMode,
  });

  /// Indique si l'onboarding a été complété
  final bool onboardingCompleted;
  
  /// Indique si l'utilisateur est connecté
  final bool isUserLoggedIn;
  
  /// Indique si le mode sombre est activé (pour futures versions)
  final bool isDarkMode;

  @override
  State<MyWittiApp> createState() => _MyWittiAppState();
}

class _MyWittiAppState extends State<MyWittiApp> with WidgetsBindingObserver {
  
  @override
  void initState() {
    super.initState();
    // Observer les changements de cycle de vie de l'app
    WidgetsBinding.instance.addObserver(this);
    
    // Post frame callback pour l'initialisation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  @override
  void dispose() {
    // Nettoyer l'observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // Gérer les changements de cycle de vie
    switch (state) {
      case AppLifecycleState.resumed:
        _onAppResumed();
        break;
      case AppLifecycleState.paused:
        _onAppPaused();
        break;
      case AppLifecycleState.detached:
        _onAppDetached();
        break;
      case AppLifecycleState.inactive:
        _onAppInactive();
        break;
      case AppLifecycleState.hidden:
        _onAppHidden();
        break;
    }
  }

  /// Initialise l'application après le premier frame
  void _initializeApp() {
    if (AppConstants.isDebugMode) {
      debugPrint('=== MyWittiApp Initialized ===');
      debugPrint('Onboarding completed: ${widget.onboardingCompleted}');
      debugPrint('User logged in: ${widget.isUserLoggedIn}');
      debugPrint('Dark mode: ${widget.isDarkMode}');
      debugPrint('Environment: ${AppConstants.environment}');
      debugPrint('==============================');
    }

    // Préchargement des assets critiques
    _preloadCriticalAssets();
    
    // Configuration de l'interface système
    _configureSystemUI();
  }

  /// Précharge les assets critiques pour améliorer les performances
  void _preloadCriticalAssets() {
    final criticalAssets = [
      'assets/images/logo.png',
      'assets/images/onboarding_bg.png',
      'assets/images/avatar_placeholder.png',
      'assets/images/categories/executive.png',
      'assets/images/categories/executive_plus.png',
      'assets/images/categories/first_class.png',
      'assets/images/categories/eco_premium.png',
    ];

    for (String asset in criticalAssets) {
      try {
        precacheImage(AssetImage(asset), context);
      } catch (e) {
        if (AppConstants.isDebugMode) {
          debugPrint('Failed to preload asset: $asset - $e');
        }
      }
    }

    if (AppConstants.isDebugMode) {
      debugPrint('Critical assets preloading initiated');
    }
  }

  /// Configure l'interface système (barre de statut, navigation)
  void _configureSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(AppTheme.systemOverlayStyle);
    
    // Configuration de l'orientation (portrait uniquement)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Appelé quand l'app revient au premier plan
  void _onAppResumed() {
    if (AppConstants.isDebugMode) {
      debugPrint('App resumed');
    }
    // Rafraîchir les données si nécessaire
    // Vérifier la connectivité réseau
    // Synchroniser les données
  }

  /// Appelé quand l'app passe en arrière-plan
  void _onAppPaused() {
    if (AppConstants.isDebugMode) {
      debugPrint('App paused');
    }
    // Sauvegarder l'état si nécessaire
    // Arrêter les timers non critiques
  }

  /// Appelé quand l'app est fermée
  void _onAppDetached() {
    if (AppConstants.isDebugMode) {
      debugPrint('App detached');
    }
    // Nettoyage final
  }

  /// Appelé quand l'app devient inactive
  void _onAppInactive() {
    if (AppConstants.isDebugMode) {
      debugPrint('App inactive');
    }
  }

  /// Appelé quand l'app est cachée
  void _onAppHidden() {
    if (AppConstants.isDebugMode) {
      debugPrint('App hidden');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ==========================================
      // CONFIGURATION DE BASE
      // ==========================================
      
      title: AppConstants.appName,
      debugShowCheckedModeBanner: AppConstants.isDebugMode,
      
      // ==========================================
      // CONFIGURATION DU THÈME
      // ==========================================
      
      theme: AppTheme.theme,
      // darkTheme: AppTheme.darkTheme, // Pour futures versions
      // themeMode: widget.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      // ==========================================
      // CONFIGURATION DE LOCALISATION
      // ==========================================
      
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'), // Français (principal)
        Locale('en', 'US'), // Anglais (futur)
      ],
      locale: const Locale('fr', 'FR'),
      
      // ==========================================
      // CONFIGURATION DE NAVIGATION
      // ==========================================
      
      // Page d'accueil déterminée par l'état
      home: _getInitialScreen(),
      
      // Générateur de routes (sera ajouté plus tard avec app_routes.dart)
      // onGenerateRoute: AppRoutes.generateRoute,
      
      // Gestion des routes inconnues
      onUnknownRoute: (settings) {
        return _buildUnknownRoute(settings);
      },
      
      // ==========================================
      // CONFIGURATION AVANCÉE
      // ==========================================
      
      // Builder global pour la configuration
      builder: (context, child) {
        return _buildAppWrapper(context, child);
      },
      
      // Configuration des shortcuts (pour desktop/web futur)
      shortcuts: _buildShortcuts(),
      
      // Actions globales
      actions: _buildGlobalActions(),
      
      // ==========================================
      // PERFORMANCE ET ACCESSIBILITÉ
      // ==========================================
      
      // Overlay pour le mode debug (désactivé en production)
      showPerformanceOverlay: AppConstants.isDebugMode && false,
      
      // Overlay de grille pour l'alignement (debug uniquement)
      debugShowMaterialGrid: false,
      
      // Vérifier les règles d'accessibilité
      showSemanticsDebugger: false,
    );
  }

  /// Détermine l'écran initial selon l'état de l'utilisateur
  Widget _getInitialScreen() {
    if (AppConstants.isDebugMode) {
      debugPrint('Determining initial screen...');
      debugPrint('Onboarding completed: ${widget.onboardingCompleted}');
      debugPrint('User logged in: ${widget.isUserLoggedIn}');
    }

    // Si l'onboarding n'est pas complété, aller à l'onboarding
    if (!widget.onboardingCompleted) {
      if (AppConstants.isDebugMode) {
        debugPrint('→ Going to OnboardingScreen');
      }
      return const OnboardingScreen();
    }
    
    // Si l'utilisateur n'est pas connecté, aller à la connexion
    if (!widget.isUserLoggedIn) {
      if (AppConstants.isDebugMode) {
        debugPrint('→ Going to LoginScreen');
      }
      return const LoginScreen();
    }
    
    // Sinon, aller au dashboard
    if (AppConstants.isDebugMode) {
      debugPrint('→ Going to DashboardScreen');
    }
    return const DashboardScreen();
  }

  /// Construit la route pour les pages inconnues
  PageRoute _buildUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.error),
          backgroundColor: AppTheme.theme.colorScheme.error,
          foregroundColor: AppTheme.theme.colorScheme.onError,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: AppConstants.iconSizeExtraLarge * 1.5,
                  color: AppTheme.theme.colorScheme.error,
                ),
                SizedBox(height: AppConstants.paddingMedium),
                Text(
                  'Page introuvable',
                  style: AppTheme.theme.textTheme.headlineMedium?.copyWith(
                    color: AppTheme.theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppConstants.paddingSmall),
                Text(
                  'La page "${settings.name ?? 'inconnue'}" n\'existe pas.',
                  style: AppTheme.theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppConstants.paddingLarge),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Retour à l\'accueil'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Wrapper global pour l'application
  Widget _buildAppWrapper(BuildContext context, Widget? child) {
    return MediaQuery(
      // Configuration de l'accessibilité
      data: MediaQuery.of(context).copyWith(
        // Limite la taille du texte pour éviter les problèmes d'interface
        textScaler: MediaQuery.of(context).textScaler.clamp(
          minScaleFactor: 0.8,
          maxScaleFactor: 1.3,
        ),
      ),
      child: child ?? const SizedBox.shrink(),
    );
  }

  /// Configuration des raccourcis clavier (pour futures versions desktop/web)
  Map<ShortcutActivator, Intent> _buildShortcuts() {
    return const <ShortcutActivator, Intent>{
      // Raccourcis pour navigation rapide
      SingleActivator(LogicalKeyboardKey.f5): _RefreshIntent(),
      SingleActivator(LogicalKeyboardKey.escape): _BackIntent(),
      // Raccourci pour le debug
      SingleActivator(LogicalKeyboardKey.f12): _DebugIntent(),
    };
  }

  /// Actions globales de l'application
  Map<Type, Action<Intent>> _buildGlobalActions() {
    return <Type, Action<Intent>>{
      _RefreshIntent: _RefreshAction(),
      _BackIntent: _BackAction(),
      _DebugIntent: _DebugAction(),
    };
  }
}

// ==========================================
// INTENTS ET ACTIONS POUR LES RACCOURCIS
// ==========================================

/// Intent pour rafraîchir l'écran actuel
class _RefreshIntent extends Intent {
  const _RefreshIntent();
}

/// Intent pour revenir en arrière
class _BackIntent extends Intent {
  const _BackIntent();
}

/// Intent pour le mode debug
class _DebugIntent extends Intent {
  const _DebugIntent();
}

/// Action pour rafraîchir
class _RefreshAction extends Action<_RefreshIntent> {
  @override
  Object? invoke(_RefreshIntent intent) {
    if (AppConstants.isDebugMode) {
      debugPrint('Refresh action triggered (F5)');
    }
    // Logique de rafraîchissement global
    return null;
  }
}

/// Action pour revenir en arrière
class _BackAction extends Action<_BackIntent> {
  @override
  Object? invoke(_BackIntent intent) {
    if (AppConstants.isDebugMode) {
      debugPrint('Back action triggered (Escape)');
    }
    // Logique de retour global
    return null;
  }
}

/// Action pour le debug
class _DebugAction extends Action<_DebugIntent> {
  @override
  Object? invoke(_DebugIntent intent) {
    if (AppConstants.isDebugMode) {
      debugPrint('Debug action triggered (F12)');
      debugPrint('App State: ${AppConstants.environment}');
    }
    return null;
  }
}

// ==========================================
// UTILITAIRES D'APPLICATION
// ==========================================

/// Classe utilitaire pour les fonctions globales de l'app
class AppUtils {
  AppUtils._();

  /// Redémarre l'application
  static void restartApp(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/',
      (route) => false,
    );
  }

  /// Affiche un snackbar global avec style MyWitti
  static void showGlobalSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Duration? duration,
    SnackBarAction? action,
    bool isError = false,
    bool isSuccess = false,
  }) {
    Color bgColor = backgroundColor ?? AppTheme.theme.colorScheme.surface;
    
    if (isError) {
      bgColor = AppTheme.theme.colorScheme.error;
    } else if (isSuccess) {
      bgColor = AppTheme.theme.customColors.deposit;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: isError || isSuccess ? Colors.white : null,
          ),
        ),
        backgroundColor: bgColor,
        duration: duration ?? AppConstants.snackBarDuration,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
        margin: EdgeInsets.all(AppConstants.paddingMedium),
      ),
    );
  }

  /// Affiche un dialogue de confirmation global
  static Future<bool?> showConfirmationDialog(
    BuildContext context,
    String title,
    String content, {
    String? confirmText,
    String? cancelText,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText ?? AppStrings.buttonCancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDestructive 
                    ? AppTheme.theme.colorScheme.error 
                    : AppTheme.theme.colorScheme.primary,
              ),
              child: Text(confirmText ?? AppStrings.buttonConfirm),
            ),
          ],
        );
      },
    );
  }

  /// Affiche un dialogue d'information
  static Future<void> showInfoDialog(
    BuildContext context,
    String title,
    String content, {
    String? buttonText,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(buttonText ?? 'OK'),
            ),
          ],
        );
      },
    );
  }

  /// Vérifie si l'appareil est en mode tablette
  static bool isTablet(BuildContext context) {
    return AppConstants.isTablet(context);
  }

  /// Vérifie si l'appareil est en mode mobile
  static bool isMobile(BuildContext context) {
    return AppConstants.isMobile(context);
  }

  /// Obtient la taille d'écran sécurisée (sans les barres système)
  static Size getSafeAreaSize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.padding;
    return Size(
      mediaQuery.size.width,
      mediaQuery.size.height - padding.top - padding.bottom,
    );
  }

  /// Obtient la hauteur disponible pour le contenu
  static double getContentHeight(BuildContext context) {
    final size = getSafeAreaSize(context);
    return size.height - AppConstants.appBarHeight - AppConstants.bottomNavHeight;
  }

  /// Formate un montant pour l'affichage
  static String formatDisplayAmount(double amount) {
    return AppConstants.formatCurrency(amount);
  }

  /// Calcule le pourcentage de progression
  static double calculateProgress(int current, int target) {
    if (target <= 0) return 0.0;
    return (current / target).clamp(0.0, 1.0);
  }

  /// Génère une couleur selon le type de transaction
  static Color getTransactionColor(String type) {
    switch (type.toLowerCase()) {
      case 'deposit':
      case 'depot':
      case 'dépôt':
        return AppTheme.theme.customColors.deposit;
      case 'withdrawal':
      case 'retrait':
        return AppTheme.theme.customColors.withdraw;
      default:
        return AppTheme.theme.colorScheme.onSurface;
    }
  }

  /// Lance une URL externe (pour futures versions)
  static Future<void> launchExternalUrl(String url) async {
    if (AppConstants.isDebugMode) {
      debugPrint('Would launch URL: $url');
    }
    // TODO: Implémenter url_launcher
    // await launchUrl(Uri.parse(url));
  }

  /// Partage du contenu (pour futures versions)
  static Future<void> shareContent(String content) async {
    if (AppConstants.isDebugMode) {
      debugPrint('Would share: $content');
    }
    // TODO: Implémenter share_plus
    // await Share.share(content);
  }

  /// Copie du texte dans le presse-papiers
  static Future<void> copyToClipboard(
    BuildContext context,
    String text, {
    String? successMessage,
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
    
    if (context.mounted) {
      showGlobalSnackBar(
        context,
        successMessage ?? 'Copié dans le presse-papiers',
        isSuccess: true,
      );
    }
  }
}