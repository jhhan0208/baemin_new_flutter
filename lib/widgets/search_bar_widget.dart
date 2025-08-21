import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../screens/search_screen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: '음식점, 메뉴를 검색해보세요',
            hintStyle: TextStyle(
              color: AppColors.textMuted,
              fontSize: 16,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.textMuted,
              size: 24,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
            );
          },
          readOnly: true,
        ),
      ),
    );
  }
}
