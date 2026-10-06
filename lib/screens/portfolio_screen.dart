import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive.dart';
import '../widgets/blueprint_grid_background.dart';
import '../widgets/nav_rail.dart';
import '../widgets/nav_item.dart';
import '../widgets/mobile_nav.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/experience_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../sections/education_section.dart';
import '../sections/certifications_section.dart';
import '../sections/contact_footer.dart';

class PortfolioScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const PortfolioScreen({super.key, required this.isDark, required this.onToggleTheme});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  late final Animation<double> _fade = CurvedAnimation(
    parent: _entranceController,
    curve: Curves.easeOut,
  );
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, 0.04),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic));

  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _certificationsKey = GlobalKey();

  late final List<NavItem> _navItems = [
    NavItem(id: 'about', label: 'about', sectionKey: _aboutKey),
    NavItem(id: 'experience', label: 'experience', sectionKey: _experienceKey),
    NavItem(id: 'projects', label: 'projects', sectionKey: _projectsKey),
    NavItem(id: 'skills', label: 'skills', sectionKey: _skillsKey),
    NavItem(id: 'education', label: 'education', sectionKey: _educationKey),
    NavItem(id: 'certifications', label: 'certifications', sectionKey: _certificationsKey),
  ];

  @override
  void initState() {
    super.initState();
    // لحظة دخول واحدة منظمة للصفحة كلها، مش أنيميشن متكرر على كل عنصر.
    WidgetsBinding.instance.addPostFrameCallback((_) => _entranceController.forward());
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  void _scrollTo(NavItem item) {
    final ctx = item.sectionKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final gridLine = isDark ? AppColors.darkGridLine : AppColors.lightGridLine;
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.pagePadding(context);
    final maxWidth = Responsive.contentMaxWidth(context);

    final content = SingleChildScrollView(
      padding: padding,
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth == double.infinity ? 900 : maxWidth + 160),
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeroSection(sectionKey: _heroKey),
                  AboutSection(sectionKey: _aboutKey),
                  ExperienceSection(sectionKey: _experienceKey),
                  ProjectsSection(sectionKey: _projectsKey),
                  SkillsSection(sectionKey: _skillsKey),
                  // EducationSection(sectionKey: _educationKey),
                  CertificationsSection(sectionKey: _certificationsKey),
                  const ContactFooter(sectionKey: GlobalObjectKey('contact_footer')),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: isMobile ? MobileAppBar(isDark: isDark, onToggleTheme: widget.onToggleTheme) : null,
      drawer: isMobile ? MobileNavDrawer(items: _navItems, onTap: _scrollTo) : null,
      body: BlueprintGridBackground(
        lineColor: gridLine,
        child: isMobile
            ? content
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32, top: 8),
                    child: NavRail(
                      items: _navItems,
                      onTap: _scrollTo,
                      onToggleTheme: widget.onToggleTheme,
                      isDark: isDark,
                    ),
                  ),
                  Expanded(child: content),
                ],
              ),
      ),
    );
  }
}
