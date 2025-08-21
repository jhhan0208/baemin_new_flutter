import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/restaurant.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;
  final VoidCallback onAddToCart;

  const MenuItemCard({
    Key? key,
    required this.menuItem,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 메뉴 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 배지들
                if (menuItem.badges.isNotEmpty)
                  Wrap(
                    spacing: 4,
                    children: menuItem.badges
                        .map((badge) => _buildBadge(badge))
                        .toList(),
                  ),
                if (menuItem.badges.isNotEmpty) SizedBox(height: 8),
                // 메뉴명
                Text(
                  menuItem.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                // 설명
                if (menuItem.description.isNotEmpty)
                  Text(
                    menuItem.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                SizedBox(height: 8),
                // 가격과 리뷰
                Row(
                  children: [
                    Text(
                      '${menuItem.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '리뷰 ${menuItem.reviewCount}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          // 메뉴 이미지와 추가 버튼
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.surfaceBackground,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    menuItem.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.surfaceBackground,
                        child: Icon(
                          Icons.restaurant,
                          color: AppColors.textMuted,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // 추가 버튼
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onAddToCart,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.add,
                      color: AppColors.baeminMint,
                      size: 20,
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

  Widget _buildBadge(String badge) {
    Color badgeColor;
    switch (badge) {
      case '인기 1위':
      case '인기 2위':
      case '인기 3위':
      case '인기 4위':
        badgeColor = AppColors.accentRed;
        break;
      case '사장님 추천':
        badgeColor = AppColors.primary;
        break;
      case '한정판매':
        badgeColor = AppColors.accentOrange;
        break;
      case '신메뉴':
        badgeColor = AppColors.accentBlue;
        break;
      case '베스트':
        badgeColor = AppColors.accentGreen;
        break;
      case '다이어트':
        badgeColor = AppColors.accentPurple;
        break;
      case '비건':
        badgeColor = AppColors.accentGreen;
        break;
      case '시즌메뉴':
        badgeColor = AppColors.accentOrange;
        break;
      default:
        badgeColor = AppColors.textSecondary;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: badgeColor.withOpacity(0.3)),
      ),
      child: Text(
        badge,
        style: TextStyle(
          color: badgeColor,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
