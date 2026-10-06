import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_colors.dart';

class TimelineItem extends StatelessWidget {
  final String role;
  final String company;
  final String period;
  final String locationType; // e.g., Cairo, Remote, Hybrid
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
    const accentColor = AppColors.accentGold; // Indigo Accent

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
                color: const Color(0xFF131B2E), // Dark Card Background
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
                        color: accentColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        period,
                        style: const TextStyle(
                          color: accentColor,
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
                              locationType,
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