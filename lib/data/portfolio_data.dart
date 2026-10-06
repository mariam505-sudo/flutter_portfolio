import 'package:flutter/material.dart';
class SocialLink {
  final String label;
  final IconData icon;
  final String url;
  const SocialLink({required this.label, required this.icon, required this.url});
}

class ExperienceItem {
  final String role;
  final String company;
  final String period; // e.g. "2023 — Present"
  final String description;
  final String? locationType;
  final List<String> highlights;
  const ExperienceItem({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    this.locationType,
    this.highlights = const [],
  });
}


class ProjectItem {
  final String title;
  final String description;
  final List<String> techStack;
  final String? liveUrl;
  final String? repoUrl;
  const ProjectItem({
    required this.title,
    required this.description,
    required this.techStack,
    this.liveUrl,
    this.repoUrl,
  });
}

class SkillGroup {
  final String category;
  final List<String> skills;
  const SkillGroup({required this.category, required this.skills});
}

class EducationItem {
  final String degree;
  final String institution;
  final String period;
  final String description;
  const EducationItem({
    required this.degree,
    required this.institution,
    required this.period,
    this.description = '',
  });
}

class CertificationItem {
  final String title;
  final String issuer;
  final String date;
  final String? period;
  final String? note;
  final String? credentialUrl;
  final String? imageUrl;

  const CertificationItem({
    required this.title,
    required this.issuer,
    required this.date,
    this.period,
    this.note,
    this.credentialUrl,
    this.imageUrl,
  });
}

class PortfolioData {
  PortfolioData._();

  // ---- Identity ----
  static const String name = 'Mariam Shenoda';
  static const String role = 'Flutter Developer';
  // static const String tagline ="Passionate Flutter developer with 3+ years of experience crafting beautiful, performant cross-platform mobile applications. I turn ideas into pixel-perfect products used by thousands."; 
  static const String aboutText =
      'مبرمج Flutter شغال في بناء تطبيقات متعددة المنصات، مهتم بالأداء وتفاصيل الـ UI. '
      'بحب أحول الأفكار المعقدة لواجهات بسيطة وسهلة الاستخدام، وبتعلم حاجة جديدة كل مشروع.';

  static const String email = 'mariam.shenouda.dev@gmail.com';
  static const String location = 'Sohag, Egypt';

  /// رابط ملف الـ CV بتاعك (PDF). ينفع يكون:
  /// - رابط أونلاين (Google Drive / Dropbox / موقعك) — الأسهل ويشتغل على الويب والموبايل زي ما هو.
  /// - أو لو حابب تحطه جوه المشروع نفسه: ضيف الملف في assets/cv/cv.pdf، فعّل سطر
  ///   الـ assets في pubspec.yaml، وغيّر القيمة هنا لـ 'assets/cv/cv.pdf' مع
  ///   تعديل بسيط في hero_section.dart لفتحه بمكتبة زي open_filex بدل url_launcher.
  static const String resumeUrl = 'https://example.com/your-cv.pdf';

  static const List<SocialLink> socials = [
    SocialLink(label: 'GitHub', icon: Icons.code_rounded, url: 'https://github.com/mariam505-sudo'),
    SocialLink(label: 'LinkedIn', icon: Icons.business_center_rounded, url: 'https://www.linkedin.com/in/mariam-shenoda-31a18a352/'),
    SocialLink(label: 'Email', icon: Icons.mail_outline_rounded, url: 'mailto:mariam.shenouda.dev@gmail.com'),
  ];

// ---- Experience ----
  static const List<ExperienceItem> experience = [
    ExperienceItem(
      role: 'Flutter Developer Intern',
      company: 'Eduzah',
      period: '2026',
      locationType: 'Internship',
      description:
          'Engineered "Ay Khidma", a home services app using Clean Architecture & BLoC. Integrated Paymob, Firebase, REST APIs, and converted Figma designs into responsive UIs.',
    ),
    ExperienceItem(
      role: '3rd Place Winner - Hackathon',
      company: 'Creativa Hub',
      period: '2025',
      locationType: 'On-site',
      description:
          'Architected & built a Training Session Reservation App under time constraints. Led UI development and REST API integration with a competitive dev team.',
    ),
    ExperienceItem(
      role: 'Cross-Platform Mobile Dev Trainee',
      company: 'ITI & DEPI',
      period: '2025',
      locationType: 'Training Program',
      description:
          'Completed intensive technical training in mobile app development (Flutter/Dart) along with .NET backend foundations (C#, ASP.NET Core, SQL Server).',
    ),
    ExperienceItem(
      role: 'Mobile Application Developer',
      company: 'Personal & Client Projects',
      period: '2024 - Present',
      locationType: 'Freelance / Self-employed',
      description:
          'Designed and delivered multiple full-featured mobile apps including Salamatak (Home Nursing Care), Souqi (Marketplace), and Mobile Store using Provider & BLoC.',
    ),
  ];

