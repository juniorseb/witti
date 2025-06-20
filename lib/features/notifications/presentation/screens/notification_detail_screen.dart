import 'package:flutter/material.dart';

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_constants.dart';

/// Écran de détail d'une notification
class NotificationDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;

  const NotificationDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fond onboarding_bg.png pour les 20% du haut
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/onboarding_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Fond ad_bg.jpg pour les 80% du bas
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ad_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Contenu par-dessus
          SafeArea(
            child: Column(
              children: [
                // Header avec titre et bouton retour
                _buildHeader(context),
                
                // Contenu principal
                Expanded(
                  child: _buildContent(),
                ),
                
                // Navigation bottom
                _buildBottomNavigation(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construit le header avec titre et bouton retour
  Widget _buildHeader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
        vertical: AppConstants.paddingMedium,
      ),
      child: Column(
        children: [
          // Première ligne : Logo + Notifications + Cloche
          Row(
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
              
              // Titre Notifications
              Expanded(
                child: Text(
                  'Notifications',
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
          
          SizedBox(height: AppConstants.paddingMedium),
          
          // Deuxième ligne : Bouton Retour
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLarge,
                    vertical: AppConstants.paddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.inputBackground,
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                  ),
                  child: Text(
                    'Retour',
                    style: AppFonts.poppinsRegular(
                      fontSize: 14,
                      color: AppColors.whiteText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Construit le contenu principal
  Widget _buildContent() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête de la notification avec icône
            Row(
              children: [
                // Icône de notification (cloche orange)
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                
                SizedBox(width: AppConstants.paddingMedium),
                
                // Titre et sous-titre
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppFonts.poppinsSemiBold(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppFonts.poppinsRegular(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Heure
                Text(
                  time,
                  style: AppFonts.poppinsRegular(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: AppConstants.paddingLarge),
            
            // Contenu détaillé de la notification
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppConstants.paddingLarge),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: AppFonts.poppinsRegular(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Votre demande de retrait de récompenses ',
                        ),
                        TextSpan(
                          text: 'Bon d\'achat de 25000F',
                          style: AppFonts.poppinsBold(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const TextSpan(
                          text: ' de la catégorie executive a été validé avec succès.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Espace pour le contenu additionnel si nécessaire
            const Spacer(),
          ],
        ),
      ),
    );
  }

  /// Construit la navigation bottom
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
              _buildCenterNavItem(),
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
  Widget _buildCenterNavItem() {
    return Container(
      width: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              color: AppColors.navigationBackground,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.inactiveTab,
                width: 2,
              ),
            ),
            child: Icon(
              Icons.card_giftcard,
              color: AppColors.inactiveTab,
              size: 32,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Récompenses',
            style: AppFonts.interMedium(
              fontSize: 10,
              color: AppColors.inactiveTab,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}