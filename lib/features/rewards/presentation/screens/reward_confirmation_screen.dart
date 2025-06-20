import 'package:flutter/material.dart';
import 'dart:math' as math;

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_constants.dart';

/// Écran de confirmation de récompense avec animation d'étoiles
class RewardConfirmationScreen extends StatefulWidget {
  final String rewardTitle;
  final int tokens;

  const RewardConfirmationScreen({
    super.key,
    required this.rewardTitle,
    required this.tokens,
  });

  @override
  State<RewardConfirmationScreen> createState() => _RewardConfirmationScreenState();
}

class _RewardConfirmationScreenState extends State<RewardConfirmationScreen>
    with TickerProviderStateMixin {
  
  late AnimationController _starsAnimationController;
  late AnimationController _checkAnimationController;
  late AnimationController _textAnimationController;
  late AnimationController _buttonAnimationController;
  
  late Animation<double> _checkScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _buttonFadeAnimation;
  
  // Liste des étoiles animées
  final List<StarParticle> _stars = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _generateStars();
    _startAnimationSequence();
  }

  @override
  void dispose() {
    _starsAnimationController.dispose();
    _checkAnimationController.dispose();
    _textAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  /// Initialise toutes les animations
  void _initializeAnimations() {
    // Animation des étoiles (continue)
    _starsAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Animation du check (1.5s)
    _checkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _checkScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _checkAnimationController,
      curve: Curves.elasticOut,
    ));

    // Animation du texte (1s)
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeOut,
    ));

    // Animation du bouton (0.8s)
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _buttonFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeOut,
    ));
  }

  /// Génère les étoiles aléatoirement
  void _generateStars() {
    final random = math.Random();
    for (int i = 0; i < 30; i++) {
      _stars.add(
        StarParticle(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: random.nextDouble() * 8 + 4,
          speed: random.nextDouble() * 0.5 + 0.2,
          opacity: random.nextDouble() * 0.8 + 0.2,
        ),
      );
    }
  }

  /// Démarre la séquence d'animations
  void _startAnimationSequence() async {
    // Check apparaît en premier
    await Future.delayed(const Duration(milliseconds: 300));
    _checkAnimationController.forward();

    // Texte après 800ms
    await Future.delayed(const Duration(milliseconds: 800));
    _textAnimationController.forward();

    // Bouton après 500ms
    await Future.delayed(const Duration(milliseconds: 500));
    _buttonAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Animation des étoiles en arrière-plan
            AnimatedBuilder(
              animation: _starsAnimationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: StarsPainter(_stars, _starsAnimationController.value),
                  size: Size.infinite,
                );
              },
            ),
            
            // Contenu principal
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(AppConstants.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    
                    // Icône de validation avec animation
                    AnimatedBuilder(
                      animation: _checkAnimationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _checkScaleAnimation.value,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                              color: AppColors.goldenBorder,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 60,
                              color: AppColors.startButtonText,
                            ),
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: AppConstants.paddingExtraLarge),
                    
                    // Texte de félicitations avec animation
                    AnimatedBuilder(
                      animation: _textAnimationController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _textFadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'Félicitations',
                                style: AppFonts.poppinsBold(
                                  fontSize: 28,
                                  color: AppColors.whiteText,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              
                              SizedBox(height: AppConstants.paddingLarge),
                              
                              Text(
                                'Vous avez passé votre commande de récompenses.',
                                style: AppFonts.poppinsRegular(
                                  fontSize: 16,
                                  color: AppColors.whiteText,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              
                              SizedBox(height: AppConstants.paddingMedium),
                              
                              Text(
                                'Vous recevrez une notification pour valider la commande.',
                                style: AppFonts.poppinsRegular(
                                  fontSize: 14,
                                  color: AppColors.white80,
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    
                    const Spacer(),
                    
                    // Bouton Continuer avec animation
                    AnimatedBuilder(
                      animation: _buttonAnimationController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _buttonFadeAnimation,
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
                                onPressed: () {
                                  Navigator.of(context).pop(); // Retour à l'écran précédent
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                                  ),
                                ),
                                child: Text(
                                  'Continuer',
                                  style: AppFonts.poppinsSemiBold(
                                    fontSize: 18,
                                    color: AppColors.startButtonText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: AppConstants.paddingLarge),
                    
                    // Indicateur de page (barre blanche)
                    Container(
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.whiteText,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.paddingLarge),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modèle pour une particule d'étoile
class StarParticle {
  double x;
  double y;
  final double size;
  final double speed;
  final double opacity;

  StarParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

/// Painter pour dessiner les étoiles animées
class StarsPainter extends CustomPainter {
  final List<StarParticle> stars;
  final double animationValue;

  StarsPainter(this.stars, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.goldenBorder
      ..style = PaintingStyle.fill;

    for (final star in stars) {
      // Mise à jour de la position Y (mouvement vers le bas)
      star.y = (star.y + star.speed * 0.01) % 1.0;
      
      // Position sur l'écran
      final x = star.x * size.width;
      final y = star.y * size.height;
      
      // Opacité avec scintillement
      final opacity = star.opacity * (0.5 + 0.5 * math.sin(animationValue * 2 * math.pi + star.x * 10));
      paint.color = AppColors.goldenBorder.withOpacity(opacity);
      
      // Dessiner l'étoile
      _drawStar(canvas, paint, x, y, star.size);
    }
  }

  /// Dessine une étoile à 5 branches
  void _drawStar(Canvas canvas, Paint paint, double x, double y, double size) {
    const int numPoints = 5;
    final double angleStep = 2 * math.pi / numPoints;
    final Path path = Path();

    for (int i = 0; i < numPoints * 2; i++) {
      final double angle = i * angleStep / 2;
      final double radius = i.isEven ? size : size * 0.5;
      final double dx = math.cos(angle - math.pi / 2) * radius;
      final double dy = math.sin(angle - math.pi / 2) * radius;

      if (i == 0) {
        path.moveTo(x + dx, y + dy);
      } else {
        path.lineTo(x + dx, y + dy);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}