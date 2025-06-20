import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';

// Navigation vers les autres écrans
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../history/presentation/screens/history_screen.dart';
import '../../../rewards/presentation/screens/rewards_screen.dart';
import '../../../chat/presentation/screens/chat_screen.dart';
import '../../../profil/presentation/screens/profil_screen.dart';
/// Écran principal du dashboard de l'application MyWitti
/// Affiche le solde de jetons, la catégorie utilisateur et les transactions récentes
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  // État du dashboard
  int _currentTokens = 200;
  String _userCategory = AppConstants.categoryExecutive;
  String _userName = 'M. AKPA';
  bool _hasNotifications = true;

  // Contrôleurs d'animation
  late AnimationController _headerAnimationController;
  late AnimationController _tokensAnimationController;
  late AnimationController _categoryAnimationController;
  late AnimationController _transactionsAnimationController;

  // Animations
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<double> _tokensScaleAnimation;
  late Animation<double> _categorySlideAnimation;
  late Animation<double> _transactionsFadeAnimation;

  // Index de navigation
  int _currentBottomNavIndex = 0;

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
    _tokensAnimationController.dispose();
    _categoryAnimationController.dispose();
    _transactionsAnimationController.dispose();
    super.dispose();
  }

  /// Initialise toutes les animations
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
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeOut,
    ));

    // Tokens animation
    _tokensAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _tokensScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _tokensAnimationController,
      curve: Curves.elasticOut,
    ));

    // Category animation
    _categoryAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _categorySlideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _categoryAnimationController,
      curve: Curves.easeOut,
    ));

    // Transactions animation
    _transactionsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _transactionsFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _transactionsAnimationController,
      curve: Curves.easeOut,
    ));
  }

  /// Démarre la séquence d'animations
  void _startAnimationSequence() async {
    // Header
    _headerAnimationController.forward();

    // Tokens après 200ms
    await Future.delayed(const Duration(milliseconds: 200));
    _tokensAnimationController.forward();

    // Category après 300ms
    await Future.delayed(const Duration(milliseconds: 300));
    _categoryAnimationController.forward();

    // Transactions après 400ms
    await Future.delayed(const Duration(milliseconds: 400));
    _transactionsAnimationController.forward();
  }

  /// Charge les données utilisateur
  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString(AppConstants.keyUserEmail);
      
      if (email != null) {
        setState(() {
          _userName = 'M. ${email.toUpperCase()}';
        });
      }
    } catch (e) {
      if (AppConstants.isDebugMode) {
        debugPrint('Error loading user data: $e');
      }
    }
  }

  /// Gère la navigation bottom
  void _onBottomNavTap(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });

    switch (index) {
      case 1: // Historique
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HistoryScreen(),
          ),
        );
        break;
      case 2: // Récompenses
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RewardsScreen(),
          ),
        );
        break;
      case 3: // Chat
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ChatScreen(),
          ),
        );
        break;
      case 4: // Profil
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ad_bg.jpg'), // Fond du dashboard
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Premier card avec header (fond onboarding_bg.png)
              _buildHeaderCard(),

              // Contenu principal avec scroll
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppConstants.paddingMedium),

                      // Deuxième card - Jetons avec fond
                      _buildTokensCard(),

                      SizedBox(height: AppConstants.paddingLarge),

                      // Votre catégorie : (titre centré en noir)
                      Center(
                        child: Text(
                          'Votre catégorie',
                          style: AppFonts.poppinsBold(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: AppConstants.paddingMedium),

                      // Troisième card - Catégorie Executive
                      _buildCategoryCard(),

                      SizedBox(height: AppConstants.paddingLarge),

                      // Quatrième card - Jauge de progression avec jauge.png
                      _buildProgressCard(),

                      SizedBox(height: AppConstants.paddingLarge),

                      // Mes transactions récentes
                      _buildTransactionsSection(),

                      SizedBox(height: 100), // Espace pour la navigation
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  /// Premier card avec logo, titre et notification (fond onboarding_bg.png)
  Widget _buildHeaderCard() {
    return Container(
      margin: EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/onboarding_bg.png'), // Fond du premier card
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: AppColors.titleBlockBorder,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppConstants.paddingLarge),
        child: Row(
          children: [
            // Logo
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            SizedBox(width: AppConstants.paddingMedium),
            
            // Titre
            Expanded(
              child: Text(
                'Mon dashboard',
                style: AppFonts.poppinsBold(
                  fontSize: 20,
                  color: AppColors.whiteText,
                ),
              ),
            ),
            
            // Cloche de notification
            _buildNotificationBell(),
          ],
        ),
      ),
    );
  }

  /// Deuxième card - Jetons avec fond et image
  Widget _buildTokensCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        image: const DecorationImage(
          image: AssetImage('assets/images/jetons.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Bienvenue $_userName',
            style: AppFonts.poppinsBold(
              fontSize: 16,
              color: AppColors.whiteText,
            ),
          ),
          SizedBox(height: AppConstants.paddingSmall),
          Text(
            'Vous disposez de',
            style: AppFonts.poppinsRegular(
              fontSize: 14,
              color: AppColors.whiteText,
            ),
          ),
          SizedBox(height: AppConstants.paddingSmall),
          Text(
            '$_currentTokens',
            style: AppFonts.poppinsBold(
              fontSize: 48,
              color: AppColors.whiteText,
            ),
          ),
          Text(
            'jetons',
            style: AppFonts.poppinsRegular(
              fontSize: 16,
              color: AppColors.whiteText,
            ),
          ),
        ],
      ),
    );
  }

  /// Troisième card - Catégorie Executive avec fond blanc
  Widget _buildCategoryCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white, // Fond blanc
        border: Border.all(
          color: AppColors.titleBlockBorder,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Row(
        children: [
          // Étoile dans cercle bleu ciel
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: AppColors.categoryStarBackground,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/star.png',
              width: 30,
              height: 30,
            ),
          ),
          
          SizedBox(width: AppConstants.paddingMedium),
          
          // Colonne avec Executive et texte
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Executive',
                  style: AppFonts.interBold(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'A 800 jetons du prochain palier !',
                  style: AppFonts.interRegular(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          // Pourcentage
          Text(
            '20%',
            style: AppFonts.interBold(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// Image jauge directement avec bordures arrondies
  Widget _buildProgressCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      child: Container(
        width: double.infinity,
        height: 140, // Même hauteur que le deuxième card (jetons)
        child: Image.asset(
          'assets/images/jauge.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Section des transactions récentes
  Widget _buildTransactionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mes transactions récentes',
          style: AppFonts.poppinsBold(
            fontSize: 18,
            color: AppColors.whiteText,
          ),
        ),
        SizedBox(height: AppConstants.paddingMedium),
        
        Container(
          decoration: BoxDecoration(
            color: AppColors.transactionBackground,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          ),
          child: Column(
            children: [
              _buildTransactionItem(
                'Retrait',
                'Hier, 10:40 AM',
                '- 100 000 FCFA',
                AppColors.withdrawColor,
                Icons.arrow_downward,
              ),
              _buildTransactionSeparator(),
              _buildTransactionItem(
                'Depot',
                'Avant-hier, 15:20 PM',
                '+ 2 000 000 FCFA',
                AppColors.depositColor,
                Icons.arrow_upward,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Construit le header animé
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mon dashboard',
                        style: AppFonts.poppinsBold(
                          fontSize: 20,
                          color: AppColors.whiteText,
                        ),
                      ),
                      Text(
                        'Bienvenue $_userName',
                        style: AppFonts.poppinsBold(
                          fontSize: 14,
                          color: AppColors.whiteText,
                        ),
                      ),
                    ],
                  ),
                  _buildNotificationBell(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Construit la cloche de notification avec navigation
  Widget _buildNotificationBell() {
    return GestureDetector(
      onTap: () {
        // Navigation vers l'écran des notifications
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const NotificationsScreen(),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(AppConstants.paddingMedium),
            decoration: const BoxDecoration(
              color: AppColors.notificationBackground,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications,
              color: AppColors.startButtonText,
              size: 24,
            ),
          ),
          if (_hasNotifications)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.alertBackground,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Construit la section des jetons animée
  Widget _buildAnimatedTokensSection() {
    return AnimatedBuilder(
      animation: _tokensAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _tokensScaleAnimation.value,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppConstants.paddingLarge),
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
            ),
            child: Column(
              children: [
                Text(
                  'Vous disposez de',
                  style: AppFonts.poppinsRegular(
                    fontSize: 14,
                    color: AppColors.whiteText,
                  ),
                ),
                SizedBox(height: AppConstants.paddingSmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$_currentTokens',
                      style: AppFonts.poppinsBold(
                        fontSize: 48,
                        color: AppColors.whiteText,
                      ),
                    ),
                    SizedBox(width: AppConstants.paddingMedium),
                    Container(
                      padding: EdgeInsets.all(AppConstants.paddingSmall),
                      decoration: const BoxDecoration(
                        color: AppColors.goldenBorder,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.monetization_on,
                        color: AppColors.startButtonText,
                        size: 32,
                      ),
                    ),
                  ],
                ),
                Text(
                  'jetons',
                  style: AppFonts.poppinsRegular(
                    fontSize: 14,
                    color: AppColors.whiteText,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Construit la section catégorie avec graphique circulaire
  Widget _buildAnimatedCategorySection() {
    return AnimatedBuilder(
      animation: _categoryAnimationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_categorySlideAnimation.value * 100, 0),
          child: Opacity(
            opacity: 1 - _categorySlideAnimation.value,
            child: Container(
              padding: EdgeInsets.all(AppConstants.paddingLarge),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Votre catégorie :',
                    style: AppFonts.poppinsBold(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: AppConstants.paddingLarge),
                  
                  // Graphique circulaire avec catégories
                  Center(
                    child: SizedBox(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Graphique circulaire
                          CustomPaint(
                            size: const Size(200, 200),
                            painter: CategoryCirclePainter(),
                          ),
                          
                          // Texte au centre
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$_currentTokens',
                                style: AppFonts.poppinsBold(
                                  fontSize: 24,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                '25 %',
                                style: AppFonts.interBold(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: AppConstants.paddingMedium),
                  
                  Text(
                    'A 800 jetons du prochain palier !',
                    style: AppFonts.interRegular(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Construit les transactions récentes animées
  Widget _buildAnimatedTransactions() {
    return AnimatedBuilder(
      animation: _transactionsAnimationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _transactionsFadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mes transactions récentes',
                style: AppFonts.poppinsBold(
                  fontSize: 16,
                  color: AppColors.whiteText,
                ),
              ),
              SizedBox(height: AppConstants.paddingMedium),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                ),
                child: Column(
                  children: [
                    _buildTransactionItem(
                      'Retrait',
                      'Hier, 10:40 AM',
                      '- 100 000 F',
                      AppColors.withdrawColor,
                      Icons.arrow_downward,
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
                      color: AppColors.transactionSeparator,
                    ),
                    _buildTransactionItem(
                      'Depot',
                      'Avant-hier, 15:20 PM',
                      '+ 2 000 000 F',
                      AppColors.depositColor,
                      Icons.arrow_upward,
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
                      color: AppColors.transactionSeparator,
                    ),
                    _buildTransactionItem(
                      'Retrait',
                      'Il y a 3 jours, 09:15 AM',
                      '- 100 000 F',
                      AppColors.withdrawColor,
                      Icons.arrow_downward,
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
                      color: AppColors.transactionSeparator,
                    ),
                    _buildTransactionItem(
                      'Depot',
                      'Il y a 5 jours, 14:30 PM',
                      '+ 2 000 000 F',
                      AppColors.depositColor,
                      Icons.arrow_upward,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Construit un élément de transaction
  Widget _buildTransactionItem(
    String type,
    String time,
    String amount,
    Color typeColor,
    IconData icon,
  ) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppConstants.paddingSmall),
            decoration: BoxDecoration(
              color: typeColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.whiteText,
              size: 16,
            ),
          ),
          SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: AppFonts.poppinsMedium(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  time,
                  style: AppFonts.poppinsItalic(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: AppFonts.robotoMedium(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// Construit un séparateur de transaction
  Widget _buildTransactionSeparator() {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
      color: AppColors.transactionSeparator,
    );
  }

  /// Construit la navigation bottom avec espacement justifié
  Widget _buildBottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navigationBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstants.borderRadiusLarge),
          topRight: Radius.circular(AppConstants.borderRadiusLarge),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
            vertical: AppConstants.paddingMedium,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacement justifié
            children: [
              // Dashboard
              _buildNavItem(
                Icons.dashboard,
                'Dashboard',
                0,
                isSelected: _currentBottomNavIndex == 0,
              ),
              
              // Historique
              _buildNavItem(
                Icons.history,
                'Historique',
                1,
                isSelected: _currentBottomNavIndex == 1,
              ),
              
              // Récompenses (fond bleu comme les autres)
              _buildLargeNavItem(),
              
              // Chat
              _buildNavItem(
                Icons.chat,
                'Chat',
                3,
                isSelected: _currentBottomNavIndex == 3,
              ),
              
              // Profil
              _buildNavItem(
                Icons.person,
                'Profil',
                4,
                isSelected: _currentBottomNavIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Construit un élément de navigation normal avec centrage parfait
  Widget _buildNavItem(
    IconData icon,
    String label,
    int index, {
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: () => _onBottomNavTap(index),
      child: Container(
        width: 60, // Largeur fixe pour centrage uniforme
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.activeTab : AppColors.inactiveTab,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: AppFonts.interMedium(
                fontSize: 10,
                color: isSelected ? AppColors.activeTab : AppColors.inactiveTab,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Construit l'élément gift avec fond bleu et centrage parfait
  Widget _buildLargeNavItem() {
    return GestureDetector(
      onTap: () => _onBottomNavTap(2),
      child: Container(
        width: 60, // Même largeur pour alignement
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(AppConstants.paddingMedium),
              decoration: BoxDecoration(
                color: AppColors.navigationBackground, // Fond bleu comme les autres
                shape: BoxShape.circle,
                border: Border.all(
                  color: _currentBottomNavIndex == 2 ? AppColors.activeTab : AppColors.inactiveTab,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.card_giftcard, // Gift icon plus grand
                color: _currentBottomNavIndex == 2 ? AppColors.activeTab : AppColors.inactiveTab,
                size: 32, // Plus grande taille
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Récompenses',
              style: AppFonts.interMedium(
                fontSize: 10,
                color: _currentBottomNavIndex == 2 ? AppColors.activeTab : AppColors.inactiveTab,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

  /// Construit un élément de transaction
  Widget _buildTransactionItem(
    String type,
    String time,
    String amount,
    Color typeColor,
    IconData icon,
  ) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppConstants.paddingSmall),
            decoration: BoxDecoration(
              color: typeColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.whiteText,
              size: 16,
            ),
          ),
          SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: AppFonts.poppinsMedium(
                    fontSize: 14,
                    color: AppColors.depositWithdrawText,
                  ),
                ),
                Text(
                  time,
                  style: AppFonts.poppinsItalic(
                    fontSize: 11,
                    color: AppColors.transferMethodText,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: AppFonts.robotoMedium(
              fontSize: 14,
              color: AppColors.depositWithdrawText,
            ),
          ),
        ],
      ),
    );
  }


/// Painter pour le graphique circulaire des catégories (non utilisé dans le nouveau design)
class CategoryCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Classe gardée pour compatibilité mais non utilisée dans le nouveau design
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}