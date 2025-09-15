import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class QuickAccess extends StatelessWidget {
  const QuickAccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '마트·편의점',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildQuickAccessItem('B마트', 'asset/img/bmart.png',
                    AppColors.accentGreen, '배민클럽'),
                SizedBox(width: 12),
                _buildQuickAccessItem('emart everyday', 'asset/img/emart.png',
                    AppColors.rating, '배민클럽'),
                SizedBox(width: 12),
                _buildQuickAccessItem(
                    'GS25', 'asset/img/gs25.png', AppColors.accentBlue, '배민클럽'),
                SizedBox(width: 12),
                _buildQuickAccessItem(
                    'emart', 'asset/img/emart.png', AppColors.rating, '무료배달'),
                SizedBox(width: 12),
                _buildQuickAccessItem('GS 더프레시', 'asset/img/gsfresh.png',
                    AppColors.accentGreen, ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessItem(
      String name, String imagePath, Color color, String badge) {
    return InkWell(
      onTap: () {
        // 마트/편의점 선택 시 처리
      },
      child: Container(
        width: 120,
        height: badge.isNotEmpty ? 90 : 80, // 배지가 있으면 높이를 늘림
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 배경 그라데이션
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color, color.withOpacity(0.8)],
                ),
              ),
            ),
            // 내용
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (badge.isNotEmpty) ...[
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
