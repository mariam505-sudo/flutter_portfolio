import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';

// =============================================================================
// CertificationsSection
// -----------------------------------------------------------------------------
// الشكل ده مقسوم لجزئين جنب بعض (Row) زي الصورة اللي بعتها بالظبط:
//   - على الشمال  (List)   : ليستة بكل الشهادات، كل شهادة سطر بعنوان + جهة + سنة.
//   - على اليمين  (Preview): كارد كبير بيعرض صورة الشهادة اللي واقف عليها الماوس
//                            (أو اللي عملتلها Tap لو موبايل/تاتش).
//
// الجزئين جنب بعض طول الوقت (مفيش تحويل لـ Column إلا لو الشاشة ضيقة جدًا
// زي الموبايل الصغير) عشان يفضل شكله مطابق للديزاين المطلوب.
// =============================================================================

class CertificationsSection extends StatefulWidget {
  final GlobalKey sectionKey;
  const CertificationsSection({super.key, required this.sectionKey});

  @override
  State<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends State<CertificationsSection> {
  // -------------------------------------------------------------------------
  // index الشهادة اللي متعروضة دلوقتي في الكارد اليمين.
  // بيتغير لما تعمل hover (بالماوس) أو tap (باللمس) على أي عنصر في الليستة.
  // -------------------------------------------------------------------------
  int _activeIndex = 0;

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
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final secondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final textTheme = Theme.of(context).textTheme;

    // ---------------------------------------------------------------------
    // 👇 مصدر بيانات الشهادات.
    // خليها زي ما هي على PortfolioData.certifications، وظبط الموديل عندك
    // بحيث يبقى فيه نفس الحقول (title, issuer, date, period, note,
    // credentialUrl, imageUrl) زي الشرح في آخر الملف.
    // ---------------------------------------------------------------------
    final items = PortfolioData.certifications;

    return Container(
      key: widget.sectionKey,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // لو الشاشة أعرض من 640px هيبقى الشكل Row (جنب بعض) زي الصورة.
          // لو أضيق من كده (موبايل صغير جدًا) هيتحول لـ Column عشان محدش
          // يتقطع أو يطلع بره الشاشة. غيّر الرقم ده لو عايز نقطة تحويل مختلفة.
          final isSideBySide = constraints.maxWidth > 640;

          final header = _buildHeader(context, accent, secondary, items.length);
          final list =
              _buildList(context, items, accent, divider, secondary, textTheme);
          final preview = _buildPreview(
              context, items[_activeIndex], accent, secondary, textTheme);

          if (!isSideBySide) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                const SizedBox(height: 32),
                preview,
                const SizedBox(height: 32),
                list,
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              const SizedBox(height: 40),
              // ---------------------------------------------------------
              // هنا التقسيم الجانبي: flex: 3 لليست و flex: 2 للـ preview
              // زي النسبة تقريبًا في الصورة. لو عايز الكارد يبقى أكبر أو
              // أصغر، غيّر الأرقام دي (مثلاً 3 و 3 لو عايزهم متساويين).
              // ---------------------------------------------------------
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: list),
                    const SizedBox(width: 48),
                    Expanded(flex: 2, child: preview),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // =========================================================================
  // الهيدر: "05 —— CREDENTIALS" + العنوان الكبير + جملة العدد
  // =========================================================================
  Widget _buildHeader(
      BuildContext context, Color accent, Color secondary, int count) {
    final textTheme = Theme.of(context).textTheme;
    final items = PortfolioData.certifications;

    // بياخد أول كلمة من كل جهة مانحة (issuer) عشان يعملهم list في الجملة
    // تحت العنوان، زي "Elevate Tech, T-Shoot, ICPC..." في الصورة.
    final issuers =
        items.map((c) => c.issuer.split(' ').first).toSet().join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '05', // 👈 رقم السكشن. غيّره حسب ترتيب السكشن في صفحتك.
              style: textTheme.labelMedium?.copyWith(
                color: accent,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(width: 8),
            Container(width: 24, height: 1, color: secondary.withOpacity(0.4)),
            const SizedBox(width: 8),
            Text(
              'CREDENTIALS', // 👈 عنوان الوسم الصغير. غيّره لو عايز نص عربي.
              style: textTheme.labelMedium
                  ?.copyWith(color: secondary, letterSpacing: 2),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // العنوان الكبير: الجزء اللي جوا TextSpan التاني ده هو اللي بيبقى
        // بلون accent ومتحته خط، زي "the paper to show for it" في الصورة.
        RichText(
          text: TextSpan(
            style: textTheme.displaySmall
                ?.copyWith(fontWeight: FontWeight.bold, height: 1.15),
            children: [
              const TextSpan(text: 'Certified, with '), // 👈 غيّر النص هنا
              TextSpan(
                text: '\nthe paper to show for it', // 👈 والجزء الملون هنا
                style: TextStyle(
                    color: accent, decoration: TextDecoration.underline),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '$count $issuers ',
          style: textTheme.bodyMedium?.copyWith(color: secondary),
        ),
      ],
    );
  }

  // =========================================================================
  // الليست (الجزء الشمال): كل شهادة = سطر واحد
  // =========================================================================
  Widget _buildList(
    BuildContext context,
    List<dynamic> items,
    Color accent,
    Color divider,
    Color secondary,
    TextTheme textTheme,
  ) {
    return Column(
      children: List.generate(items.length, (i) {
        final c = items[i];
        final isActive = i == _activeIndex;

        // period و note حقول اختيارية (المدة والوصف القصير). لو موديلك
        // معندوش الحقول دي، الدالة _tryGet بترجع null وميحصلش error.
        final period = _tryGet(c, 'period'); // مثال: "Nov 2025 — Apr 2026"
        final note =
            _tryGet(c, 'note'); // مثال: "company-based practical training"

        return MouseRegion(
          // لما الماوس يدخل فوق العنصر ده -> يتعرض في الكارد اليمين تلقائيًا.
          onEnter: (_) => setState(() => _activeIndex = i),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            // للموبايل/التاتش: نفس الحاجة بس بالضغط.
            onTap: () => setState(() => _activeIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: divider),
                  // الخط الأخضر (accent) على الشمال بيظهر بس للعنصر النشط.
                  left: BorderSide(
                      color: isActive ? accent : Colors.transparent, width: 2),
                ),
                color: isActive ? accent.withOpacity(0.05) : Colors.transparent,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // أيقونة دائرية صغيرة (شارة الشهادة)
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color:
                              isActive ? accent : secondary.withOpacity(0.5)),
                    ),
                    child: Icon(
                      Icons.workspace_premium_outlined,
                      size: 16,
                      color: isActive ? accent : secondary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // عنوان الشهادة
                        Text(
                          c.title,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isActive ? accent : null,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // اسم الجهة المانحة
                        Text(c.issuer,
                            style: textTheme.bodySmall
                                ?.copyWith(color: secondary)),
                        // سطر إضافي فيه المدة والوصف، لو موجودين
                        if (period != null || note != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            [period, note].where((e) => e != null).join(' · '),
                            style: textTheme.labelSmall
                                ?.copyWith(color: secondary.withOpacity(0.7)),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // السنة على أقصى اليمين
                  Text(
                    c.date,
                    style: textTheme.labelMedium
                        ?.copyWith(color: secondary, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
  // =========================================================================
  // الكارد اليمين: بيعرض صورة الشهادة النشطة + اسمها + الجهة المانحة
  // =========================================================================
  Widget _buildPreview(
  BuildContext context,
  dynamic c,
  Color accent,
  Color secondary,
  TextTheme textTheme,
) {
  final imageUrl = _tryGet(c, 'imageUrl');
  final credentialUrl = _tryGet(c, 'credentialUrl');

  final isNetworkImage =
      imageUrl != null &&
      (imageUrl.startsWith('http://') ||
          imageUrl.startsWith('https://'));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: credentialUrl != null
            ? () => _open(credentialUrl)
            : null,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            minHeight: 420,
            maxHeight: 600,
          ),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: accent.withOpacity(0.35),
              width: 1.5,
            ),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.03)
                : Colors.grey.withOpacity(0.05),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageUrl == null
                ? _placeholderCertificate(
                    c,
                    accent,
                    secondary,
                    textTheme,
                  )
                : (isNetworkImage
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            _placeholderCertificate(
                          c,
                          accent,
                          secondary,
                          textTheme,
                        ),
                      )
                    : Image.asset(
                        imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            _placeholderCertificate(
                          c,
                          accent,
                          secondary,
                          textTheme,
                        ),
                      )),
          ),
        ),
      ),

      const SizedBox(height: 16),

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  c.issuer,
                  style: textTheme.bodySmall?.copyWith(
                    color: secondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          Text(
            c.date,
            style: textTheme.labelMedium?.copyWith(
              color: accent,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),

      const SizedBox(height: 10),

      Row(
        children: [
          Icon(
            Icons.open_in_new_rounded,
            size: 14,
            color: secondary.withOpacity(0.7),
          ),
          const SizedBox(width: 6),
          Text(
            credentialUrl != null
                ? 'CLICK TO VIEW CREDENTIAL'
                : 'CERTIFICATE PREVIEW',
            style: textTheme.labelSmall?.copyWith(
              color: secondary.withOpacity(0.65),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    ],
  );
}
  // شكل بديل بيتعرض لو مفيش صورة أو الصورة فشلت تحمل، عشان الصفحة
  // ميبقاش فيها فراغ أبيض.
  Widget _placeholderCertificate(
      dynamic c, Color accent, Color secondary, TextTheme textTheme) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events_outlined, color: accent, size: 32),
          const SizedBox(height: 12),
          Text(
            'CERTIFICATE OF ACHIEVEMENT',
            textAlign: TextAlign.center,
            style: textTheme.labelMedium
                ?.copyWith(color: Colors.black54, letterSpacing: 1),
          ),
          const SizedBox(height: 8),
          Text(
            c.title,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium
                ?.copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(c.issuer,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(color: Colors.black54)),
        ],
      ),
    );
  }

  // ===========================================================================
  // دالة مساعدة: بتقرا حقل اختياري من الـ certification object من غير ما
  // تعمل crash لو الحقل مش موجود في الموديل بتاعك.
  // ===========================================================================
  String? _tryGet(dynamic c, String field) {
    try {
      switch (field) {
        case 'period':
          return c.period as String?;
        case 'note':
          return c.note as String?;
        case 'imageUrl':
          return c.imageUrl as String?;
        case 'credentialUrl':
          return c.credentialUrl as String?;
      }
    } catch (_) {
      return null;
    }
    return null;
  }
}
