import 'package:flutter/material.dart';

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_constants.dart';

// Navigation vers les autres écrans
import '../../../auth/presentation/screens/login_screen.dart';

/// Écran de publicité/présentation MyWitti
/// Affiche l'avatar et le message promotionnel avant la connexion
class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({super.key});

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen>
    with TickerProviderStateMixin {
  
  // Contrôleurs d'animation
  late AnimationController _imageAnimationController;
  late AnimationController _textAnimationController;
  late AnimationController _dotsAnimationController;
  late AnimationController _progressAnimationController;

  // Animations
  late Animation<double> _imageScaleAnimation;
  late Animation<double> _imageOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _dotsOpacityAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
    _startAutoNavigation();
  }

  @override
  void dispose() {
    _imageAnimationController.dispose();
    _textAnimationController.dispose();
    _dotsAnimationController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  /// Initialise toutes les animations
  void _initializeAnimations() {
    // Image animation (1.0s)
    _imageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _imageScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageAnimationController,
      curve: Curves.elasticOut,
    ));

    _imageOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageAnimationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    // Text animation (0.8s)
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeOut,
    ));

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeOut,
    ));

    // Dots animation (0.6s)
    _dotsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _dotsOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _dotsAnimationController,
      curve: Curves.easeOut,
    ));

    // Progress animation (3.0s)
    _progressAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressAnimationController,
      curve: Curves.linear,
    ));
  }

  /// Démarre la séquence d'animations
  void _startAnimationSequence() async {
    // Image apparaît en premier
    _imageAnimationController.forward();

    // Texte après 500ms
    await Future.delayed(const Duration(milliseconds: 500));
    _textAnimationController.forward();

    // Points après 300ms
    await Future.delayed(const Duration(milliseconds: 300));
    _dotsAnimationController.forward();

    // Barre de progression après 500ms
    await Future.delayed(const Duration(milliseconds: 500));
    _progressAnimationController.forward();
  }

  /// Navigation automatique vers l'écran de connexion après 4 secondes
  void _startAutoNavigation() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: AppConstants.pageTransitionDuration,
          ),
        );
      }
    });
  }

  /// Navigation manuelle vers l'écran de connexion
  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: AppConstants.pageTransitionDuration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _navigateToLogin, // Permet de passer en cliquant
        child: Container(
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
                children: [
                  // Espace en haut
                  SizedBox(height: AppConstants.paddingExtraLarge),

                  // Image de l'avatar avec animation
                  _buildAnimatedAvatar(),

                  SizedBox(height: AppConstants.paddingLarge),

                  // Points de pagination avec animation
                  _buildAnimatedDots(),

                  SizedBox(height: AppConstants.paddingLarge),

                  // Texte de présentation avec animation
                  _buildAnimatedText(),

                  const Spacer(),

                  // Barre de progression avec animation
                  _buildAnimatedProgressBar(),

                  SizedBox(height: AppConstants.paddingLarge),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Construit l'avatar animé sans ad_bg.jpg
  Widget _buildAnimatedAvatar() {
    return AnimatedBuilder(
      animation: _imageAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _imageScaleAnimation.value,
          child: Opacity(
            opacity: _imageOpacityAnimation.value,
            child: Container(
              width: 270,
              height: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), // Selon vos specs
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/avatar_placeholder.png'),
                      fit: BoxFit.cover,
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

  /// Construit les points de pagination animés
  Widget _buildAnimatedDots() {
    return AnimatedBuilder(
      animation: _dotsAnimationController,
      builder: (context, child) {
        return Opacity(
          opacity: _dotsOpacityAnimation.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Point actif (doré)
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppColors.adDotsGolden,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: AppConstants.paddingSmall),
              
              // Points inactifs (blancs)
              for (int i = 0; i < 2; i++) ...[
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.adDotsWhite,
                    shape: BoxShape.circle,
                  ),
                ),
                if (i < 1) SizedBox(width: AppConstants.paddingSmall),
              ],
            ],
          ),
        );
      },
    );
  }

  /// Construit le texte de présentation animé
  Widget _buildAnimatedText() {
    return AnimatedBuilder(
      animation: _textAnimationController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlideAnimation,
          child: FadeTransition(
            opacity: _textOpacityAnimation,
            child: Column(
              children: [
                // Titre "Avec My Witti"
                Text(
                  'Avec My Witti',
                  style: AppFonts.poppinsSemiBold(
                    fontSize: 24,
                    color: AppColors.whiteText,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: AppConstants.paddingMedium),

                // Description
                Text(
                  'Tenez-vous au courant des\ndernières nouvelles et bonus\nsur votre programme de fidélité,\net gardez un œil sur votre solde\net vos récompenses.',
                  style: AppFonts.poppinsRegular(
                    fontSize: 14,
                    color: AppColors.whiteText,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Construit la barre de progression animée
  Widget _buildAnimatedProgressBar() {
    return AnimatedBuilder(
      animation: _progressAnimationController,
      builder: (context, child) {
        return Column(
          children: [
            // Barre de progression
            Container(
              width: double.infinity,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.progressBarBackground,
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _progressAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.progressBarFill,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            SizedBox(height: AppConstants.paddingSmall),

            // Texte d'instruction
            Text(
              'Touchez l\'écran pour continuer',
              style: AppFonts.poppinsRegular(
                fontSize: 12,
                color: AppColors.whiteText.withOpacity(0.8),
              ),
            ),
          ],
        );
      },
    );
  }
}