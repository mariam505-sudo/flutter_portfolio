import 'package:flutter/material.dart';

/// نقاط الكسر (breakpoints) اللي بنبني عليها الـ layout المتجاوب.
class Breakpoints {
  static const double mobile = 700;
  static const double tablet = 1000;
}

enum ScreenSize { mobile, tablet, desktop }

class Responsive {
  static ScreenSize of(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < Breakpoints.mobile) return ScreenSize.mobile;
    if (width < Breakpoints.tablet) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  static bool isMobile(BuildContext context) => of(context) == ScreenSize.mobile;
  static bool isDesktop(BuildContext context) => of(context) == ScreenSize.desktop;

  /// أقصى عرض لمحتوى القسم عشان السطور متطولش أكتر من اللازم على الشاشات الكبيرة.
  static double contentMaxWidth(BuildContext context) {
    final size = of(context);
    switch (size) {
      case ScreenSize.mobile:
        return double.infinity;
      case ScreenSize.tablet:
        return 680;
      case ScreenSize.desktop:
        return 760;
    }
  }

  static EdgeInsets pagePadding(BuildContext context) {
    final size = of(context);
    switch (size) {
      case ScreenSize.mobile:
        return const EdgeInsets.symmetric(horizontal: 20);
      case ScreenSize.tablet:
        return const EdgeInsets.symmetric(horizontal: 48);
      case ScreenSize.desktop:
        return const EdgeInsets.symmetric(horizontal: 64);
    }
  }
}
