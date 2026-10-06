import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'nav_item.dart';

/// شريط تنقل جانبي رفيع: خط رأسي واصل ونقاط لكل قسم، زي هامش ورقة مخططات.
/// دوسة على أي عنصر بتعمل scroll لطيف للسكشن بتاعه.
class NavRail extends StatelessWidget {
  final List<NavItem> items;
  final void Function(NavItem item) onTap;
  final VoidCallback onToggleTheme;
  final bool isDark;

  const NavRail({
    super.key,
    required this.items,
    required this.onTap,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final accent = isDark ? AppColors.accentGold : AppColors.accentRust;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final secondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(items.length, (i) {
                final item = items[i];
                final isLastItem = i == items.length - 1;
                return InkWell(
                  onTap: () => onTap(item),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                margin: const EdgeInsets.only(top: 6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: accent,
                                ),
                              ),
                              if (!isLastItem)
                                Expanded(child: Container(width: 1, color: divider)),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24, top: 1),
                            child: Text(
                              item.label,
                              style: textTheme.bodySmall?.copyWith(color: secondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onToggleTheme,
            child: Row(
              children: [
                Icon(
                  isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  size: 16,
                  color: secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  isDark ? 'light mode' : 'dark mode',
                  style: textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
