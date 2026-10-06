import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_colors.dart';
import '../data/portfolio_data.dart';

class ExperienceSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ExperienceSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final items = PortfolioData.experience;

    return Container(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Tag Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 20, height: 2, color: AppColors.accentGold),
              const SizedBox(width: 8),
              const Text(
                'EXPERIENCE',
                style: TextStyle(
                  color: AppColors.accentGold,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Main Title
          const Text(
            'Career Journey',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            'My professional path in mobile development',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 48),

          // Timeline List
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return TimelineItem(
                  role: item.role,
                  company: item.company,
                  period: item.period,
                  locationType: item.locationType,
                  description: item.description,
                  isLast: index == items.length - 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String role;
  final String company;
  final String period;
  final String? locationType;
  final String description;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.role,
    required this.company,
    required this.period,
    required this.locationType,
    required this.description,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Timeline (Line + Circle Node)
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // Node Dot
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0F172A),
                    border: Border.all(color: AppColors.accentGold, width: 2),
                  ),
                ),
                // Vertical Connecting Line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppColors.accentGold.withOpacity(0.3),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Right Card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Period Date
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: AppColors.accentGold,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        period,
                        style: const TextStyle(
                          color: AppColors.accentGold,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Role Title
                  Text(
                    role,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Company & Location Tag
                  Row(
                    children: [
                      Text(
                        company,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 10,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            const SizedBox(width: 3),
                            Text(
                                locationType ?? '',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}