import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const AboutSection({
    super.key,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final primary = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Container(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          // =========================
          // Section Header
          // =========================
          const Center(
            child: SectionHeader(
              tag: 'about me',
              title: 'Who I Am',
              
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'A little about my journey as a Flutter Developer',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: secondary,
                  height: 1.6,
                ),
          ),

          const SizedBox(height: 60),

          // =========================
          // Main Content
          // =========================
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 850;

              if (isMobile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AboutText(
                      primary: primary,
                      secondary: secondary,
                    ),

                    const SizedBox(height: 40),

                    _Strengths(
                      primary: primary,
                      secondary: secondary,
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT
                  Expanded(
                    child: _AboutText(
                      primary: primary,
                      secondary: secondary,
                    ),
                  ),

                  const SizedBox(width: 70),

                  // RIGHT
                  Expanded(
                    child: _Strengths(
                      primary: primary,
                      secondary: secondary,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}


class _AboutText extends StatelessWidget {
  final Color primary;
  final Color secondary;

  const _AboutText({
    required this.primary,
    required this.secondary,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: textTheme.bodyLarge?.copyWith(
              color: secondary,
              height: 1.9,
            ),
            children: const [
              TextSpan(
                text: "I'm a ",
              ),
              TextSpan(
                text: "Flutter Developer",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text:
                    " passionate about building clean, modern and user-focused mobile applications.",
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        Text(
          "I enjoy turning ideas into real products, focusing on "
          "clean architecture, maintainable code, responsive interfaces, "
          "and smooth user experiences.",
          style: textTheme.bodyLarge?.copyWith(
            color: secondary,
            height: 1.9,
          ),
        ),

        const SizedBox(height: 22),

        Text(
          "My goal is to continuously improve my technical skills and "
          "build applications that are not only visually polished, "
          "but also reliable and scalable.",
          style: textTheme.bodyLarge?.copyWith(
            color: secondary,
            height: 1.9,
          ),
        ),

        const SizedBox(height: 35),

        // =========================
        // Stats
        // =========================
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
            _StatCard(
              value: '2+',
              label: 'Years Learning',
            ),
            _StatCard(
              value: '10+',
              label: 'Projects',
            ),
            _StatCard(
              value: 'BSc',
              label: 'Computer Science',
            ),
          ],
        ),
      ],
    );
  }
}
class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final secondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Container(
      width: 145,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.035)
            : Colors.black.withOpacity(0.025),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: secondary.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.w800,
                ),
          ),

          const SizedBox(height: 6),

          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: secondary,
                ),
          ),
        ],
      ),
    );
  }
}
class _Strengths extends StatelessWidget {
  final Color primary;
  final Color secondary;

  const _Strengths({
    required this.primary,
    required this.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StrengthCard(
          icon: Icons.phone_android_rounded,
          title: 'Cross-Platform Development',
          description:
              'Building modern mobile applications for Android and iOS using Flutter and Dart.',
          iconColor: AppColors.accentGold,
          primary: primary,
          secondary: secondary,
        ),

        const SizedBox(height: 18),

        _StrengthCard(
          icon: Icons.layers_outlined,
          title: 'Clean & Scalable Code',
          description:
              'Writing maintainable code using clean architecture, SOLID principles and good development practices.',
          iconColor: Colors.deepPurpleAccent,
          primary: primary,
          secondary: secondary,
        ),

        const SizedBox(height: 18),

        _StrengthCard(
          icon: Icons.bolt_rounded,
          title: 'Performance & User Experience',
          description:
              'Creating responsive interfaces with smooth interactions and a strong focus on usability.',
          iconColor: Colors.cyanAccent,
          primary: primary,
          secondary: secondary,
        ),
      ],
    );
  }
}

class _StrengthCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color iconColor;
  final Color primary;
  final Color secondary;

  const _StrengthCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.iconColor,
    required this.primary,
    required this.secondary,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.035)
            : Colors.black.withOpacity(0.025),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: secondary.withOpacity(0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 23,
            ),
          ),

          const SizedBox(width: 18),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),

                const SizedBox(height: 7),

                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: secondary,
                        height: 1.6,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}