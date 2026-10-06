import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../data/portfolio_data.dart';

// =============================================================================
// ContactFooter
// -----------------------------------------------------------------------------
// تعديلين طلبتهم:
//   1) الحجم بقى أصغر وأكتر تناسق مع باقي الصفحة (padding وخطوط أصغر +
//      maxWidth عشان السكشن مايبقاش عريض أوي على الشاشات الكبيرة).
//   2) الفورم دلوقتي بيبعت إيميل حقيقي فعلاً لإيميلك عن طريق خدمة
//      FormSubmit.co (مجانية، من غير تسجيل، من غير API keys). التفاصيل
//      وخطوات التفعيل في آخر الملف تحت "FormSubmit setup".
// =============================================================================

class ContactFooter extends StatefulWidget {
  final GlobalKey sectionKey;
  const ContactFooter({super.key, required this.sectionKey});

  @override
  State<ContactFooter> createState() => _ContactFooterState();
}

class _ContactFooterState extends State<ContactFooter> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  // بيبقى true وقت إرسال الرسالة عشان نوقف الزرار ونوريه Loading indicator.
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // ---------------------------------------------------------------------
  // الإرسال الفعلي: بنبعت POST request لـ FormSubmit.co ومعاه إيميلك.
  // الخدمة دي بتوصل الرسالة لصندوق بريدك مباشرة، من غير ما نفتح تطبيق
  // إيميل تاني عند اللي بيبعت الرسالة، ومن غير أي إعداد سيرفر أو API key.
  //
  // ⚠️ أول مرة بس: FormSubmit هيبعتلك إيميل تأكيد على العنوان بتاعك،
  // لازم تدوس على رابط التفعيل جواه مرة واحدة. بعد كده أي رسالة جديدة
  // هتوصلك على طول.
  // ---------------------------------------------------------------------
  Future<void> _handleSend() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('https://formsubmit.co/ajax/${PortfolioData.email}'),
        headers: const {'Accept': 'application/json'},
        body: {
          'name': name,
          'email': email,
          'subject': subject,
          'message': message,
          // بيمنع FormSubmit من عمل ريدايركت لصفحة تانية بعد الإرسال،
          // عشان نفضل جوه التطبيق ونتحكم في الرسالة اللي بتظهر للمستخدم.
          '_template': 'table',
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        _formKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إرسال رسالتك بنجاح، هترد عليك قريب!')),
        );
      } else {
        _showSendError();
      }
    } catch (_) {
      if (mounted) _showSendError();
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  void _showSendError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('حصل خطأ أثناء الإرسال. جرب تاني أو ابعت إيميل مباشر.'),
        action: SnackBarAction(
          label: 'افتح الإيميل',
          onPressed: () => _open('mailto:${PortfolioData.email}'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.accentGold : AppColors.accentRust;
    final secondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: widget.sectionKey,
      width: double.infinity,
      // 👇 padding الرأسي اتقلل من 90 لـ 56، والأفقي فضل 24.
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      child: Center(
        child: ConstrainedBox(
          // 👇 السكشن كله بقى محصور بعرض 1000 بدل ما ياخد عرض الشاشة كله.
          // غيّر الرقم ده لو عايزه أعرض أو أضيق.
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              _buildHeader(context, accent, secondary),
              const SizedBox(height: 36),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 750;
                  final contact = _buildGetInTouchCard(context, accent, divider, secondary, textTheme);
                  final form = _buildFormCard(context, accent, divider, secondary, textTheme);

                  if (!isWide) {
                    return Column(children: [contact, const SizedBox(height: 20), form]);
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 4, child: contact),
                      const SizedBox(width: 24),
                      Expanded(flex: 6, child: form),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // الهيدر — خطوط أصغر من قبل (titleLarge بدل displaySmall)
  // =========================================================================
  Widget _buildHeader(BuildContext context, Color accent, Color secondary) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 20, height: 1, color: accent),
            const SizedBox(width: 8),
            Text(
              'CONTACT',
              style: textTheme.labelSmall?.copyWith(
                color: accent,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 8),
            Container(width: 20, height: 1, color: accent),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Let's Connect",
          textAlign: TextAlign.center,
          // 👈 كانت displaySmall، بقت titleLarge — أصغر وأنسب لباقي الصفحة
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            "Have a project in mind or looking for a Flutter developer? I'd love to hear from you.",
            textAlign: TextAlign.center,
            // 👈 كانت bodyLarge، بقت bodyMedium
            style: textTheme.bodyMedium?.copyWith(color: secondary, height: 1.5),
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // كارد Get in Touch — padding وخطوط أصغر
  // =========================================================================
  Widget _buildGetInTouchCard(
    BuildContext context,
    Color accent,
    Color divider,
    Color secondary,
    TextTheme textTheme,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      // 👈 كان 32، بقى 24
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.025) : Colors.black.withOpacity(0.018),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: divider.withOpacity(0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GET IN TOUCH',
            style: textTheme.labelSmall?.copyWith(color: accent, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
          const SizedBox(height: 8),
          Text(
            "Let's build something great.",
            // 👈 كانت headlineSmall، بقت titleMedium
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Text(
            "I'm open to freelance projects, internships, and full-time opportunities. "
            "If you have an idea or an opportunity, let's talk.",
            style: textTheme.bodySmall?.copyWith(color: secondary, height: 1.6),
          ),
          const SizedBox(height: 22),
          _contactInfoRow(
            icon: Icons.mail_outline_rounded,
            label: 'EMAIL',
            value: PortfolioData.email,
            accent: accent,
            secondary: secondary,
            textTheme: textTheme,
            onTap: () => _open('mailto:${PortfolioData.email}'),
          ),
          const SizedBox(height: 14),
          _contactInfoRow(
            icon: Icons.location_on_outlined,
            label: 'LOCATION',
            value: PortfolioData.location,
            accent: accent,
            secondary: secondary,
            textTheme: textTheme,
            onTap: null,
          ),
          const SizedBox(height: 22),
          Divider(color: divider, height: 1),
          const SizedBox(height: 18),
          Text(
            'FIND ME ONLINE',
            style: textTheme.labelSmall?.copyWith(color: secondary, letterSpacing: 1.2, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: PortfolioData.socials
                .map((social) => _socialIconButton(
                      icon: _iconForSocial(social.label),
                      onTap: () => _open(social.url),
                      secondary: secondary,
                      divider: divider,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _contactInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color accent,
    required Color secondary,
    required TextTheme textTheme,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Row(
        children: [
          // 👈 كان 44x44، بقى 38x38
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: accent.withOpacity(0.10), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: accent, size: 17),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: textTheme.labelSmall
                        ?.copyWith(color: secondary, letterSpacing: 1, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(value,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color secondary,
    required Color divider,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        // 👈 كان 44x44، بقى 38x38
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: divider)),
          child: Icon(icon, size: 16, color: secondary),
        ),
      ),
    );
  }

  IconData _iconForSocial(String label) {
    final l = label.toLowerCase();
    if (l.contains('github')) return Icons.code;
    if (l.contains('linkedin')) return Icons.business_center_outlined;
    if (l.contains('mail') || l.contains('email')) return Icons.mail_outline_rounded;
    if (l.contains('facebook')) return Icons.facebook_outlined;
    if (l.contains('instagram')) return Icons.camera_alt_outlined;
    if (l.contains('twitter') || l.contains('x')) return Icons.alternate_email;
    if (l.contains('whatsapp')) return Icons.chat_outlined;
    return Icons.link;
  }

  // =========================================================================
  // كارد الفورم — padding وخطوط أصغر
  // =========================================================================
  Widget _buildFormCard(
    BuildContext context,
    Color accent,
    Color divider,
    Color secondary,
    TextTheme textTheme,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      // 👈 كان 32، بقى 24
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.025),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: divider),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Send a message', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text('Tell me a little about your project.',
                style: textTheme.bodySmall?.copyWith(color: secondary)),
            const SizedBox(height: 20),
            LayoutBuilder(builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 480;
              final nameField = _formField(
                label: 'Name',
                hint: 'Your name',
                controller: _nameController,
                secondary: secondary,
                divider: divider,
                accent: accent,
                textTheme: textTheme,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
              );
              final emailField = _formField(
                label: 'Email',
                hint: 'you@example.com',
                controller: _emailController,
                secondary: secondary,
                divider: divider,
                accent: accent,
                textTheme: textTheme,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Please enter your email';
                  if (!v.contains('@')) return 'Please enter a valid email';
                  return null;
                },
              );
              if (isNarrow) {
                return Column(children: [nameField, const SizedBox(height: 16), emailField]);
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: nameField),
                  const SizedBox(width: 16),
                  Expanded(child: emailField),
                ],
              );
            }),
            const SizedBox(height: 16),
            _formField(
              label: 'Subject',
              hint: 'Project discussion',
              controller: _subjectController,
              secondary: secondary,
              divider: divider,
              accent: accent,
              textTheme: textTheme,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a subject' : null,
            ),
            const SizedBox(height: 16),
            _formField(
              label: 'Message',
              hint: 'Tell me about your project...',
              controller: _messageController,
              secondary: secondary,
              divider: divider,
              accent: accent,
              textTheme: textTheme,
              maxLines: 5,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your message' : null,
            ),
            const SizedBox(height: 20),
            _sendButton(accent),
          ],
        ),
      ),
    );
  }

  Widget _formField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required Color secondary,
    required Color divider,
    required Color accent,
    required TextTheme textTheme,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: textTheme.bodySmall,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textTheme.bodySmall?.copyWith(color: secondary.withOpacity(0.5)),
            filled: true,
            fillColor: Colors.transparent,
            // 👈 كان 15، بقى 12
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: divider)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: divider)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: accent, width: 1.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.redAccent)),
          ),
        ),
      ],
    );
  }

  // زرار الإرسال — بيتحول لـ loading spinner وقت الإرسال الفعلي
  Widget _sendButton(Color accent) {
    return SizedBox(
      width: double.infinity,
      // 👈 كان 52، بقى 46
      height: 46,
      child: DecoratedBox(
        decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(12)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _isSending ? null : _handleSend,
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: _isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Send Message',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 📌 خطوات لازم تعملها عشان الإرسال يشتغل فعليًا:
// -----------------------------------------------------------------------------
// 1) في pubspec.yaml ضيف تحت dependencies (لو مش موجودة أصلاً):
//        http: ^1.2.0
//    وبعدها اعمل: flutter pub get
//
// 2) FormSubmit setup (مرة واحدة بس):
//    أول مرة حد يبعت رسالة من الفورم، FormSubmit هيبعت إيميل تأكيد على
//    PortfolioData.email بعنوان "Confirm your submission". افتح الإيميل
//    ده ودوس على رابط "Confirm" اللي جواه. من بعد كده أي رسالة هتتبعت
//    عادي على طول من غير ما يحصل تأكيد تاني.
//    (لو حابب تجرب بسرعة من غير ما تستنى، افتح الرابط ده في المتصفح مرة
//    واحدة: https://formsubmit.co/ahmednaserb9@gmail.com — هيوريك صفحة
//    تأكيد بسيطة).
//
// 3) لو شغال على Flutter Web: لازم الدومين بتاعك (أو localhost وقت
//    التطوير) يكون مسموح بيه CORS، وFormSubmit بيدعم AJAX requests من أي
//    دومين بشكل افتراضي فمفروض يشتغل من غير إعداد إضافي.
//
// البديل: لو حصل أي مشكلة في الإرسال (مثلاً مفيش إنترنت)، الكود بيعرض
// SnackBar فيه زرار "افتح الإيميل" كـ fallback بيفتح mailto: بدل الخدمة.
// =============================================================================