  // ---- Projects ----
  static const List<ProjectItem> projects = [
    ProjectItem(
      title: 'اسم المشروع الأول',
      description: 'وصف مختصر للمشروع، إيه المشكلة اللي بيحلها وليه مميز.',
      techStack: ['Flutter', 'Firebase', 'Provider'],
      liveUrl: 'https://example.com',
      repoUrl: 'https://github.com/yourusername/project-one',
    ),
    ProjectItem(
      title: 'اسم المشروع التاني',
      description: 'وصف مختصر للمشروع التاني، النتيجة اللي وصلتلها.',
      techStack: ['Flutter Web', 'REST API', 'Bloc'],
      repoUrl: 'https://github.com/yourusername/project-two',
    ),
    ProjectItem(
      title: 'اسم المشروع التالت',
      description: 'وصف مختصر يوضح دورك في المشروع والتقنيات المستخدمة.',
      techStack: ['Dart', 'SQLite', 'GetX'],
      repoUrl: 'https://github.com/yourusername/project-three',
    ),
  ];

  // ---- Skills ----
  static const List<SkillGroup> skills = [
    SkillGroup(category: 'Languages', skills: ['Dart', 'JavaScript', 'Python']),
    SkillGroup(category: 'Frameworks', skills: ['Flutter', 'Firebase', 'REST APIs']),
    SkillGroup(category: 'State Management', skills: ['Bloc', 'Provider', 'Riverpod', 'GetX']),
    SkillGroup(category: 'Tools', skills: ['Git', 'Figma', 'VS Code', 'Postman']),
  ];

  // ---- Education ----
  static const List<EducationItem> education = [
    EducationItem(
      degree: 'بكالوريوس علوم حاسب',
      institution: 'اسم الجامعة',
      period: '2023 — 2027',
      description: 'تخصص هندسة برمجيات، مشروع التخرج كان تطبيق Flutter.',
    ),
  ];

  // ---- Certifications ----
// ---- Certifications ----
static const List<CertificationItem> certifications = [
  
  CertificationItem(
    title: 'Flutter Internship',
    issuer: 'Eduzah',
    date: '2026',
    period: '2026',
    note: 'Flutter Developer Internship',
    imageUrl: 'assets/images/eduza_intern.jfif',
  ),

 CertificationItem(
    title: 'Creativa Hackathon',
    issuer: 'Creativa Hub',
    date: '2025',
    note: '3rd Place Winner',
    imageUrl: 'assets/images/createve_tree.jfif',
  ),
  CertificationItem(
    title: 'Flutter & Dart Training',
    issuer: 'ITI',
    date: '2025',
    period: '2025',
    note: 'Mobile application development training',
    imageUrl: 'assets/images/iti_flutter.jfif',
  ),

  CertificationItem(
    title: 'Flutter Development',
    issuer: 'Creativa',
    date: '2025',
    note: ' Mobile application development training',
    imageUrl: 'assets/images/createve flutter.jfif',
  ),



   CertificationItem(
    title: 'MVVM Architecture',
    issuer: 'Training Certificate',
    date: '2025',
    note: 'Software development training',
    imageUrl: 'assets/images/MVVM.jfif',
  ),


  
  CertificationItem(
    title: 'Sprints,Microsoft',
    issuer: 'Training Certificate',
    date: '2024',
    note: 'Flutter development training',
    imageUrl: 'assets/images/flutter sport.jfif',
  ),
];
}


  // static const String email = 'ahmednaserb9@gmail.com';
  // static const String phone = '+20 112 136 2555';
  // static const String location = 'Cairo, Egypt';

  // static const socials = [
  //   SocialLink(label: 'GitHub', url: 'https://github.com/username'),
  //   SocialLink(label: 'LinkedIn', url: 'https://linkedin.com/in/username'),
  //   SocialLink(label: 'Email', url: 'mailto:ahmednaserb9@gmail.com'),
  //   SocialLink(label: 'Facebook', url: 'https://facebook.com/username'),
  //   SocialLink(label: 'Instagram', url: 'https://instagram.com/username'),
  // ];
