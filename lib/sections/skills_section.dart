import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const SkillsSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.accentGold : AppColors.accentRust;
    final secondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(tag: 'skills', title: 'Technical Skills'),
          const SizedBox(height: 55),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 850;

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expanded(flex: 3, child: _buildIntro(context, accent, secondary, textTheme)),
                    const SizedBox(width: 60),
                    // 👇 هنا بقى بياخد العرض المتاح فعليًا عشان الـ Grid
                    // جوّاه يحسب عدد الأعمدة صح.
                    Expanded(
                      flex: 7,
                      child: _buildSkillsGrid(context, accent, secondary, divider, textTheme),
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // _buildIntro(context, accent, secondary, textTheme),
                  const SizedBox(height: 45),
                  _buildSkillsGrid(context, accent, secondary, divider, textTheme),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INTRO (زي ما هو تقريبًا، بدون تغيير جوهري)
  // ============================================================
  // Widget _buildIntro(BuildContext context, Color accent, Color secondary, TextTheme textTheme) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         width: 52,
  //         height: 4,
  //         decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(20)),
  //       ),
  //       const SizedBox(height: 22),
  //       Text(
  //         'What I\nWork With',
  //         style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, height: 1.15),
  //       ),
  //       const SizedBox(height: 18),
  //       Text(
  //         'A practical toolkit focused on building '
  //         'scalable, responsive and maintainable '
  //         'mobile applications.',
  //         style: textTheme.bodyMedium?.copyWith(color: secondary, height: 1.7),
  //       ),
  //       const SizedBox(height: 28),
  //       Row(
  //         children: [
  //           Icon(Icons.code_rounded, size: 18, color: accent),
  //           const SizedBox(width: 10),
  //           Text('Flutter Developer', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // ============================================================
  // بيانات الفئات (خليتها في list واحدة بدل ما تتكرر كنداءات دوال
  // منفصلة، أسهل تضيف أو تشيل فئة من هنا).
  // ============================================================
  static const _categories = [
    _SkillCategoryData(
      icon: Icons.phone_android_rounded,
      title: 'Mobile Development',
      skills: ['Flutter', 'Dart', 'Responsive UI', 'Adaptive Layouts'],
    ),
    _SkillCategoryData(
      icon: Icons.account_tree_outlined,
      title: 'State Management',
      skills: ['BLoC', 'Cubit', 'Provider'],
    ),
    _SkillCategoryData(
      icon: Icons.layers_outlined,
      title: 'Architecture & Backend',
      skills: ['Clean Architecture', 'Repository Pattern', 'Firebase', 'Supabase', 'REST APIs'],
    ),
    _SkillCategoryData(
      icon: Icons.storage_outlined,
      title: 'Data & Storage',
      skills: ['Hive', 'SQL', 'Firebase Firestore'],
    ),
    _SkillCategoryData(
      icon: Icons.code_rounded,
      title: 'Programming',
      skills: ['C#', '.NET', 'Node.js', 'PHP'],
    ),
    _SkillCategoryData(
      icon: Icons.build_outlined,
      title: 'Tools & Workflow',
      skills: ['Git', 'GitHub', 'Postman', 'Figma'],
    ),
  ];

  // ============================================================
  // GRID: الكروت جنب بعض
  // -----------------------------------------------------------
  // بيستخدم LayoutBuilder + Wrap: كل كارت بياخد عرض ثابت محسوب حسب
  // عدد الأعمدة، وبيعمل wrap للسطر اللي بعده لو المساحة خلصت.
  // ============================================================
  Widget _buildSkillsGrid(
    BuildContext context,
    Color accent,
    Color secondary,
    Color divider,
    TextTheme textTheme,
  ) {
    const spacing = 20.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // 👇 عدد الأعمدة: 2 لو المساحة كافية، وإلا عمود واحد.
        // غيّر الرقم 520 لو عايز الأعمدة تتحول بسرعة أو ببطء أكتر.
        final columns = constraints.maxWidth >= 520 ? 2 : 1;
        final cardWidth = (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: _categories.map((data) {
            return SizedBox(
              width: cardWidth,
              child: _SkillCard(
                data: data,
                accent: accent,
                secondary: secondary,
                divider: divider,
                textTheme: textTheme,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

// =============================================================================
// موديل بسيط لبيانات الفئة الواحدة (بدل ما نبعت 4-5 parameters منفصلة)
// =============================================================================
class _SkillCategoryData {
  final IconData icon;
  final String title;
  final List<String> skills;
  const _SkillCategoryData({required this.icon, required this.title, required this.skills});
}

// =============================================================================
// كارت الفئة الواحدة — StatefulWidget عشان يقدر يعمل hover effect
// -----------------------------------------------------------------------------
// لما الماوس يقرب من الكارت: بيتحرك لفوق شوية (translate)، البوردر
// بيتلون بالـ accent، وبيبان عليه ظل خفيف. ده اللي بيدي إحساس "بروفيشنال"
// زي كروت الـ SaaS websites.
// =============================================================================
class _SkillCard extends StatefulWidget {
  final _SkillCategoryData data;
  final Color accent;
  final Color secondary;
  final Color divider;
  final TextTheme textTheme;

  const _SkillCard({
    required this.data,
    required this.accent,
    required this.secondary,
    required this.divider,
    required this.textTheme,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.white.withOpacity(0.025) : Colors.black.withOpacity(0.018);
    // 👇 عند الـ hover: خلفية أفتح شوية بلون الـ accent، وبوردر accent كامل.
    final bgColor = _hovered ? widget.accent.withOpacity(0.06) : baseColor;
    final borderColor = _hovered ? widget.accent.withOpacity(0.6) : widget.divider.withOpacity(0.8);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        // 👇 حركة بسيطة لفوق عند الـ hover (translate)
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: _hovered ? 1.4 : 1),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.accent.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // خط رفيع فوق العنوان بلون الـ accent — تفصيلة زخرفية بسيطة
            Container(
              width: 28,
              height: 3,
              decoration: BoxDecoration(color: widget.accent, borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: widget.accent.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(widget.data.icon, color: widget.accent, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.data.title,
                    style: widget.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: widget.data.skills
                  .map((skill) => _skillChip(skill, widget.accent, widget.secondary))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CHIP — دلوقتي بخلفية خفيفة بلون الـ accent بدل بوردر فاضي بس
  // ============================================================
  Widget _skillChip(String skill, Color accent, Color secondary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        // 👇 التغيير الرئيسي هنا: خلفية شفافة خفيفة بلون الـ accent
        color: accent.withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            skill,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: secondary),
          ),
        ],
      ),
    );
  }
}