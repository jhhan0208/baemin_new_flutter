import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/restaurant.dart';
import '../widgets/cart_item_card.dart';
import '../data/restaurant_data.dart';
import 'order_screen.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem>? initialItems;
  final Restaurant? restaurant;
  const CartScreen({Key? key, this.initialItems, this.restaurant})
      : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late Restaurant _selectedRestaurant;
  late List<CartItem> _cartItems;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _selectedRestaurant =
        widget.restaurant ?? RestaurantData.getRestaurants().first;
    _cartItems = (widget.initialItems != null &&
            widget.initialItems!.isNotEmpty)
        ? widget.initialItems!
            .map((e) => CartItem(
                menuItem: e.menuItem,
                quantity: e.quantity,
                selectedOptions: Map.of(e.selectedOptions)))
            .toList()
        : [
            CartItem(
              menuItem: MenuItem(
                id: '4-5',
                name: '[무조건]아메리카노',
                description: '깊고 진한 에스프레소의 맛을 그대로 느낄 수 있는 클래식 아메리카노',
                price: 3500,
                reviewCount: 45,
                imageUrl: 'assets/img/americano.jpg',
                badges: ['베스트'],
                options: [],
              ),
              quantity: 2,
              selectedOptions: {
                'ICE/HOT': 'ICE',
                '뚜껑 선택': '기본 뚜껑 (기본)',
              },
            ),
            CartItem(
              menuItem: MenuItem(
                id: '4-1',
                name: '신선도100% 포케 샐러드',
                description: '가장 기본적인 것이 가장 아름답다 고로, 이것은 읍천리만의 손색없는 시그니처 메뉴',
                price: 9900,
                reviewCount: 9,
                imageUrl: 'assets/img/fresh_poke.jpg',
                badges: ['사장님 추천'],
                options: [],
              ),
              quantity: 1,
              selectedOptions: {
                '토핑 택1': '현미밥',
                '소스 택1': '랜치 드레싱 (연어 / 오리훈제 조합)',
              },
            ),
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          _buildStoreInfo(),
          _buildDiscountBanner(),
          Expanded(
            child: _buildCartItems(),
          ),
          _buildRecommendations(),
          _buildDeliveryOptions(),
          _buildOrderSummary(),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        '장바구니',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.person_add, color: AppColors.textPrimary),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.textPrimary,
        indicatorWeight: 2,
        tabs: [
          Tab(text: '배달·픽업 ${_cartItems.length}'),
          Tab(text: '장보기·쇼핑'),
          Tab(text: '전국특가'),
        ],
      ),
    );
  }

  Widget _buildStoreInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.restaurant,
              color: AppColors.textMuted,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              _selectedRestaurant.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: AppColors.textMuted, size: 16),
        ],
      ),
    );
  }

  Widget _buildDiscountBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.accentPurple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.accentPurple.withOpacity(0.3)),
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
    );
  }

  Widget _buildCartItems() {
    if (_cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppColors.textMuted,
            ),
            SizedBox(height: 16),
            Text(
              '장바구니가 비어있습니다',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '맛있는 메뉴를 담아보세요!',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textMuted,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.baeminMint,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('메뉴 보러가기'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _cartItems.length,
      itemBuilder: (context, index) {
        return CartItemCard(
          cartItem: _cartItems[index],
          onQuantityChanged: (quantity) {
            setState(() {
              if (quantity <= 0) {
                _cartItems.removeAt(index);
              } else {
                _cartItems[index].quantity = quantity;
              }
            });
          },
          onRemove: () {
            setState(() {
              _cartItems.removeAt(index);
            });
          },
        );
      },
    );
  }

  Widget _buildRecommendations() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '함께 먹으면 좋아요',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildRecommendationItem('[판매율 1위] 미숫가루', '4,700원~'),
              SizedBox(width: 12),
              _buildRecommendationItem('[로맨틱한] 바닐라빈라떼', '4,900원~'),
              SizedBox(width: 12),
              _buildRecommendationItem('[부드러운]카페라떼', '4,000원~'),
            ],
          ),
          SizedBox(height: 12),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                '더보기',
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

  Widget _buildRecommendationItem(String name, String price) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '추가',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '수령 방법을 선택해주세요',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12),
          _buildDeliveryOption('알뜰배달', '18~33분', '2,700원 무료', true),
          _buildDeliveryOption('한집배달', '16~26분', '3,700원 무료', false, true),
          _buildDeliveryOption('가게배달', '29~44분', '2,500원'),
          _buildDeliveryOption('픽업', '7~17분 후 픽업', '무료'),
          _buildDeliveryOption('매장', '7~17분 후 방문', '무료'),
        ],
      ),
    );
  }

  Widget _buildDeliveryOption(String name, String time, String fee,
      [bool isCheapest = false, bool isSelected = false]) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (isCheapest) ...[
                      SizedBox(width: 8),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.accentGreen,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '가장 저렴',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (isSelected) ...[
                  SizedBox(height: 4),
                  Text(
                    '가장 저렴한 금액, 가장 빠른 도착, 실시간 위치 확인',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            fee,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: fee.contains('무료')
                  ? AppColors.freeDelivery
                  : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    final subtotal = _cartItems.fold<int>(
        0, (sum, item) => sum + (item.menuItem.price * item.quantity));
    final deliveryFee = 3700;
    final discount = 4700;
    final finalTotal = subtotal + deliveryFee - discount;

    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('메뉴 금액'),
              Text(
                  '${subtotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('배달팁'),
              Text(
                  '${deliveryFee.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('배민클럽 할인'),
              Text(
                  '-${discount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                  style: TextStyle(color: AppColors.freeDelivery)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '결제예정금액',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${finalTotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accentTeal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.local_shipping,
                    color: AppColors.accentTeal, size: 16),
                SizedBox(width: 8),
                Text(
                  '무료배달! 배민클럽 포함 4,700원 할인',
                  style: TextStyle(
                    color: AppColors.accentTeal,
                    fontSize: 14,
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

  Widget _buildBottomBar() {
    final subtotal = _cartItems.fold<int>(
        0, (sum, item) => sum + (item.menuItem.price * item.quantity));
    final deliveryFee = 3700;
    final discount = 4700;
    final finalTotal = subtotal + deliveryFee - discount;

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
                      '${finalTotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${(finalTotal + 4700).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Text(
                  '주문 가능',
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
                  builder: (context) => OrderScreen(
                    cartItems: _cartItems,
                    restaurant: _selectedRestaurant,
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
            child: Text(
              '한집배달 주문하기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
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
