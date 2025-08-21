import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/restaurant.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    Key? key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 메뉴 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 메뉴명
                    Text(
                      cartItem.menuItem.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    // 가격
                    Text(
                      '가격 : ${cartItem.menuItem.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8),
                    // 선택된 옵션들
                    ...cartItem.selectedOptions.entries.map(
                      (entry) => Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          '${entry.key} : ${entry.value}',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    // 총 가격
                    Text(
                      '${(cartItem.menuItem.price * cartItem.quantity).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              // 메뉴 이미지
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.surfaceBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    cartItem.menuItem.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.surfaceBackground,
                        child: Icon(
                          Icons.restaurant,
                          color: AppColors.textMuted,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // 액션 버튼들
          Row(
            children: [
              TextButton(
                onPressed: () {
                  // 옵션 변경 페이지로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('옵션 변경 기능은 준비 중입니다.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  '옵션 변경',
                  style: TextStyle(
                    color: AppColors.baeminMint,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              // 수량 조절
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (cartItem.quantity > 1) {
                        onQuantityChanged(cartItem.quantity - 1);
                      } else {
                        onRemove();
                      }
                    },
                    icon: Icon(
                      cartItem.quantity > 1 ? Icons.remove : Icons.delete,
                      color: cartItem.quantity > 1
                          ? AppColors.textSecondary
                          : AppColors.accentRed,
                      size: 20,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      '${cartItem.quantity}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      onQuantityChanged(cartItem.quantity + 1);
                    },
                    icon: Icon(
                      Icons.add,
                      color: AppColors.baeminMint,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
