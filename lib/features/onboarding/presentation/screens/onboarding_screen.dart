import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';

// Navigation vers les autres écrans
import 'advertisement_screen.dart';

/// Écran d'onboarding de l'application MyWitti
/// Présente l'application avec le logo, sélection de pays et message de bienvenue
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  
  // État du sélecteur de pays
  String _selectedCountry = 'Côte d\'Ivoire';
  final List<String> _countries = [
    'Côte d\'Ivoire',
    'Sénégal', 
    'Burkina Faso',
  ];

  // Contrôleurs d'animation
  late AnimationController _logoAnimationController;
  late AnimationController _contentAnimationController;
  late AnimationController _buttonAnimationController;

  // Animations
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<Offset> _contentSlideAnimation;
  late Animation<double> _contentOpacityAnimation;
  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _buttonOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _contentAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  /// Initialise toutes les animations
  void _initializeAnimations() {
    // Logo animation (0.8s)
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    // Content animation (0.6s)
    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _contentSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _contentAnimationController,
      curve: Curves.easeOut,
    ));

    _contentOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _contentAnimationController,
      curve: Curves.easeOut,
    ));

    // Button animation (0.4s)
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _buttonScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.bounceOut,
    ));

    _buttonOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeOut,
    ));
  }

  /// Démarre la séquence d'animations
  void _startAnimationSequence() async {
    // Petite pause avant de commencer
    await Future.delayed(const Duration(milliseconds: 300));

    // Logo apparaît en premier
    _logoAnimationController.forward();

    // Contenu après 400ms
    await Future.delayed(const Duration(milliseconds: 400));
    _contentAnimationController.forward();

    // Bouton après 300ms
    await Future.delayed(const Duration(milliseconds: 300));
    _buttonAnimationController.forward();
  }

  /// Gère l'action du bouton "Démarrer"
  Future<void> _onStartPressed() async {
    try {
      // Sauvegarde que l'onboarding est complété et le pays sélectionné
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.keyOnboardingCompleted, true);
      await prefs.setString('selected_country', _selectedCountry);

      if (mounted) {
        // Navigation vers l'écran de publicité
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AdvertisementScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
            transitionDuration: AppConstants.pageTransitionDuration,
          ),
        );
      }
    } catch (e) {
      if (AppConstants.isDebugMode) {
        debugPrint('Error completing onboarding: $e');
      }
      // En cas d'erreur, continuer quand même vers la publicité
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AdvertisementScreen()),
        );
      }
    }
  }

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
            padding: EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Container principal avec logo en haut
                _buildMainContainer(),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Construit le container principal avec logo en haut
  Widget _buildMainContainer() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Container principal avec contenu
        AnimatedBuilder(
          animation: _contentAnimationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                _contentSlideAnimation.value.dx * 100,
                _contentSlideAnimation.value.dy * 50,
              ),
              child: Opacity(
                opacity: _contentOpacityAnimation.value,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    AppConstants.paddingLarge,
                    AppConstants.paddingExtraLarge + 20, // Espace pour le logo
                    AppConstants.paddingLarge,
                    AppConstants.paddingLarge,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.goldenBorder,
                      width: AppConstants.borderWidthMedium,
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
                    color: const Color.fromARGB(255, 38, 46, 85), // Fond bleu
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: AppConstants.paddingMedium),
                      
                      // Titre "Bienvenue"
                      Text(
                        'Bienvenue',
                        style: AppFonts.poppinsBold(
                          fontSize: 24,
                          color: AppColors.whiteText,
                        ),
                      ),
                      
                      SizedBox(height: AppConstants.paddingSmall),
                      
                      // Sous-titre
                      Text(
                        'au programme de fidélité de Witti\nFinances',
                        textAlign: TextAlign.center,
                        style: AppFonts.poppinsRegular(
                          fontSize: 14,
                          color: AppColors.whiteText,
                        ),
                      ),
                      
                      SizedBox(height: AppConstants.paddingLarge),
                      
                      // Message d'instruction
                      Text(
                        'Veuillez choisir votre pays*',
                        style: AppFonts.poppinsRegular(
                          fontSize: 12,
                          color: AppColors.whiteText,
                        ),
                      ),
                      
                      SizedBox(height: AppConstants.paddingMedium),
                      
                      // Sélecteur de pays
                      _buildCountrySelector(),
                      
                      SizedBox(height: AppConstants.paddingSmall),
                      
                      // Note en bas
                      Text(
                        '*celui où vous avez ouvert votre compte.',
                        style: AppFonts.poppinsRegular(
                          fontSize: 10,
                          color: AppColors.whiteText.withOpacity(0.8),
                        ),
                      ),
                      
                      SizedBox(height: AppConstants.paddingLarge),
                      
                      // Bouton Démarrer
                      _buildAnimatedStartButton(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        
        // Logo en haut du container
        Positioned(
          top: -30, // Positionné sur la bordure
          left: 0,
          right: 0,
          child: _buildAnimatedLogo(),
        ),
      ],
    );
  }

  /// Construit le logo animé positionné en haut
  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _logoAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScaleAnimation.value,
          child: Opacity(
            opacity: _logoOpacityAnimation.value,
            child: Center(
              child: Container(
                width: 80,
                height: 60,
                padding: EdgeInsets.all(AppConstants.paddingSmall),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 38, 46, 85), // Fond bleu
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                  border: Border.all(
                    color: AppColors.goldenBorder,
                    width: 2,
                  ),
                ),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Construit le sélecteur de pays
  Widget _buildCountrySelector() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        border: Border.all(
          color: AppColors.goldenBorder,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icône du drapeau (pour la Côte d'Ivoire par défaut)
          Container(
            width: 24,
            height: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: AppColors.depositColor, // Couleur temporaire pour le drapeau
            ),
            child: const Icon(
              Icons.flag,
              size: 12,
              color: AppColors.whiteText,
            ),
          ),
          
          SizedBox(width: AppConstants.paddingSmall),
          
          // Dropdown pour le pays
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCountry,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.whiteText,
                ),
                style: AppFonts.poppinsRegular(
                  fontSize: 14,
                  color: AppColors.whiteText,
                ),
                dropdownColor: AppColors.inputBackground,
                items: _countries.map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(
                      country,
                      style: AppFonts.poppinsRegular(
                        fontSize: 14,
                        color: AppColors.whiteText,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCountry = newValue;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Construit le bouton "Démarrer" animé avec fond image
  Widget _buildAnimatedStartButton() {
    return AnimatedBuilder(
      animation: _buttonAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _buttonScaleAnimation.value,
          child: FadeTransition(
            opacity: _buttonOpacityAnimation,
            child: SizedBox(
              width: double.infinity,
              height: AppConstants.buttonHeight,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/bouton_bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                ),
                child: ElevatedButton(
                  onPressed: _buttonAnimationController.isCompleted
                      ? _onStartPressed
                      : null, // Désactivé pendant l'animation
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Transparent pour voir l'image
                    foregroundColor: AppColors.startButtonText,
                    elevation: 0,
                    shadowColor: AppColors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                    ),
                    padding: EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
                  ),
                  child: Text(
                    'Démarrer',
                    style: AppFonts.buttonText.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}