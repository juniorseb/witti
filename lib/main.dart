import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

// Core imports
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';

// App configuration
import 'app.dart';

/// Point d'entrée principal de l'application MyWitti
/// Configure l'environnement et lance l'application
void main() async {
  // Assure que les bindings Flutter sont initialisés
  WidgetsFlutterBinding.ensureInitialized();

  // Configuration de l'orientation de l'écran (portrait uniquement)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Configuration de l'interface système (barre de statut)
  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemOverlayStyle);

  // Préchargement des préférences utilisateur
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Vérification si l'onboarding a été complété
  final bool onboardingCompleted = prefs.getBool(AppConstants.keyOnboardingCompleted) ?? false;
  
  // Vérification si l'utilisateur est connecté
  final String? authToken = prefs.getString(AppConstants.keyAuthToken);
  final bool isUserLoggedIn = authToken != null && authToken.isNotEmpty;
  
  // Vérification du mode sombre (pour futures versions)
  final bool isDarkMode = prefs.getBool(AppConstants.keyDarkModeEnabled) ?? false;
  
  // Compteur de lancements de l'app (analytics)
  final int launchCount = prefs.getInt(AppConstants.keyAppLaunchCount) ?? 0;
  await prefs.setInt(AppConstants.keyAppLaunchCount, launchCount + 1);

  // Logging en mode debug
  if (AppConstants.isDebugMode) {
    debugPrint('=== MyWitti App Launch ===');
    debugPrint('Environment: ${AppConstants.environment}');
    debugPrint('Launch count: ${launchCount + 1}');
    debugPrint('Onboarding completed: $onboardingCompleted');
    debugPrint('User logged in: $isUserLoggedIn');
    debugPrint('Dark mode: $isDarkMode');
    debugPrint('========================');
  }

  // Lancement de l'application avec la configuration initiale
  runApp(
    MyWittiApp(
      onboardingCompleted: onboardingCompleted,
      isUserLoggedIn: isUserLoggedIn,
      isDarkMode: isDarkMode,
    ),
  );
}

/// Configuration et gestion des erreurs globales
/// Cette fonction sera appelée pour toutes les erreurs non gérées
void _configureErrorHandling() {
  // Gestion des erreurs Flutter
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log l'erreur en mode debug
    if (AppConstants.isDebugMode) {
      FlutterError.presentError(details);
    }
    
    // En production, vous pourriez envoyer l'erreur à un service comme Crashlytics
    if (AppConstants.enableCrashReporting && !AppConstants.isDebugMode) {
      // FirebaseCrashlytics.instance.recordFlutterError(details);
    }
  };

  // Gestion des erreurs de zone (erreurs asynchrones)
  PlatformDispatcher.instance.onError = (error, stack) {
    if (AppConstants.isDebugMode) {
      debugPrint('Zone error: $error');
      debugPrint('Stack trace: $stack');
    }
    
    // En production, envoyer à un service de crash reporting
    if (AppConstants.enableCrashReporting && !AppConstants.isDebugMode) {
      // FirebaseCrashlytics.instance.recordError(error, stack);
    }
    
    return true;
  };
}

/// Point d'entrée alternatif pour les tests
/// Permet de lancer l'app avec une configuration spécifique pour les tests
@visibleForTesting
void mainTest({
  bool onboardingCompleted = false,
  bool isUserLoggedIn = false,
  bool isDarkMode = false,
}) {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MyWittiApp(
      onboardingCompleted: onboardingCompleted,
      isUserLoggedIn: isUserLoggedIn,
      isDarkMode: isDarkMode,
    ),
  );
}

// ==========================================
// ÉCRANS TEMPORAIRES (À supprimer une fois les vrais écrans créés)
// Ces écrans sont utilisés uniquement si les vrais écrans ne sont pas disponibles
// ==========================================

/// Écran d'onboarding temporaire
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo temporaire
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBC680), // AppColors.goldenBorder
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.star,
                    size: 60,
                    color: Color(0xFF04102C), // AppColors.startButtonText
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Titre
                const Text(
                  'MyWitti',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Sous-titre
                const Text(
                  'BIENVENUE',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                const Text(
                  'Découvrez une nouvelle façon de\ngérer vos récompenses et jetons',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Bouton Démarrer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDBC680),
                      foregroundColor: const Color(0xFF04102C),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Démarrer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Écran de connexion temporaire
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bouton retour
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Titre
                const Text(
                  'CONNEXION',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                
                const Spacer(),
                
                // Message temporaire
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFDBC680),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Écran de connexion',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Cet écran sera remplacé par le vrai formulaire de connexion avec les champs code client et mot de passe.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Bouton temporaire vers le dashboard
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const DashboardScreen()),
                      );
                    },
                    child: const Text('Accéder au Dashboard (temporaire)'),
                  ),
                ),
                
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Écran dashboard temporaire
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header temporaire
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mon dashboard',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Bienvenue M. AKPA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFBC525),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: Color(0xFF04102C),
                        size: 24,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Bloc principal temporaire
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFF6C54D),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Dashboard MyWitti',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '200',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'jetons disponibles',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Les vrais widgets du dashboard seront implémentés dans les prochains écrans.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Message de développement
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.code,
                        color: Colors.blue,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Développement en cours',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade300,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'L\'application MyWitti est en cours de développement.\nLes écrans complets seront ajoutés progressivement.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade200,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}