import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';

// Navigation vers les autres écrans
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../../../onboarding/presentation/screens/onboarding_screen.dart';

/// Écran de connexion de l'application MyWitti
/// Permet à l'utilisateur de se connecter avec son code client et mot de passe
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  // Contrôleurs de formulaire
  final _clientCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // État du formulaire
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Contrôleur d'animation
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startEntryAnimation();
  }

  @override
  void dispose() {
    _clientCodeController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  /// Initialise les animations d'entrée
  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  /// Démarre l'animation d'entrée
  void _startEntryAnimation() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  /// Gère l'action de connexion
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulation d'une connexion (remplacer par vraie API)
      await Future.delayed(const Duration(seconds: 2));

      // Code client temporaire pour la démo
      final String clientCode = _clientCodeController.text;
      final String password = _passwordController.text;

      // Validation simple pour la démo
      bool isValidLogin = clientCode.isNotEmpty && password.isNotEmpty;

      if (isValidLogin) {
        // Sauvegarder l'état de connexion
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConstants.keyAuthToken, 'demo_token_123');
        await prefs.setString(AppConstants.keyUserEmail, clientCode);
        await prefs.setBool(AppConstants.keyRememberMe, _rememberMe);

        if (mounted) {
          // Navigation vers le dashboard
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const DashboardScreen(),
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
      } else {
        _showErrorMessage(AppStrings.invalidCredentials);
      }
    } catch (e) {
      if (AppConstants.isDebugMode) {
        debugPrint('Login error: $e');
      }
      _showErrorMessage(AppStrings.connectionError);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Affiche un message d'erreur
  void _showErrorMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.withdrawColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
      ),
    );
  }

  /// Validation du code client
  String? _validateClientCode(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    if (value.length < 3) {
      return 'Le code client doit contenir au moins 3 caractères';
    }
    return null;
  }

  /// Validation du mot de passe
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    if (value.length < 4) {
      return 'Le mot de passe doit contenir au moins 4 caractères';
    }
    return null;
  }

  /// Navigation vers l'onboarding
  void _navigateToOnboarding() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
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
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 
                              MediaQuery.of(context).padding.top - 
                              MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    children: [
                      // Header avec image
                      _buildHeader(),

                      // Contenu principal avec formulaire
                      Padding(
                        padding: EdgeInsets.all(AppConstants.paddingLarge),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Titre
                              _buildTitle(),

                              SizedBox(height: AppConstants.paddingLarge),

                              // Formulaire de connexion
                              _buildLoginForm(),

                              SizedBox(height: AppConstants.paddingLarge),

                              // Bouton Se connecter
                              _buildLoginButton(),

                              SizedBox(height: AppConstants.paddingLarge),

                              // Conditions d'utilisation
                              _buildTermsText(),

                              SizedBox(height: AppConstants.paddingLarge),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Construit le header avec l'image et bouton retour
  Widget _buildHeader() {
    return Stack(
      children: [
        // Container principal pour l'image
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.35, // 35% de l'écran
          padding: EdgeInsets.all(AppConstants.paddingLarge),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90, // 90% de la largeur
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
                child: Image.asset(
                  'assets/images/image_con.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),

        // Bouton retour positionné en haut à gauche
        Positioned(
          top: AppConstants.paddingMedium,
          left: AppConstants.paddingMedium,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _navigateToOnboarding,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.whiteText,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Construit le titre
  Widget _buildTitle() {
    return Text(
      AppStrings.loginTitle,
      style: AppFonts.loginTitle,
    );
  }

  /// Construit le formulaire de connexion
  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Code client
        _buildInputField(
          label: AppStrings.clientCodeLabel,
          hint: AppStrings.clientCodeHint,
          controller: _clientCodeController,
          validator: _validateClientCode,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
        ),

        SizedBox(height: AppConstants.paddingLarge),

        // Mot de passe
        _buildInputField(
          label: AppStrings.passwordLabel,
          hint: AppStrings.passwordHint,
          controller: _passwordController,
          validator: _validatePassword,
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: AppColors.white50,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),

        SizedBox(height: AppConstants.paddingMedium),

        // Mot de passe oublié
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // TODO: Implémenter mot de passe oublié
              _showErrorMessage('Fonctionnalité en cours de développement');
            },
            child: Text(
              AppStrings.forgotPassword,
              style: AppFonts.forgotPassword,
            ),
          ),
        ),

        SizedBox(height: AppConstants.paddingLarge),

        // Se souvenir de moi
        _buildRememberMeCheckbox(),
      ],
    );
  }

  /// Construit un champ de saisie personnalisé
  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.inputLabel,
        ),
        SizedBox(height: AppConstants.paddingSmall),
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
            border: Border.all(
              color: AppColors.inputBorder,
              width: AppConstants.borderWidthThin,
            ),
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            style: AppFonts.inputText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppFonts.inputHint,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(AppConstants.paddingMedium),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }

  /// Construit la checkbox "Se souvenir de moi"
  Widget _buildRememberMeCheckbox() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: _rememberMe ? AppColors.rememberMeButton : AppColors.transparent,
            border: Border.all(
              color: AppColors.rememberMeButton,
              width: AppConstants.borderWidthMedium,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
              activeColor: AppColors.transparent,
              checkColor: AppColors.whiteText,
              side: BorderSide.none,
            ),
          ),
        ),
        SizedBox(width: AppConstants.paddingMedium),
        Text(
          AppStrings.rememberMe,
          style: AppFonts.rememberMeText,
        ),
      ],
    );
  }

  /// Construit le bouton de connexion avec fond image
  Widget _buildLoginButton() {
    return SizedBox(
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
          onPressed: _isLoading ? null : _handleLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Transparent pour voir l'image
            foregroundColor: AppColors.startButtonText,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
            ),
            padding: EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.startButtonText),
                  ),
                )
              : Text(
                  AppStrings.buttonLogin,
                  style: AppFonts.buttonText,
                ),
        ),
      ),
    );
  }

  /// Construit le texte des conditions d'utilisation
  Widget _buildTermsText() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            AppStrings.termsPrefix,
            style: AppFonts.termsText.copyWith(color: AppColors.whiteText),
          ),
          GestureDetector(
            onTap: () {
              // TODO: Ouvrir les conditions d'utilisation
              _showErrorMessage('Ouverture des conditions d\'utilisation...');
            },
            child: Text(
              AppStrings.termsOfUse,
              style: AppFonts.termsText.copyWith(
                color: AppColors.termsText.withOpacity(0.79),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Text(
            AppStrings.termsAnd,
            style: AppFonts.termsText.copyWith(color: AppColors.whiteText),
          ),
          GestureDetector(
            onTap: () {
              // TODO: Ouvrir la politique de confidentialité
              _showErrorMessage('Ouverture de la politique de confidentialité...');
            },
            child: Text(
              AppStrings.privacyPolicy,
              style: AppFonts.termsText.copyWith(
                color: AppColors.termsText.withOpacity(0.79),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}