import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AddressBanner extends StatefulWidget {
  const AddressBanner({Key? key}) : super(key: key);

  @override
  State<AddressBanner> createState() => _AddressBannerState();
}

class _AddressBannerState extends State<AddressBanner> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightMint.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.baeminMint.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.baeminMint,
            size: 20,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '잠깐! 이 주소가 맞나요?',
              style: TextStyle(
                color: AppColors.baeminMint,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() => _dismissed = true);
            },
            child: Text(
              '확인하기',
              style: TextStyle(
                color: AppColors.baeminMint,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
