import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../screens/search_screen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        // 핵심: Semantics로 기본 시맨틱스 제거 + 우리가 정한 label/hint만 읽히게
        child: Semantics(
          label: '메뉴 검색창', // 1) 먼저 읽힘
          hint: '사용자님, 서브웨이 어때요?', // 2) 다음에 읽힘
          textField: true,
          focusable: true,
          excludeSemantics: true,
          child: ExcludeSemantics(
            child: TextField(
              decoration: InputDecoration(
                hintText: '사용자님, 서브웨이 어때요?',
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              readOnly: true,
            ),
          ),
        ),
      ),
    );
  }
}
