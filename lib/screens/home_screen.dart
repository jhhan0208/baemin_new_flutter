import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/address_data.dart';
import '../widgets/address_banner.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/service_tabs.dart';
import '../widgets/category_grid.dart';
import '../widgets/quick_access.dart';
import 'search_screen.dart';
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
                  children: [
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildAddressButton(),
          ),
          SizedBox(width: 16),
          _buildAppBarActions(),
        ],
      ),
    );
  }

  Widget _buildAddressButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddressSettingScreen()),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on, color: Colors.white, size: 20),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              AddressData.getCurrentAddressTitle(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20),
        ],
      ),
    );
  }

  Widget _buildAppBarActions() {
    return Row(
      children: [
        //IconButton(
        //  icon: Icon(Icons.search, color: Colors.white, size: 24),
        //  onPressed: () {
        //   Navigator.push(
        //     context,
        //      MaterialPageRoute(builder: (_) => const SearchScreen()),
        //    );
        //  },
        //),
        IconButton(
          icon:
              Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
          onPressed: () => _showSnackBar('알림 기능'),
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined,
                  color: Colors.white, size: 24),
              onPressed: () => _showSnackBar('장바구니'),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.accentRed,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  '1',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.baeminMint,
      ),
    );
  }
}
