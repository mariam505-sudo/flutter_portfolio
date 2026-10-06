# البورتفوليو بتاعك — Flutter

تطبيق بورتفوليو شغال على الموبايل والويب من نفس الكود، بستايل "Engineering Blueprint"
(خلفية داكنة + خط دهبي + شبكة خطوط خفيفة زي ورقة مخططات هندسية)، مع خيار تبديل لثيم فاتح.

## إزاي تشغله

1. لازم يكون عندك Flutter SDK متثبت ([flutter.dev](https://flutter.dev/docs/get-started/install)).
2. من جوه فولدر المشروع:
   ```bash
   flutter pub get
   ```
3. تشغيل على الموبايل (محتاج جهاز حقيقي أو إيموليتور شغال):
   ```bash
   flutter run
   ```
4. تشغيل على الويب:
   ```bash
   flutter run -d chrome
   ```
5. عمل بيلد لنشر الويب (النتيجة هتبقى في `build/web`):
   ```bash
   flutter build web
   ```

## إزاي تعدّل المحتوى (بياناتك انت)

كل المحتوى موجود في ملف واحد بس:
```
lib/data/portfolio_data.dart
```
غيّر فيه: الاسم، المسمى الوظيفي، النبذة، الخبرات، المشاريع، المهارات،
التعليم، الشهادات، والروابط (GitHub / LinkedIn / Email). مش محتاج تلمس
أي ملف تاني عشان تحدّث المحتوى.

## إزاي تغيّر الألوان

الألوان كلها في:
```
lib/theme/app_colors.dart
```
فيه نسختين: Dark و Light. لو عايز تغيّر لون الأكسنت (الدهبي/الطوبي)
غيّر قيمة `accentGold` (Dark) و `accentRust` (Light).

## هيكل المشروع

```
lib/
  main.dart                 # نقطة البداية + إدارة الثيم
  theme/                    # الألوان والخطوط
  data/portfolio_data.dart  # كل المحتوى (عدّل هنا بس)
  widgets/                  # عناصر قابلة لإعادة الاستخدام (كارت مشروع، تايم لاين، نفيجيشن...)
  sections/                 # الأقسام: Hero, About, Experience, Projects, Skills, Education, Certifications
  screens/portfolio_screen.dart  # تجميع الأقسام + الـ layout المتجاوب
```

## إضافة صورة شخصية أو لوجوهات مشاريع

1. حط الصور في `assets/images/`.
2. سيب الكومنت اللي في `pubspec.yaml` تحت `flutter:` وحط:
   ```yaml
   assets:
     - assets/images/
   ```
3. استخدمها بـ `Image.asset('assets/images/your-photo.png')`.

## ملاحظة عن اللغة

المحتوى التجريبي مكتوب عربي/إنجليزي مختلط زي أغلب البورتفوليوهات المهنية
(عناوين الأقسام عربي، محتوى تقني إنجليزي). غيّره زي ما يريحك.
