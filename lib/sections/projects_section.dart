import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../widgets/section_header.dart';
import '../widgets/project_card.dart';
import '../widgets/responsive.dart';

class ProjectsSection extends StatelessWidget {
  final GlobalKey sectionKey;
  const ProjectsSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final projects = PortfolioData.projects;
    final screenSize = Responsive.of(context);
    final crossAxisCount = screenSize == ScreenSize.desktop
        ? 2
        : screenSize == ScreenSize.tablet
            ? 2
            : 1;

    return Container(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            tag: 'projects',
            title: 'مشاريع مختارة',
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              mainAxisExtent: 230,
            ),
            itemBuilder: (context, i) => ProjectCard(project: projects[i]),
          ),
        ],
      ),
    );
  }
}
