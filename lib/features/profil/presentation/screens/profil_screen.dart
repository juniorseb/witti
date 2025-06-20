import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';

// Navigation vers les autres écrans
import '../../../auth/presentation/screens/login_screen.dart';

/// Écran de profil de l'application MyWitti
/// Affiche les informations utilisateur et les options de paramétrage
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  
  // État du profil
  String _userName = 'Jean Akpa';
  String _userEmail = 'jean.akpa@mywitti.com';
  String _userPhone = '+225 07 08 09 10 11';
  int _currentTokens = 200;
  String _userCategory = 'Executive';
  String _memberSince = 'Membre depuis Mars 2024';
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;
  bool _emailNotifications = true;
  bool _smsNotifications = false;

  // Contrôleurs d'animation
  late AnimationController _headerAnimationController;
  late AnimationController _contentAnimationController;
  late AnimationController _statsAnimationController;

  // Animations
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<double> _contentFadeAnimation;
  late Animation<double> _statsScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
    _loadUserData();
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _contentAnimationController.dispose();
    _statsAnimationController.dispose();
    super.dispose();
  }

  /// Initialise les animations
  void _initializeAnimations() {
    // Header animation
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _headerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeOut,
    ));

    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeOut,
    ));

    // Content animation
    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _contentFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _contentAnimationController,
      curve: Curves.easeOut,
    ));

    // Stats animation
    _statsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _statsScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _statsAnimationController,
      curve: Curves.elasticOut,
    ));
  }

  /// Démarre la séquence d'animations
  void _startAnimationSequence() async {
    _headerAnimationController.forward();
    
    await Future.delayed(const Duration(milliseconds: 200));
    _contentAnimationController.forward();
    
    await Future.delayed(const Duration(milliseconds: 300));
    _statsAnimationController.forward();
  }

  /// Charge les données utilisateur
  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString(AppConstants.keyUserEmail);
      
      if (email != null) {
        setState(() {
          _userEmail = email;
          _userName = 'Jean Akpa'; // Peut être récupéré d'une API
        });
      }
      
      setState(() {
        _notificationsEnabled = prefs.getBool(AppConstants.keyNotificationsEnabled) ?? true;
        _biometricEnabled = prefs.getBool(AppConstants.keyBiometricEnabled) ?? false;
      });
    } catch (e) {
      if (AppConstants.isDebugMode) {
        debugPrint('Error loading user data: $e');
      }
    }
  }

  /// Gère la déconnexion
  Future<void> _handleLogout() async {
    final shouldLogout = await _showLogoutDialog();
    
    if (shouldLogout == true) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(AppConstants.keyAuthToken);
        await prefs.remove(AppConstants.keyUserEmail);
        
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        }
      } catch (e) {
        if (AppConstants.isDebugMode) {
          debugPrint('Error during logout: $e');
        }
        _showErrorMessage('Erreur lors de la déconnexion');
      }
    }
  }

  /// Affiche le dialogue de confirmation de déconnexion
  Future<bool?> _showLogoutDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.withdrawColor,
            ),
            child: const Text('Déconnecter'),
          ),
        ],
      ),
    );
  }

  /// Affiche un message d'erreur
  void _showErrorMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.withdrawColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Affiche un message "Bientôt disponible"
  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Bientôt disponible'),
        backgroundColor: AppColors.categoryStarBackground,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ad_bg.jpg'), // Fond spécifié
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header avec bouton retour
              _buildAppBar(),

              // Contenu scrollable
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppConstants.paddingLarge),
                  child: Column(
                    children: [
                      // Header avec avatar et informations
                      _buildAnimatedHeader(),

                      SizedBox(height: AppConstants.paddingLarge),

                      // Statistiques animées
                      _buildAnimatedStats(),

                      SizedBox(height: AppConstants.paddingLarge),

                      // Contenu principal
                      _buildAnimatedContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Construit l'app bar avec bouton retour
  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
        vertical: AppConstants.paddingMedium,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteText,
              size: 24,
            ),
          ),
          Expanded(
            child: Text(
              'Profil',
              style: AppFonts.poppinsBold(
                fontSize: 24,
                color: AppColors.whiteText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () => _showComingSoon('Modification du profil'),
            icon: const Icon(
              Icons.edit,
              color: AppColors.whiteText,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  /// Construit le header animé avec avatar
  Widget _buildAnimatedHeader() {
    return AnimatedBuilder(
      animation: _headerAnimationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _headerFadeAnimation,
          child: SlideTransition(
            position: _headerSlideAnimation,
            child: Container(
              padding: EdgeInsets.all(AppConstants.paddingLarge),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Avatar avec l'image spécifiée
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.goldenBorder,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.goldenBorder.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar_placeholder.png', // Avatar spécifié
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: AppConstants.paddingLarge),
                  
                  // Nom d'utilisateur
                  Text(
                    _userName,
                    style: AppFonts.poppinsBold(
                      fontSize: 28,
                      color: AppColors.startButtonText,
                    ),
                  ),
                  
                  SizedBox(height: AppConstants.paddingSmall),
                  
                  // Catégorie avec badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingMedium,
                      vertical: AppConstants.paddingSmall,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.executiveBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.goldenBorder,
                          size: 16,
                        ),
                        SizedBox(width: AppConstants.paddingSmall),
                        Text(
                          _userCategory,
                          style: AppFonts.interBold(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: AppConstants.paddingSmall),
                  
                  // Membre depuis
                  Text(
                    _memberSince,
                    style: AppFonts.poppinsRegular(
                      fontSize: 14,
                      color: Colors.grey[600]!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Construit les statistiques animées
  Widget _buildAnimatedStats() {
    return AnimatedBuilder(
      animation: _statsAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _statsScaleAnimation.value,
          child: Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  '$_currentTokens',
                  'Jetons',
                  Icons.monetization_on,
                  AppColors.goldenBorder,
                ),
              ),
              SizedBox(width: AppConstants.paddingMedium),
              Expanded(
                child: _buildStatCard(
                  '20%',
                  'Progression',
                  Icons.trending_up,
                  AppColors.depositColor,
                ),
              ),
              SizedBox(width: AppConstants.paddingMedium),
              Expanded(
                child: _buildStatCard(
                  '15',
                  'Récompenses',
                  Icons.card_giftcard,
                  AppColors.categoryStarBackground,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Construit une carte de statistique
  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        border: Border.all(color: color, width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: AppConstants.paddingSmall),
          Text(
            value,
            style: AppFonts.poppinsBold(
              fontSize: 18,
              color: color,
            ),
          ),
          Text(
            label,
            style: AppFonts.poppinsRegular(
              fontSize: 12,
              color: Colors.grey[600]!,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Construit le contenu animé
  Widget _buildAnimatedContent() {
    return AnimatedBuilder(
      animation: _contentAnimationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _contentFadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Informations personnelles
              _buildSectionTitle('Informations personnelles'),
              _buildMenuCard([
                _buildInfoItem(
                  Icons.email,
                  'Email',
                  _userEmail,
                ),
                _buildInfoItem(
                  Icons.phone,
                  'Téléphone',
                  _userPhone,
                ),
                _buildMenuItem(
                  Icons.edit,
                  'Modifier le profil',
                  'Changez vos informations personnelles',
                  () => _showComingSoon('Modification du profil'),
                ),
                _buildMenuItem(
                  Icons.security,
                  'Mot de passe',
                  'Modifier votre mot de passe',
                  () => _showComingSoon('Changement de mot de passe'),
                ),
              ]),

              SizedBox(height: AppConstants.paddingLarge),

              // Section Notifications
              _buildSectionTitle('Notifications'),
              _buildMenuCard([
                _buildToggleMenuItem(
                  Icons.notifications,
                  'Notifications push',
                  'Recevoir les notifications sur l\'appareil',
                  _notificationsEnabled,
                  (value) async {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                    
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool(AppConstants.keyNotificationsEnabled, value);
                  },
                ),
                _buildToggleMenuItem(
                  Icons.email,
                  'Notifications email',
                  'Recevoir les notifications par email',
                  _emailNotifications,
                  (value) {
                    setState(() {
                      _emailNotifications = value;
                    });
                  },
                ),
                _buildToggleMenuItem(
                  Icons.sms,
                  'Notifications SMS',
                  'Recevoir les notifications par SMS',
                  _smsNotifications,
                  (value) {
                    setState(() {
                      _smsNotifications = value;
                    });
                  },
                ),
              ]),

              SizedBox(height: AppConstants.paddingLarge),

              // Section Sécurité
              _buildSectionTitle('Sécurité et confidentialité'),
              _buildMenuCard([
                _buildToggleMenuItem(
                  Icons.fingerprint,
                  'Authentification biométrique',
                  'Connexion par empreinte ou Face ID',
                  _biometricEnabled,
                  (value) async {
                    setState(() {
                      _biometricEnabled = value;
                    });
                    
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool(AppConstants.keyBiometricEnabled, value);
                  },
                ),
                _buildMenuItem(
                  Icons.lock,
                  'Verrouillage automatique',
                  'Configurer le verrouillage de l\'app',
                  () => _showComingSoon('Verrouillage automatique'),
                ),
                _buildMenuItem(
                  Icons.privacy_tip,
                  'Données personnelles',
                  'Gérer vos données personnelles',
                  () => _showComingSoon('Gestion des données'),
                ),
              ]),

              SizedBox(height: AppConstants.paddingLarge),

              // Section Paramètres
              _buildSectionTitle('Paramètres généraux'),
              _buildMenuCard([
                _buildMenuItem(
                  Icons.language,
                  'Langue',
                  'Français',
                  () => _showComingSoon('Changement de langue'),
                ),
                _buildMenuItem(
                  Icons.dark_mode,
                  'Thème',
                  'Clair / Sombre',
                  () => _showComingSoon('Changement de thème'),
                ),
                _buildMenuItem(
                  Icons.currency_exchange,
                  'Devise',
                  'FCFA',
                  () => _showComingSoon('Changement de devise'),
                ),
              ]),

              SizedBox(height: AppConstants.paddingLarge),

              // Section Support
              _buildSectionTitle('Support et aide'),
              _buildMenuCard([
                _buildMenuItem(
                  Icons.help_outline,
                  'Centre d\'aide',
                  'FAQ et tutoriels',
                  () => _showComingSoon('Centre d\'aide'),
                ),
                _buildMenuItem(
                  Icons.contact_support,
                  'Nous contacter',
                  'Envoyer un message au support',
                  () => _showComingSoon('Support client'),
                ),
                _buildMenuItem(
                  Icons.bug_report,
                  'Signaler un problème',
                  'Rapporter un bug ou un dysfonctionnement',
                  () => _showComingSoon('Signalement de bug'),
                ),
                _buildMenuItem(
                  Icons.star_rate,
                  'Noter l\'application',
                  'Donnez votre avis sur MyWitti',
                  () => _showComingSoon('Notation de l\'app'),
                ),
              ]),

              SizedBox(height: AppConstants.paddingLarge),

              // Section À propos
              _buildSectionTitle('À propos'),
              _buildMenuCard([
                _buildMenuItem(
                  Icons.info_outline,
                  'À propos de MyWitti',
                  'Version ${AppConstants.appVersion}',
                  () => _showComingSoon('À propos'),
                ),
                _buildMenuItem(
                  Icons.description,
                  'Conditions d\'utilisation',
                  'Consultez nos conditions',
                  () => _showComingSoon('Conditions d\'utilisation'),
                ),
                _buildMenuItem(
                  Icons.privacy_tip,
                  'Politique de confidentialité',
                  'Consultez notre politique',
                  () => _showComingSoon('Politique de confidentialité'),
                ),
                _buildMenuItem(
                  Icons.gavel,
                  'Mentions légales',
                  'Informations légales',
                  () => _showComingSoon('Mentions légales'),
                ),
              ]),

              SizedBox(height: AppConstants.paddingLarge),

              // Bouton de déconnexion
              _buildLogoutButton(),

              SizedBox(height: AppConstants.paddingLarge),
            ],
          ),
        );
      },
    );
  }

  /// Construit un titre de section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppConstants.paddingSmall,
        bottom: AppConstants.paddingMedium,
      ),
      child: Text(
        title,
        style: AppFonts.poppinsBold(
          fontSize: 18,
          color: AppColors.whiteText,
        ),
      ),
    );
  }

  /// Construit une carte de menu
  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  /// Construit un élément d'information (non cliquable)
  Widget _buildInfoItem(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppConstants.paddingSmall),
            decoration: BoxDecoration(
              color: AppColors.goldenBorder.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
            ),
            child: Icon(
              icon,
              color: AppColors.goldenBorder,
              size: 24,
            ),
          ),
          SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.poppinsMedium(
                    fontSize: 16,
                    color: AppColors.startButtonText,
                  ),
                ),
                Text(
                  value,
                  style: AppFonts.poppinsRegular(
                    fontSize: 14,
                    color: Colors.grey[600]!,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construit un élément de menu
  Widget _buildMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      child: Padding(
        padding: EdgeInsets.all(AppConstants.paddingMedium),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppConstants.paddingSmall),
              decoration: BoxDecoration(
                color: AppColors.goldenBorder.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
              ),
              child: Icon(
                icon,
                color: AppColors.goldenBorder,
                size: 24,
              ),
            ),
            SizedBox(width: AppConstants.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.poppinsMedium(
                      fontSize: 16,
                      color: AppColors.startButtonText,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppFonts.poppinsRegular(
                      fontSize: 12,
                      color: Colors.grey[600]!,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  /// Construit un élément de menu avec toggle
  Widget _buildToggleMenuItem(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppConstants.paddingSmall),
            decoration: BoxDecoration(
              color: AppColors.goldenBorder.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
            ),
            child: Icon(
              icon,
              color: AppColors.goldenBorder,
              size: 24,
            ),
          ),
          SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.poppinsMedium(
                    fontSize: 16,
                    color: AppColors.startButtonText,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppFonts.poppinsRegular(
                    fontSize: 12,
                    color: Colors.grey[600]!,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.goldenBorder,
          ),
        ],
      ),
    );
  }

  /// Construit le bouton de déconnexion
  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
      child: ElevatedButton.icon(
        onPressed: _handleLogout,
        icon: const Icon(Icons.logout),
        label: const Text('Déconnexion'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.withdrawColor,
          foregroundColor: AppColors.whiteText,
          padding: EdgeInsets.symmetric(vertical: AppConstants.paddingLarge),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          ),
          elevation: 3,
        ),
      ),
    );
  }
}