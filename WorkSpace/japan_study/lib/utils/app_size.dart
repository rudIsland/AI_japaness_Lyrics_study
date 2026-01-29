import 'package:flutter/material.dart';

class AppSize {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;

  // 피그마 디자인 기준 사이즈 (360 x 800)
  static const double designWidth = 360.0;
  static const double designHeight = 780.0;

  void init(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;

    // 1단위당 실제 픽셀 비율 계산
    blockWidth = screenWidth / designWidth;
    blockHeight = screenHeight / designHeight;
  }
}

// 님의 취항에 맞는 '간결한' 사용법을 위한 Extension
extension SizeExtension on num {
  // 가로 비율 대응: 200.w 라고 쓰면 피그마 200px이 폰 비율에 맞춰 계산됨
  double get w => this * AppSize.blockWidth;

  // 세로 비율 대응
  double get h => this * AppSize.blockHeight;

  // 폰트 크기 대응 (가로 비율 기준)
  double get sp => this * AppSize.blockWidth;
}
