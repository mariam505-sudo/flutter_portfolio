import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';

/// كارت مشروع: بوردر رفيع بدل الظل الدائري النمطي، وشريط لون جانبي
/// يحدد الهوية بدل الاعتماد على border-radius واحد في كل حاجة.
class ProjectCard extends StatefulWidget {
  final ProjectItem project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovering = false;

  Future<void> _open(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.accentGold : AppColors.accentRust;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final textTheme = Theme.of(context).textTheme;
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: surface,
          border: Border(
            left: BorderSide(color: accent, width: _hovering ? 3 : 2),
            top: BorderSide(color: divider),
            right: BorderSide(color: divider),
            bottom: BorderSide(color: divider),
          ),
        ),
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.title, style: textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(p.description, style: textTheme.bodyMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: p.techStack
                  .map((t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
                        child: Text(t, style: textTheme.labelSmall),
                      ))
                  .toList(),
            ),
            if (p.liveUrl != null || p.repoUrl != null) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  if (p.repoUrl != null)
                    TextButton.icon(
                      onPressed: () => _open(p.repoUrl),
                      icon: const Icon(Icons.code_rounded, size: 16),
                      label: const Text('code'),
                      style: TextButton.styleFrom(
                        foregroundColor: accent,
                        textStyle: textTheme.labelLarge,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  if (p.liveUrl != null) ...[
                    const SizedBox(width: 16),
                    TextButton.icon(
                      onPressed: () => _open(p.liveUrl),
                      icon: const Icon(Icons.open_in_new_rounded, size: 16),
                      label: const Text('live'),
                      style: TextButton.styleFrom(
                        foregroundColor: accent,
                        textStyle: textTheme.labelLarge,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
