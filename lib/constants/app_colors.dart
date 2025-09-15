import 'package:flutter/material.dart';

class AppColors {
  // Baemin Brand Colors
  static const Color baeminMint = Color(0xFF2AC1BC); // 메인 민트
  static const Color darkMint = Color(0xFF22A29E); // 다크 민트
  static const Color lightMint = Color(0xFFA4E7E3); // 라이트 민트

  static const Color baeminBlack = Color(0xFF222222); // 본문 텍스트
  static const Color baeminGray = Color(0xFF767676); // 보조 텍스트
  static const Color lightGray = Color(0xFFF6F6F6); // 카드/섹션 배경
  static const Color white = Color(0xFFFFFFFF);

  static const Color baeminRed = Color(0xFFFF3C3C); // 경고/에러
  static const Color baeminYellow = Color(0xFFFFD400); // 쿠폰/이벤트

  // Backward-compatible aliases used throughout the app
  static const Color primary = baeminMint;
  static const Color primaryLight = lightMint;
  static const Color primaryDark = darkMint;

  static const Color background = lightGray;
  static const Color cardBackground = white;
  static const Color surfaceBackground = white;

  static const Color textPrimary = baeminBlack;
  static const Color textSecondary = baeminGray;
  static const Color textLight = white;
  static const Color textMuted = Color(0xFFBDC3C7);

  static const Color accentRed = baeminRed;
  static const Color accentBlue = Color(0xFF3498DB);
  static const Color accentGreen = Color(0xFF27AE60);
  static const Color accentOrange = Color(0xFFE67E22);
  static const Color accentPurple = Color(0xFF9B59B6);
  static const Color accentTeal = baeminMint;

  static const Color borderLight = Color(0xFFECF0F1);
  static const Color borderMedium = Color(0xFFBDC3C7);
  static const Color borderDark = Color(0xFF95A5A6);

  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = baeminRed;
  static const Color info = Color(0xFF3498DB);

  static const Color deliveryFee = baeminRed;
  static const Color rating = Color(0xFFFFC107);
  static const Color discount = baeminRed;
  static const Color coupon = accentPurple;
  static const Color freeDelivery = Color(0xFF27AE60);
  static const Color baeminClub = baeminMint;
}
