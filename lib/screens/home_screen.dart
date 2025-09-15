import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/address_data.dart';
import '../widgets/address_banner.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/service_tabs.dart';
import '../widgets/category_grid.dart';
import '../widgets/quick_access.dart';
import 'address_setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    AddressBanner(),
                    SizedBox(height: 16),
                    SearchBarWidget(),
                    SizedBox(height: 16),
                    ServiceTabs(),
                    SizedBox(height: 24),
                    CategoryGrid(),
                    SizedBox(height: 24),
                    QuickAccess(),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: AppColors.baeminMint,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(child: _buildAddressButton()),
          const SizedBox(width: 16),
          _buildAppBarActions(),
        ],
      ),
    );
  }

  Widget _buildAddressButton() {
    // 주소는 잘 읽힌다고 하셔서 그대로 '주소 + 안내'를 label 로 유지
    return Semantics(
      label: '${AddressData.getCurrentAddressTitle()}, 두번 눌러서 주소 변경',
      button: true,
      excludeSemantics: true, // 기본 시맨틱스 제거하고 위 라벨만 읽히게
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddressSettingScreen()),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on, color: Colors.white, size: 20),
            const SizedBox(width: 4),
            Expanded(
              child: ExcludeSemantics(
                // 텍스트 자체 시맨틱스 제외 (위 라벨만 읽힘)
                child: Text(
                  AddressData.getCurrentAddressTitle(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down,
                color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarActions() {
    return Row(
      children: [
        // 알림 아이콘 버튼 (읽히도록 excludeSemantics 적용)
        Semantics(
          label: '알림 아이콘',
          button: true,
          excludeSemantics: true,
          child: ExcludeSemantics(
            child: IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: Colors.white, size: 24),
              onPressed: () => _showSnackBar('알림 기능'),
              tooltip: '알림 아이콘', // 보너스: 길게 눌렀을 때 툴팁도 제공
            ),
          ),
        ),

        // 장바구니 아이콘 버튼 (배지와 Stack 때문에 더 깔끔하게 제어)
        Semantics(
          label: '장바구니 아이콘',
          // 필요하면 hint로 개수도 함께: hint: '담긴 항목 1개',
          button: true,
          excludeSemantics: true,
          child: Stack(
            children: [
              ExcludeSemantics(
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined,
                      color: Colors.white, size: 24),
                  onPressed: () => _showSnackBar('장바구니'),
                  tooltip: '장바구니 아이콘',
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: ExcludeSemantics(
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.accentRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.baeminMint,
      ),
    );
  }
}
