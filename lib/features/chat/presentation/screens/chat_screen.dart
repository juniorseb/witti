import 'package:flutter/material.dart';

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_constants.dart';

/// Écran de chat
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Liste des messages
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Bonjour monsieur Jean Aqua, j\'espère que vous allez bien.\nComment puis je vous aider aujourd\'hui ?',
      isFromUser: false,
      time: '08:35 AM',
      isToday: true,
    ),
    ChatMessage(
      text: 'Comment avoir plus de jetons',
      isFromUser: true,
      time: '08:31 AM',
      isToday: true,
    ),
    ChatMessage(
      text: 'Pour avoir plus de jetons, il le faut faire des dépôts sur MyfiDance dont le montant minimum est de 5000 jetons',
      isFromUser: false,
      time: '08:32 AM',
      isToday: true,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Envoie un message
  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: _messageController.text.trim(),
            isFromUser: true,
            time: _getCurrentTime(),
            isToday: true,
          ),
        );
      });
      _messageController.clear();
      _scrollToBottom();
    }
  }

  /// Fait défiler vers le bas
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Obtient l'heure actuelle formatée
  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute AM';
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
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Zone de messages
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/ad_bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.borderRadiusLarge),
                      topRight: Radius.circular(AppConstants.borderRadiusLarge),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.borderRadiusLarge),
                      topRight: Radius.circular(AppConstants.borderRadiusLarge),
                    ),
                    child: Column(
                      children: [
                        // Indicateur "Aujourd'hui"
                        _buildDateIndicator(),
                        
                        // Liste des messages
                        Expanded(
                          child: _buildMessagesList(),
                        ),
                        
                        // Champ de saisie
                        _buildMessageInput(),
                      ],
                    ),
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
          
          // Titre Chat
          Expanded(
            child: Text(
              'Chat',
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

  /// Construit l'indicateur de date
  Widget _buildDateIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          'Aujourd\'hui',
          style: AppFonts.poppinsRegular(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// Construit la liste des messages
  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  /// Construit une bulle de message
  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: EdgeInsets.only(bottom: AppConstants.paddingMedium),
      child: Row(
        mainAxisAlignment: message.isFromUser 
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isFromUser) ...[
            // Avatar du support
            Container(
              width: 32,
              height: 32,
              margin: EdgeInsets.only(right: AppConstants.paddingSmall),
              decoration: BoxDecoration(
                color: AppColors.goldenBorder,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.support_agent,
                size: 20,
                color: AppColors.startButtonText,
              ),
            ),
          ],
          
          // Bulle de message
          Flexible(
            child: Column(
              crossAxisAlignment: message.isFromUser 
                  ? CrossAxisAlignment.end 
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(AppConstants.paddingMedium),
                  decoration: BoxDecoration(
                    color: message.isFromUser 
                        ? AppColors.goldenBorder 
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                  ),
                  child: Text(
                    message.text,
                    style: AppFonts.poppinsRegular(
                      fontSize: 14,
                      color: message.isFromUser 
                          ? AppColors.startButtonText 
                          : Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
                
                SizedBox(height: 4),
                
                // Heure
                Text(
                  message.time,
                  style: AppFonts.poppinsRegular(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          
          if (message.isFromUser) ...[
            SizedBox(width: AppConstants.paddingSmall),
            // Avatar de l'utilisateur
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.categoryStarBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Construit le champ de saisie
  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          // Icône appareil photo
          GestureDetector(
            onTap: () {
              // TODO: Fonctionnalité d'appareil photo
            },
            child: Container(
              padding: EdgeInsets.all(AppConstants.paddingSmall),
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey.shade600,
                size: 24,
              ),
            ),
          ),
          
          SizedBox(width: AppConstants.paddingSmall),
          
          // Champ de texte
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Write a comment',
                  hintStyle: AppFonts.poppinsRegular(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingMedium,
                    vertical: AppConstants.paddingSmall,
                  ),
                ),
                style: AppFonts.poppinsRegular(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                onSubmitted: (value) => _sendMessage(),
              ),
            ),
          ),
          
          SizedBox(width: AppConstants.paddingSmall),
          
          // Bouton envoyer
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: EdgeInsets.all(AppConstants.paddingSmall),
              child: Icon(
                Icons.send,
                color: AppColors.goldenBorder,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Construit la navigation bottom avec chat sélectionné
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
              _buildNavItem(Icons.chat, 'Chat', true), // Chat sélectionné
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

/// Modèle pour un message de chat
class ChatMessage {
  final String text;
  final bool isFromUser;
  final String time;
  final bool isToday;

  ChatMessage({
    required this.text,
    required this.isFromUser,
    required this.time,
    required this.isToday,
  });
}