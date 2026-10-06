import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// عنوان القسم: تاج صغير بخط مونو (زي تعليقات الكود) + عنوان رئيسي.
/// مفيش استخدام لـ ALL CAPS ولا أرقام تسلسل، لأن الأقسام مش خطوات متتالية.
class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.accentGold : AppColors.accentRust;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 18,
              height: 2,
              color: accent,
            ),
            const SizedBox(width: 10),
            Text(
              tag,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: accent,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          SizedBox(
            width: 520,
            child: Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
        const SizedBox(height: 36),
      ],
    );
  }
}
