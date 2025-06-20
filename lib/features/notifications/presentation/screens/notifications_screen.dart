import 'package:flutter/material.dart';

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_constants.dart';

// Navigation vers l'écran de détail
import 'notification_detail_screen.dart';

/// Écran des notifications de l'application MyWitti
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Liste des notifications
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'Validation de retrait',
      subtitle: 'Paiement bancaire',
      time: 'il y a 2min',
      isRead: false,
    ),
    NotificationItem(
      title: 'Validation de retrait',
      subtitle: 'Paiement bancaire',
      time: 'il y a 3min',
      isRead: false,
    ),
    NotificationItem(
      title: 'Validation de retrait',
      subtitle: 'Paiement bancaire',
      time: 'il y a 5min',
      isRead: false,
    ),
    NotificationItem(
      title: 'Validation de retrait',
      subtitle: 'Paiement bancaire',
      time: 'il y a 7min',
      isRead: false,
    ),
    NotificationItem(
      title: 'Validation de retrait',
      subtitle: 'Paiement bancaire',
      time: 'il y a 8min',
      isRead: false,
    ),
    NotificationItem(
      title: 'Validation de retrait',
      subtitle: 'Paiement bancaire',
      time: 'il y a 9min',
      isRead: false,
    ),
    NotificationItem(
      title: 'Validation de retrait',
      subtitle: 'Paiement bancaire',
      time: 'il y a 9min',
      isRead: false,
    ),
  ];

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
            height: MediaQuery.of(context).size.height * 0.2, // 20% en haut
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
            top: MediaQuery.of(context).size.height * 0.2, // Commence après 20%
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
                // Header avec titre et logo
                _buildHeader(),
                
                // Liste des notifications qui commence sur ad_bg
                Expanded(
                  child: _buildNotificationsList(),
                ),
                
                // Champ de commentaire en bas
                _buildCommentField(),
                
                // Navigation bottom
                _buildBottomNavigation(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construit le header avec titre et logo
  Widget _buildHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15, // Dans la zone onboarding_bg
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
        vertical: AppConstants.paddingMedium,
      ),
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
    );
  }

  /// Construit la liste des notifications
  Widget _buildNotificationsList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => Container(
          height: 1,
          margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
          color: Colors.grey.shade200,
        ),
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _buildNotificationItem(notification, index);
        },
      ),
    );
  }

  /// Construit un élément de notification avec navigation
  Widget _buildNotificationItem(NotificationItem notification, int index) {
    return GestureDetector(
      onTap: () {
        // Navigation vers le détail de la notification
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NotificationDetailScreen(
              title: notification.title,
              subtitle: notification.subtitle,
              time: notification.time,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(AppConstants.paddingMedium),
        child: Row(
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
            
            // Contenu de la notification
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: AppFonts.poppinsSemiBold(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    notification.subtitle,
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
              notification.time,
              style: AppFonts.poppinsRegular(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Construit le champ de commentaire en bas
  Widget _buildCommentField() {
    return Container(
      margin: EdgeInsets.all(AppConstants.paddingLarge),
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Icône appareil photo
          Icon(
            Icons.camera_alt,
            color: Colors.grey.shade600,
            size: 24,
          ),
          
          SizedBox(width: AppConstants.paddingMedium),
          
          // Champ de texte
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Write a comment',
                hintStyle: AppFonts.poppinsRegular(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: AppFonts.poppinsRegular(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          
          SizedBox(width: AppConstants.paddingMedium),
          
          // Icône envoyer
          Icon(
            Icons.send,
            color: Colors.grey.shade600,
            size: 24,
          ),
        ],
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

/// Modèle pour les éléments de notification
class NotificationItem {
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isRead,
  });
}