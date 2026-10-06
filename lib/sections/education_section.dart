// import 'package:flutter/material.dart';
// import '../data/portfolio_data.dart';
// import '../widgets/section_header.dart';
// import '../widgets/timeline_item.dart';

// class EducationSection extends StatelessWidget {
//   final GlobalKey sectionKey;
//   const EducationSection({super.key, required this.sectionKey});

//   @override
//   Widget build(BuildContext context) {
//     final items = PortfolioData.education;
//     return Container(
//       key: sectionKey,
//       padding: const EdgeInsets.symmetric(vertical: 40),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SectionHeader(tag: 'education', title: 'التعليم'),
//           ...List.generate(items.length, (i) {
//             final e = items[i];
//             return TimelineItem(
//               title: e.degree,
//               subtitle: e.institution,
//               period: e.period,
//               description: e.description,
//               isLast: i == items.length - 1,
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }
