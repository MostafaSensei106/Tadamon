import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ar')];

  /// اسم التطبيق
  ///
  /// In ar, this message translates to:
  /// **'تضامن'**
  String get appName;

  /// وصف التطبيق
  ///
  /// In ar, this message translates to:
  /// **'اللهم الطف بإخواننا، وثبّت أقدامهم، وانصرهم، وأعزّ بفضلك من نصرهم، وأذلّ بقدرتك من خذلهم.'**
  String get appDescription;

  /// خطأ في  تطبيق  تضامن
  ///
  /// In ar, this message translates to:
  /// **'خطأ في التطبيق'**
  String get errorHandle;

  /// لم يتم العثور على الصفحة
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على الصفحة'**
  String get noPage;

  /// لم يتم العثور على الصفحة
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على الصفحة'**
  String get noRoutes;

  /// زر الرجوع
  ///
  /// In ar, this message translates to:
  /// **' الرجوع'**
  String get back;

  /// العنوان الرئيسي في التطبيق
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// زر البحث
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get search;

  /// صفحة السجلات
  ///
  /// In ar, this message translates to:
  /// **'السجلات'**
  String get logs;

  /// زر فحص الباركود
  ///
  /// In ar, this message translates to:
  /// **'فحص الباركود'**
  String get scanBarcode;

  /// تحليل الصور
  ///
  /// In ar, this message translates to:
  /// **'تحليل الصور'**
  String get imageAnalysis;

  /// تعديل النصوص
  ///
  /// In ar, this message translates to:
  /// **'تعديل النص'**
  String get editText;

  /// خريطة فلسطين
  ///
  /// In ar, this message translates to:
  /// **'خريطة فلسطين'**
  String get palatineMap;

  /// زر التبرع لغزة
  ///
  /// In ar, this message translates to:
  /// **'تبرع لغزة'**
  String get donate;

  /// عدد المنتجات التي تمت مراجعتها
  ///
  /// In ar, this message translates to:
  /// **'المنتجات التي تمت مراجعتها'**
  String get scanedProducts;

  /// عدد المنتجات التي تم دعمها
  ///
  /// In ar, this message translates to:
  /// **'المنتجات التي تم دعمها'**
  String get supportedProducts;

  /// إعدادات لون الواجهة
  ///
  /// In ar, this message translates to:
  /// **'لون واجهة التطبيق'**
  String get systemTheme;

  /// مطابقة لون التطبيق مع النظام
  ///
  /// In ar, this message translates to:
  /// **'مطابقة لون النظام'**
  String get followSystemTheme;

  /// الوضع الداكن
  ///
  /// In ar, this message translates to:
  /// **'الوضع الداكن'**
  String get darkTheme;

  /// الوضع الفاتح
  ///
  /// In ar, this message translates to:
  /// **'الوضع الفاتح'**
  String get lightTheme;

  /// التبديل إلى الوضع الداكن
  ///
  /// In ar, this message translates to:
  /// **'التبديل إلى الوضع الداكن'**
  String get switchToDarkTheme;

  /// التبديل إلى الوضع الفاتح
  ///
  /// In ar, this message translates to:
  /// **'التبديل إلى الوضع الفاتح'**
  String get switchToLightTheme;

  /// حالة التطبيق عند عدم الاتصال بالإنترنت
  ///
  /// In ar, this message translates to:
  /// **'تضامن دون إنترنت'**
  String get appOffLine;

  /// رسالة عدم الاتصال بالإنترنت
  ///
  /// In ar, this message translates to:
  /// **'التطبيق غير متصل.'**
  String get appOffLineMassageDontRunning;

  /// رسالة نجاح تشغيل التطبيق
  ///
  /// In ar, this message translates to:
  /// **'التطبيق يعمل بنجاح.'**
  String get appOnLineMassageRunning;

  /// تحميل بيانات التطبيق دون اتصال
  ///
  /// In ar, this message translates to:
  /// **'انتظر ...'**
  String get appOflineLoading;

  /// تحميل قائمة المنتجات
  ///
  /// In ar, this message translates to:
  /// **'تحميل قائمة المنتجات'**
  String get enableOnline;

  /// رسالة عند تشغيل التطبيق بدون إنترنت
  ///
  /// In ar, this message translates to:
  /// **'تشغيل التطبيق بدون إنترنت.'**
  String get enableOnlineMassage;

  /// حذف السجلات
  ///
  /// In ar, this message translates to:
  /// **'حذف السجلات'**
  String get clearLogs;

  /// مسح سجلات المنتجات في التطبيق
  ///
  /// In ar, this message translates to:
  /// **'مسح سجلات المنتجات في التطبيق.'**
  String get clearLogsMassage;

  /// الأسئلة الشائعة
  ///
  /// In ar, this message translates to:
  /// **'الأسئلة الشائعة'**
  String get howToUse;

  /// طريقة استخدام التطبيق
  ///
  /// In ar, this message translates to:
  /// **'تعرف على طريقة استخدام التطبيق.'**
  String get howToUseMassage;

  /// الإبلاغ عن منتج
  ///
  /// In ar, this message translates to:
  /// **'الإبلاغ عن منتج'**
  String get reportProduct;

  /// مساعدة في تحسين التطبيق
  ///
  /// In ar, this message translates to:
  /// **'ساعدنا في تحسين التطبيق.'**
  String get reportProductMassage;

  /// اختبار
  ///
  /// In ar, this message translates to:
  /// **'تجريبي'**
  String get test;

  /// عنوان تفاصيل المنتج
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل المنتج'**
  String get sheetTitleProductInfo;

  /// اسم المطور
  ///
  /// In ar, this message translates to:
  /// **'المطور'**
  String get developer;

  /// اسم المطور بالكامل
  ///
  /// In ar, this message translates to:
  /// **'Mostafa Mahmoud'**
  String get mostafaMahmoud;

  /// زر قراءة مستند المشروع
  ///
  /// In ar, this message translates to:
  /// **'ReadMe'**
  String get readMe;

  /// رابط إلى مستودع التطبيق على جيت هاب
  ///
  /// In ar, this message translates to:
  /// **'رابط إلى مستودع التطبيق على جيت هاب.'**
  String get readMeMassage;

  /// آخر التحديثات
  ///
  /// In ar, this message translates to:
  /// **'آخر التحديثات'**
  String get letastUpdate;

  /// تفاصيل آخر تحديث
  ///
  /// In ar, this message translates to:
  /// **'اطلع على التحديثات وسجل التغييرات.'**
  String get letestUpdateMassage;

  /// إنشاء تذكرة على جيت هاب
  ///
  /// In ar, this message translates to:
  /// **'تذكرة على جيت هاب'**
  String get githubTiket;

  /// الإبلاغ عن خطأ أو اقتراح ميزة جديدة
  ///
  /// In ar, this message translates to:
  /// **'الإبلاغ عن خطأ أو اقتراح ميزة جديدة.'**
  String get githubTiketMassage;

  /// قناة تلغرام
  ///
  /// In ar, this message translates to:
  /// **'قناة تلغرام'**
  String get telegramChannel;

  /// رابط إلى قناة تلغرام
  ///
  /// In ar, this message translates to:
  /// **'رابط إلى قناة تلغرام.'**
  String get telegramChannelMassage;

  /// صفحة معلومات عن التطبيق
  ///
  /// In ar, this message translates to:
  /// **'معلومات عن التطبيق'**
  String get about;

  /// حول تطبيق تضامن
  ///
  /// In ar, this message translates to:
  /// **'حول تطبيق تضامن.'**
  String get aboutTadamon;

  /// زر التواصل مع المطور
  ///
  /// In ar, this message translates to:
  /// **'رسالة من المطور'**
  String get contactDev;

  /// رسالة المطور
  ///
  /// In ar, this message translates to:
  /// **'لا توجد رسالة حالياً.'**
  String get devMassage;

  /// شكر من المطور
  ///
  /// In ar, this message translates to:
  /// **'شكراً لاستخدام تطبيق تضامن.'**
  String get devThx;

  /// التبرع للمطور
  ///
  /// In ar, this message translates to:
  /// **'ادعم المطور.'**
  String get devDonate;

  /// طرق التواصل مع المطور
  ///
  /// In ar, this message translates to:
  /// **'تابعني على مواقع التواصل الاجتماعي.'**
  String get contactDevMassage;

  /// زر الإغلاق
  ///
  /// In ar, this message translates to:
  /// **'إغلاق'**
  String get close;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
