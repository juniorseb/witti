import 'package:flutter/material.dart';
import 'dart:math' as math;

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_constants.dart';

/// Écran d'historique des transactions
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Index du filtre sélectionné
  int _selectedFilterIndex = 1; // "Ce mois" par défaut
  
  // Dates sélectionnées pour le filtre personnalisé
  DateTimeRange? _selectedDateRange;
  
  // Liste des filtres
  final List<String> _filters = [
    'Cette semaine',
    'Ce mois',
    'Personnalisé',
  ];

  // Données des transactions
  final List<TransactionHistoryItem> _transactions = [
    TransactionHistoryItem(
      type: 'Retrait',
      amount: '- 100 000F',
      isPositive: false,
    ),
    TransactionHistoryItem(
      type: 'Depot',
      amount: '+ 2 000 000F',
      isPositive: true,
    ),
    TransactionHistoryItem(
      type: 'Depot',
      amount: '+ 2 000 000F',
      isPositive: true,
    ),
    TransactionHistoryItem(
      type: 'Retrait',
      amount: '- 100 000F',
      isPositive: false,
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
              
              // Contenu principal avec scroll
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
                  child: Column(
                    children: [
                      SizedBox(height: AppConstants.paddingMedium),
                      
                      // Card Tendance des transactions
                      _buildTrendsCard(),
                      
                      SizedBox(height: AppConstants.paddingLarge),
                      
                      // Filtres
                      _buildFilters(),
                      
                      SizedBox(height: AppConstants.paddingLarge),
                      
                      // Liste des transactions
                      _buildTransactionsList(),
                      
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
          
          // Titre Historique
          Expanded(
            child: Text(
              'Historique',
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

  /// Construit la card des tendances
  Widget _buildTrendsCard() {
    return Container(
      padding: EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.trendsBlockBackground,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre
          Text(
            'Tendance des transactions',
            style: AppFonts.poppinsBold(
              fontSize: 16,
              color: AppColors.trendsTitle,
            ),
          ),
          
          SizedBox(height: AppConstants.paddingLarge),
          
          // Graphique circulaire et légende
          Row(
            children: [
              // Graphique circulaire
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 120,
                  child: CustomPaint(
                    painter: DonutChartPainter(),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Mars 2025',
                            style: AppFonts.robotoRegular(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(width: AppConstants.paddingLarge),
              
              // Légende
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dépôts
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: AppColors.depositColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: AppConstants.paddingSmall),
                        Text(
                          'Dépôts',
                          style: AppFonts.poppinsRegular(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '85%',
                          style: AppFonts.interExtraBold(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.paddingSmall),
                    
                    // Retraits
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: AppColors.withdrawColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: AppConstants.paddingSmall),
                        Text(
                          'Retraits',
                          style: AppFonts.poppinsRegular(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '15%',
                          style: AppFonts.interExtraBold(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Construit les filtres avec calendrier personnalisé
  Widget _buildFilters() {
    return Column(
      children: [
        // Boutons de filtres
        Row(
          children: List.generate(_filters.length, (index) {
            final isSelected = index == _selectedFilterIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () async {
                  if (index == 2) { // Personnalisé
                    await _showDateRangePicker();
                  } else {
                    setState(() {
                      _selectedFilterIndex = index;
                      _selectedDateRange = null; // Reset la période personnalisée
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  padding: EdgeInsets.symmetric(
                    vertical: AppConstants.paddingMedium,
                    horizontal: AppConstants.paddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? AppColors.activeFilterBackground 
                        : AppColors.inactiveFilterBackground,
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                    border: isSelected 
                        ? null 
                        : Border.all(color: AppColors.inactiveFilterBorder),
                  ),
                  child: Text(
                    _filters[index],
                    style: AppFonts.robotoBold(
                      fontSize: 12,
                      color: isSelected 
                          ? AppColors.activeFilterText 
                          : AppColors.inactiveFilterText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }),
        ),
        
        // Affichage de la période sélectionnée si personnalisé
        if (_selectedFilterIndex == 2 && _selectedDateRange != null)
          Container(
            margin: EdgeInsets.only(top: AppConstants.paddingMedium),
            padding: EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
              border: Border.all(color: AppColors.goldenBorder, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.goldenBorder,
                ),
                SizedBox(width: AppConstants.paddingSmall),
                Text(
                  '${_formatDate(_selectedDateRange!.start)} - ${_formatDate(_selectedDateRange!.end)}',
                  style: AppFonts.poppinsSemiBold(
                    fontSize: 12,
                    color: AppColors.goldenBorder,
                  ),
                ),
                SizedBox(width: AppConstants.paddingSmall),
                GestureDetector(
                  onTap: _showDateRangePicker,
                  child: Icon(
                    Icons.edit,
                    size: 16,
                    color: AppColors.goldenBorder,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// Affiche le sélecteur de période personnalisée
  Future<void> _showDateRangePicker() async {
    final DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange ?? DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 30)),
        end: DateTime.now(),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.goldenBorder, // Couleur principale
              onPrimary: AppColors.startButtonText, // Texte sur la couleur principale
              surface: Colors.white, // Fond du calendrier
              onSurface: Colors.black87, // Texte sur le fond
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedRange != null) {
      setState(() {
        _selectedDateRange = pickedRange;
        _selectedFilterIndex = 2; // Sélectionner "Personnalisé"
      });
    }
  }

  /// Formate une date pour l'affichage
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  /// Construit la liste des transactions
  Widget _buildTransactionsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      child: Column(
        children: List.generate(_transactions.length * 2 - 1, (index) {
          if (index.isOdd) {
            // Séparateur
            return Container(
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
              color: AppColors.transactionSeparator,
            );
          } else {
            // Transaction
            final transactionIndex = index ~/ 2;
            final transaction = _transactions[transactionIndex];
            return _buildTransactionItem(transaction);
          }
        }),
      ),
    );
  }

  /// Construit un élément de transaction
  Widget _buildTransactionItem(TransactionHistoryItem transaction) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      child: Row(
        children: [
          // Icône
          Container(
            padding: EdgeInsets.all(AppConstants.paddingSmall),
            decoration: BoxDecoration(
              color: transaction.isPositive 
                  ? AppColors.depositColor 
                  : AppColors.withdrawColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              transaction.isPositive 
                  ? Icons.arrow_upward 
                  : Icons.arrow_downward,
              color: AppColors.whiteText,
              size: 16,
            ),
          ),
          
          SizedBox(width: AppConstants.paddingMedium),
          
          // Type de transaction
          Expanded(
            child: Text(
              transaction.type,
              style: AppFonts.poppinsMedium(
                fontSize: 14,
                color: AppColors.depositWithdrawText,
              ),
            ),
          ),
          
          // Montant
          Text(
            transaction.amount,
            style: AppFonts.robotoMedium(
              fontSize: 14,
              color: AppColors.depositWithdrawText,
            ),
          ),
        ],
      ),
    );
  }

  /// Construit la navigation bottom avec historique sélectionné
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
              _buildNavItem(Icons.history, 'Historique', true), // Sélectionné
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

/// Modèle pour les éléments de transaction
class TransactionHistoryItem {
  final String type;
  final String amount;
  final bool isPositive;

  TransactionHistoryItem({
    required this.type,
    required this.amount,
    required this.isPositive,
  });
}

/// Painter pour le graphique en donut
class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const center = Offset(60, 60);
    const radius = 50.0;
    const strokeWidth = 20.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Dépôts 85% (vert)
    paint.color = AppColors.depositColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start à 12h
      2 * math.pi * 0.85, // 85% du cercle
      false,
      paint,
    );

    // Retraits 15% (rouge)
    paint.color = AppColors.withdrawColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2 + 2 * math.pi * 0.85, // Start après les dépôts
      2 * math.pi * 0.15, // 15% du cercle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}