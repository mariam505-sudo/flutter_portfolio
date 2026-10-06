import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';
import '../widgets/responsive.dart';

class HeroSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const HeroSection({
    super.key,
    required this.sectionKey,
  });

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void _scrollToProjects(BuildContext context) {
    // يمكن ربطها بالـ ScrollController الخاص بالصفحة مستقبلاً
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final accent = isDark ? AppColors.accentGold : AppColors.accentRust;

    final secondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final textTheme = Theme.of(context).textTheme;
    final isMobile = Responsive.isMobile(context);

    return Container(
      key: sectionKey,
      padding: EdgeInsets.only(
        top: isMobile ? 48 : 90,
        bottom: isMobile ? 60 : 90,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _buildPhoto(accent, isMobile)),
                const SizedBox(height: 36),
                _buildContent(
                  context,
                  accent,
                  secondary,
                  textTheme,
                  isMobile,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildContent(
                    context,
                    accent,
                    secondary,
                    textTheme,
                    isMobile,
                  ),
                ),
                const SizedBox(width: 70),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: _buildPhoto(accent, isMobile),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Color accent,
    Color secondary,
    TextTheme textTheme,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Availability Status
        Row(
          children: [
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'OPEN TO FLUTTER OPPORTUNITIES',
              style: textTheme.labelMedium?.copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        Text(
          "HELLO, I'M",
          style: textTheme.labelMedium?.copyWith(
            letterSpacing: 1.2,
            color: secondary,
          ),
        ),

        // Name
        Text(
          PortfolioData.name,
          style: isMobile
              ? textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                )
              : textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ),
        ),

        const SizedBox(height: 14),

        // Role
        Text(
          PortfolioData.role,
          style: textTheme.headlineSmall?.copyWith(
            color: accent,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),

        const SizedBox(height: 22),

        // Main value proposition (Professional & Impactful)
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Text(
            'Software Engineer specializing in Flutter & Cross-Platform Mobile Development. '
            'I craft scalable, high-performance applications utilizing Clean Architecture, '
            'BLoC, and robust RESTful API integration.',
            style: textTheme.bodyLarge?.copyWith(
              color: secondary,
              height: 1.7,
            ),
          ),
        ),

        const SizedBox(height: 30),

        // Tech stack
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildTechTag('Flutter', accent),
            _buildTechTag('Dart', accent),
            _buildTechTag('BLoC / Cubit', accent),
            _buildTechTag('Clean Architecture', accent),
            _buildTechTag('Firebase', accent),
            _buildTechTag('REST APIs', accent),
            _buildTechTag('Git', accent),
          ],
        ),

        const SizedBox(height: 34),

        // Buttons (Improved Visual Hierarchy)
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            // Primary Action: View Projects
            ElevatedButton.icon(
              onPressed: () => _scrollToProjects(context),
              icon: const Icon(
                Icons.arrow_forward_rounded,
                size: 18,
              ),
              label: const Text('View Projects'),
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.black, // يتناسب ممتاز مع اللون البرتقالي/الذهبي
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 16,
                ),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            // Secondary Action: View CV
            OutlinedButton.icon(
              onPressed: () => _open(PortfolioData.resumeUrl),
              icon: const Icon(
                Icons.file_download_outlined,
                size: 18,
              ),
              label: const Text('View CV'),
              style: OutlinedButton.styleFrom(
                foregroundColor: secondary,
                side: BorderSide(color: secondary.withOpacity(0.5)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 34),

        // Location & Role Info
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 16,
              color: secondary,
            ),
            const SizedBox(width: 6),
            Text(
              'Egypt',
              style: textTheme.bodySmall?.copyWith(
                color: secondary,
              ),
            ),
            const SizedBox(width: 18),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: secondary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 18),
            Text(
              'Flutter Developer',
              style: textTheme.bodySmall?.copyWith(
                color: secondary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        // Social links
        Wrap(
          spacing: 20,
          runSpacing: 12,
          children: PortfolioData.socials
              .map(
                (s) => InkWell(
                  onTap: () => _open(s.url),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        s.icon,
                        size: 16,
                        color: accent,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        s.label,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildPhoto(
    Color accent,
    bool isMobile,
  ) {
    final size = isMobile ? 240.0 : 300.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main Frame
        Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: accent,
              width: 2,
            ),
          ),
          child: Image.asset(
            'assets/images/protoflio.jfif',
            fit: BoxFit.cover,
          ),
        ),

        // Technical Decorative Corner
        Positioned(
          top: -6,
          right: -6,
          child: Container(
            width: 14,
            height: 14,
            color: accent,
          ),
        ),
      ],
    );
  }

  Widget _buildTechTag(
    String text,
    Color accent,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: accent.withOpacity(0.4),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}