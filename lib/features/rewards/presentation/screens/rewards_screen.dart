import 'package:flutter/material.dart';

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_constants.dart';

// Navigation vers l'écran de confirmation
import 'reward_confirmation_screen.dart';

/// Écran des récompenses
class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  // Index de l'onglet sélectionné
  int _selectedTabIndex = 0;
  
  // Index du filtre de catégorie sélectionné
  int _selectedCategoryIndex = 0;
  
  // Liste des onglets
  final List<String> _tabs = [
    'Récompenses',
    'Favoris',
    'Panier',
  ];
  
  // Liste des catégories
  final List<String> _categories = [
    'Tous dans',
    'Executive +',
    'Executive',
    'Eco Premium',
  ];
  
  // Liste des récompenses
  final List<RewardItem> _rewards = [
    RewardItem(
      title: '2-3 Tickets cinema',
      subtitle: 'Prix (15 000F)',
      tokens: 900,
      category: 'Executive',
      categoryImage: 'assets/images/categories/executive.png',
      isFavorite: true,
      isAvailable: true,
    ),
    RewardItem(
      title: 'Bon d\'achat 25 000F',
      subtitle: '',
      tokens: 2500,
      category: 'Executive +',
      categoryImage: 'assets/images/categories/executive_plus.png',
      isFavorite: false,
      isAvailable: true,
    ),
    RewardItem(
      title: '4 Tickets de brunch Hotel de luxe',
      subtitle: '',
      tokens: 29000,
      category: 'First class',
      categoryImage: 'assets/images/categories/first_class.png',
      isFavorite: false,
      isAvailable: false,
    ),
    RewardItem(
      title: 'Trousse de voyage',
      subtitle: '',
      tokens: 800,
      category: 'Executive',
      categoryImage: 'assets/images/categories/executive.png',
      isFavorite: true,
      isAvailable: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ad_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Onglets
              _buildTabs(),
              
              // Contenu principal
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.borderRadiusLarge),
                      topRight: Radius.circular(AppConstants.borderRadiusLarge),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Filtres de catégories
                      _buildCategoryFilters(),
                      
                      // Compteur d'achats
                      _buildPurchaseCounter(),
                      
                      // Liste des récompenses
                      Expanded(
                        child: _buildRewardsList(),
                      ),
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

  /// Construit le header
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(AppConstants.paddingLarge),
      child: Row(
        children: [
          // Logo MyWitti
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          SizedBox(width: AppConstants.paddingMedium),
          
          // Titre Récompenses
          Expanded(
            child: Text(
              'Récompenses',
              style: AppFonts.poppinsBold(
                fontSize: 20,
                color: AppColors.whiteText,
              ),
            ),
          ),
          
          // Icône cloche
          Container(
            padding: EdgeInsets.all(AppConstants.paddingSmall),
            decoration: const BoxDecoration(
              color: AppColors.notificationBackground,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications,
              color: AppColors.startButtonText,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  /// Construit les onglets
  Widget _buildTabs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = index == _selectedTabIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.goldenBorder : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (index == 1) // Favoris
                      Icon(
                        Icons.favorite,
                        size: 16,
                        color: isSelected ? AppColors.whiteText : AppColors.white50,
                      )
                    else if (index == 2) // Panier
                      Icon(
                        Icons.shopping_cart,
                        size: 16,
                        color: isSelected ? AppColors.whiteText : AppColors.white50,
                      ),
                    if (index > 0) SizedBox(width: 4),
                    Text(
                      _tabs[index],
                      style: AppFonts.poppinsSemiBold(
                        fontSize: 14,
                        color: isSelected ? AppColors.whiteText : AppColors.white50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Construit les filtres de catégories
  Widget _buildCategoryFilters() {
    return Container(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_categories.length, (index) {
            final isSelected = index == _selectedCategoryIndex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: AppConstants.paddingSmall),
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMedium,
                  vertical: AppConstants.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.goldenBorder : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _categories[index],
                  style: AppFonts.poppinsRegular(
                    fontSize: 12,
                    color: isSelected ? AppColors.startButtonText : Colors.grey.shade600,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// Construit le compteur d'achats
  Widget _buildPurchaseCounter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      child: Row(
        children: [
          Text(
            'Achat :',
            style: AppFonts.poppinsRegular(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(width: AppConstants.paddingSmall),
          Text(
            '300 / 350',
            style: AppFonts.poppinsBold(
              fontSize: 12,
              color: AppColors.goldenBorder,
            ),
          ),
        ],
      ),
    );
  }

  /// Construit la liste des récompenses
  Widget _buildRewardsList() {
    return ListView.builder(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      itemCount: _rewards.length,
      itemBuilder: (context, index) {
        final reward = _rewards[index];
        return _buildRewardCard(reward);
      },
    );
  }

  /// Construit une carte de récompense
  Widget _buildRewardCard(RewardItem reward) {
    return Container(
      margin: EdgeInsets.only(bottom: AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image de la récompense
          Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
              image: DecorationImage(
                image: AssetImage(_getRewardImage(reward.title)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Contenu
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre
                  Text(
                    reward.title,
                    style: AppFonts.poppinsSemiBold(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  if (reward.subtitle.isNotEmpty) ...[
                    SizedBox(height: 2),
                    Text(
                      reward.subtitle,
                      style: AppFonts.poppinsRegular(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                  
                  SizedBox(height: AppConstants.paddingSmall),
                  
                  // Tokens et catégorie
                  Row(
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 14,
                        color: AppColors.goldenBorder,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${reward.tokens}',
                        style: AppFonts.poppinsBold(
                          fontSize: 12,
                          color: AppColors.goldenBorder,
                        ),
                      ),
                      SizedBox(width: AppConstants.paddingMedium),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: AssetImage(reward.categoryImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        reward.category,
                        style: AppFonts.poppinsRegular(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Actions (favoris et disponibilité)
          Padding(
            padding: EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              children: [
                // Icône favoris
                GestureDetector(
                  onTap: () {
                    setState(() {
                      reward.isFavorite = !reward.isFavorite;
                    });
                  },
                  child: Icon(
                    reward.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: reward.isFavorite ? Colors.red : Colors.grey.shade400,
                    size: 20,
                  ),
                ),
                
                SizedBox(height: AppConstants.paddingSmall),
                
                // Bouton d'action
                GestureDetector(
                  onTap: () {
                    if (reward.isAvailable) {
                      // Navigation vers l'écran de confirmation
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RewardConfirmationScreen(
                            rewardTitle: reward.title,
                            tokens: reward.tokens,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingSmall,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: reward.isAvailable ? AppColors.goldenBorder : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      reward.isAvailable ? 'Obtenir' : 'Épuisé',
                      style: AppFonts.poppinsRegular(
                        fontSize: 10,
                        color: reward.isAvailable ? AppColors.startButtonText : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Retourne l'image appropriée selon le titre de la récompense
  String _getRewardImage(String title) {
    if (title.contains('cinema') || title.contains('Tickets')) {
      return 'assets/images/rewards/ticket.png';
    } else if (title.contains('Bon d\'achat')) {
      return 'assets/images/rewards/gift_card.png';
    } else if (title.contains('brunch') || title.contains('Hotel')) {
      return 'assets/images/rewards/restaurant.png';
    } else if (title.contains('Trousse') || title.contains('voyage')) {
      return 'assets/images/rewards/travel.png';
    }
    return 'assets/images/rewards/default.png';
  }

  /// Construit la navigation bottom avec récompenses sélectionné
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.dashboard, 'Dashboard', false),
              _buildNavItem(Icons.history, 'Historique', false),
              _buildCenterNavItem(isSelected: true), // Récompenses sélectionné
              _buildNavItem(Icons.chat, 'Chat', false),
              _buildNavItem(Icons.person, 'Profil', false),
            ],
          ),
        ),
      ),
    );
  }

  /// Construit un élément de navigation
  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Container(
      width: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
    );
  }

  /// Construit l'élément central de navigation
  Widget _buildCenterNavItem({bool isSelected = false}) {
    return Container(
      width: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.goldenBorder : AppColors.navigationBackground,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.goldenBorder : AppColors.inactiveTab,
                width: 2,
              ),
            ),
            child: Icon(
              Icons.card_giftcard,
              color: isSelected ? AppColors.startButtonText : AppColors.inactiveTab,
              size: 32,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Récompenses',
            style: AppFonts.interMedium(
              fontSize: 10,
              color: isSelected ? AppColors.activeTab : AppColors.inactiveTab,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Modèle pour les éléments de récompense
class RewardItem {
  final String title;
  final String subtitle;
  final int tokens;
  final String category;
  final String categoryImage;
  bool isFavorite;
  final bool isAvailable;

  RewardItem({
    required this.title,
    required this.subtitle,
    required this.tokens,
    required this.category,
    required this.categoryImage,
    required this.isFavorite,
    required this.isAvailable,
  });
}