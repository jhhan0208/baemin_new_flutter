import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CommonWidgets {
  // 재사용 가능한 카드 위젯
  static Widget buildServiceCard({
    required String title,
    required String subtitle1,
    required String subtitle2,
    required IconData icon,
    required VoidCallback onTap,
    double width = 180,
    double height = 200,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 10.0,
                  bottom: 5.0,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  subtitle1,
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  subtitle2,
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 100.0,
                  top: 10.0,
                ),
                child: Icon(
                  icon,
                  size: 70,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 재사용 가능한 메뉴 카드 위젯
  static Widget buildMenuCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
    double width = 120.0,
    double height = 100.0,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 17),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: iconColor,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 재사용 가능한 하단 메뉴 카드 위젯
  static Widget buildBottomMenuCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? Radius.circular(30) : Radius.zero,
          bottomLeft: isFirst ? Radius.circular(30) : Radius.zero,
          topRight: isLast ? Radius.circular(30) : Radius.zero,
          bottomRight: isLast ? Radius.circular(30) : Radius.zero,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.zero,
          width: 90.0,
          height: 100.0,
          constraints: BoxConstraints(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: AppColors.primary,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
