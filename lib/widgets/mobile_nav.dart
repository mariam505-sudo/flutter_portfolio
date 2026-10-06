import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';
import 'nav_item.dart';

/// AppBar بسيط للموبايل، بيفتح Drawer فيه روابط الأقسام + تبديل الثيم.
class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const MobileAppBar({super.key, required this.isDark, required this.onToggleTheme});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final accent = isDark ? AppColors.accentGold : AppColors.accentRust;
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Text(
        PortfolioData.name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: [
        IconButton(
          onPressed: onToggleTheme,
          icon: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            color: accent,
          ),
        ),
      ],
    );
  }
}

class MobileNavDrawer extends StatelessWidget {
  final List<NavItem> items;
  final void Function(NavItem item) onTap;

  const MobileNavDrawer({super.key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.accentGold : AppColors.accentRust;

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          children: [
            Text(PortfolioData.role, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 32),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    onTap(item);
                  },
                  child: Row(
                    children: [
                      Container(width: 7, height: 7, color: accent),
                      const SizedBox(width: 12),
                      Text(item.label, style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
