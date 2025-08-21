import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/restaurant.dart';
import '../widgets/menu_item_card.dart';
import 'cart_screen.dart';
import 'menu_option_screen.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  int _cartItemCount = 0;
  final List<CartItem> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildAppBar(),
          _buildHeaderImage(),
          _buildRestaurantInfo(),
          _buildMenuTabs(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSearchMenuTab(),
                _buildPopularMenuTab(),
                _buildReviewTab(),
                _buildInfoTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        widget.restaurant.name,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share, color: AppColors.textPrimary),
          onPressed: () {},
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined,
                  color: AppColors.textPrimary),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
            ),
            if (_cartItemCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.accentRed,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '$_cartItemCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.favorite_border, color: AppColors.textPrimary),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert, color: AppColors.textPrimary),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          // 배경 이미지 (실제로는 이미지 에셋 사용)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryLight],
              ),
            ),
          ),
          // 로고
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.restaurant,
                color: AppColors.primary,
                size: 30,
              ),
            ),
          ),
          // 함께주문 버튼
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '함께주문',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 배민클럽 배지
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.baeminClub,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '배민클럽 무료배달',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 12),
          // 가게명
          Text(
            widget.restaurant.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          // 별점
          Row(
            children: [
              Icon(Icons.star, color: AppColors.rating, size: 20),
              SizedBox(width: 4),
              Text(
                '${widget.restaurant.rating}(${widget.restaurant.reviewCount}) >',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // 배달/픽업 탭
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '배달',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '픽업 7~17분',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // 배달 정보
          _buildDeliveryInfo(),
          SizedBox(height: 12),
          // 할인 배너
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accentPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: AppColors.accentPurple.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.flash_on, color: AppColors.accentPurple, size: 20),
                SizedBox(width: 8),
                Text(
                  '1,000원 즉시할인 적용됨',
                  style: TextStyle(
                    color: AppColors.accentPurple,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios,
                    color: AppColors.accentPurple, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '최소주문',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            Spacer(),
            Text(
              widget.restaurant.minOrder.replaceAll('최소주문 ', ''),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.home, color: AppColors.freeDelivery, size: 16),
            SizedBox(width: 4),
            Text(
              '한집배달',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '${widget.restaurant.deliveryTime} 가장 저렴해요',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.local_shipping, color: AppColors.freeDelivery, size: 16),
            SizedBox(width: 4),
            Text(
              '무료배달',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.freeDelivery,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '3,700원',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuTabs() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.textPrimary,
        indicatorWeight: 2,
        tabs: [
          Tab(icon: Icon(Icons.search), text: ''),
          Tab(text: '검색한 메뉴'),
          Tab(text: '인기 메뉴'),
          Tab(text: '후기약속'),
        ],
      ),
    );
  }

  Widget _buildSearchMenuTab() {
    return _buildMenuList(widget.restaurant.categories.first.items);
  }

  Widget _buildPopularMenuTab() {
    return _buildMenuList(widget.restaurant.categories.first.items
        .where((item) => item.isPopular)
        .toList());
  }

  Widget _buildReviewTab() {
    return Center(
      child: Text('후기 탭'),
    );
  }

  Widget _buildInfoTab() {
    return Center(
      child: Text('정보 탭'),
    );
  }

  Widget _buildMenuList(List<MenuItem> items) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return MenuItemCard(
          menuItem: items[index],
          onAddToCart: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MenuOptionScreen(menuItem: items[index]),
              ),
            );
            if (result is CartItem) {
              setState(() {
                _cartItems.add(result);
                _cartItemCount =
                    _cartItems.fold(0, (sum, it) => sum + it.quantity);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('장바구니에 담겼습니다.')),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      _cartItems.isEmpty
                          ? '0원'
                          : '${_cartItems.map((e) => (e.menuItem.price * e.quantity)).reduce((a, b) => a + b).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}원',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Text(
                  '장바구니에 담긴 수량: $_cartItemCount개',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    initialItems: _cartItems,
                    restaurant: widget.restaurant,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.baeminMint,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_cart, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  '$_cartItemCount 장바구니 보기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
