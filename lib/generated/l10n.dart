// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(final Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(final BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(final BuildContext context) => Localizations.of<S>(context, S);

  /// `تضامن`
  String get appName => Intl.message(
      'تضامن',
      name: 'appName',
      desc: 'اسم التطبيق',
      args: [],
    );

  /// `اللهم الطف بإخواننا، وثبّت أقدامهم، وانصرهم، وأعزّ بفضلك من نصرهم، وأذلّ بقدرتك من خذلهم.`
  String get appDescription => Intl.message(
      'اللهم الطف بإخواننا، وثبّت أقدامهم، وانصرهم، وأعزّ بفضلك من نصرهم، وأذلّ بقدرتك من خذلهم.',
      name: 'appDescription',
      desc: 'وصف التطبيق',
      args: [],
    );

  /// `خطأ في التطبيق`
  String get errorHandle => Intl.message(
      'خطأ في التطبيق',
      name: 'errorHandle',
      desc: 'خطأ في  تطبيق  تضامن',
      args: [],
    );

  /// `لم يتم العثور على الصفحة`
  String get noPage => Intl.message(
      'لم يتم العثور على الصفحة',
      name: 'noPage',
      desc: 'لم يتم العثور على الصفحة',
      args: [],
    );

  /// `لم يتم العثور على الصفحة`
  String get noRoutes => Intl.message(
      'لم يتم العثور على الصفحة',
      name: 'noRoutes',
      desc: 'لم يتم العثور على الصفحة',
      args: [],
    );

  /// ` الرجوع`
  String get back => Intl.message(' الرجوع', name: 'back', desc: 'زر الرجوع', args: []);

  /// `الرئيسية`
  String get home => Intl.message(
      'الرئيسية',
      name: 'home',
      desc: 'العنوان الرئيسي في التطبيق',
      args: [],
    );

  /// `بحث`
  String get search => Intl.message('بحث', name: 'search', desc: 'زر البحث', args: []);

  /// `السجلات`
  String get logs => Intl.message(
      'السجلات',
      name: 'logs',
      desc: 'صفحة السجلات',
      args: [],
    );

  /// `فحص الباركود`
  String get scanBarcode => Intl.message(
      'فحص الباركود',
      name: 'scanBarcode',
      desc: 'زر فحص الباركود',
      args: [],
    );

  /// `تحليل الصور`
  String get imageAnalysis => Intl.message(
      'تحليل الصور',
      name: 'imageAnalysis',
      desc: 'تحليل الصور',
      args: [],
    );

  /// `تعديل النص`
  String get editText => Intl.message(
      'تعديل النص',
      name: 'editText',
      desc: 'تعديل النصوص',
      args: [],
    );

  /// `خريطة فلسطين`
  String get palatineMap => Intl.message(
      'خريطة فلسطين',
      name: 'palatineMap',
      desc: 'خريطة فلسطين',
      args: [],
    );

  /// `تبرع لغزة`
  String get donate => Intl.message(
      'تبرع لغزة',
      name: 'donate',
      desc: 'زر التبرع لغزة',
      args: [],
    );

  /// `المنتجات التي تمت مراجعتها`
  String get scanedProducts => Intl.message(
      'المنتجات التي تمت مراجعتها',
      name: 'scanedProducts',
      desc: 'عدد المنتجات التي تمت مراجعتها',
      args: [],
    );

  /// `المنتجات التي تم دعمها`
  String get supportedProducts => Intl.message(
      'المنتجات التي تم دعمها',
      name: 'supportedProducts',
      desc: 'عدد المنتجات التي تم دعمها',
      args: [],
    );

  /// `لون واجهة التطبيق`
  String get systemTheme => Intl.message(
      'لون واجهة التطبيق',
      name: 'systemTheme',
      desc: 'إعدادات لون الواجهة',
      args: [],
    );

  /// `مطابقة لون النظام`
  String get followSystemTheme => Intl.message(
      'مطابقة لون النظام',
      name: 'followSystemTheme',
      desc: 'مطابقة لون التطبيق مع النظام',
      args: [],
    );

  /// `الوضع الداكن`
  String get darkTheme => Intl.message(
      'الوضع الداكن',
      name: 'darkTheme',
      desc: 'الوضع الداكن',
      args: [],
    );

  /// `الوضع الفاتح`
  String get lightTheme => Intl.message(
      'الوضع الفاتح',
      name: 'lightTheme',
      desc: 'الوضع الفاتح',
      args: [],
    );

  /// `التبديل إلى الوضع الداكن`
  String get switchToDarkTheme => Intl.message(
      'التبديل إلى الوضع الداكن',
      name: 'switchToDarkTheme',
      desc: 'التبديل إلى الوضع الداكن',
      args: [],
    );

  /// `التبديل إلى الوضع الفاتح`
  String get switchToLightTheme => Intl.message(
      'التبديل إلى الوضع الفاتح',
      name: 'switchToLightTheme',
      desc: 'التبديل إلى الوضع الفاتح',
      args: [],
    );

  /// `تضامن دون إنترنت`
  String get appOffLine => Intl.message(
      'تضامن دون إنترنت',
      name: 'appOffLine',
      desc: 'حالة التطبيق عند عدم الاتصال بالإنترنت',
      args: [],
    );

  /// `التطبيق غير متصل.`
  String get appOffLineMassageDontRunning => Intl.message(
      'التطبيق غير متصل.',
      name: 'appOffLineMassageDontRunning',
      desc: 'رسالة عدم الاتصال بالإنترنت',
      args: [],
    );

  /// `التطبيق يعمل بنجاح.`
  String get appOnLineMassageRunning => Intl.message(
      'التطبيق يعمل بنجاح.',
      name: 'appOnLineMassageRunning',
      desc: 'رسالة نجاح تشغيل التطبيق',
      args: [],
    );

  /// `انتظر ...`
  String get appOflineLoading => Intl.message(
      'انتظر ...',
      name: 'appOflineLoading',
      desc: 'تحميل بيانات التطبيق دون اتصال',
      args: [],
    );

  /// `تحميل قائمة المنتجات`
  String get enableOnline => Intl.message(
      'تحميل قائمة المنتجات',
      name: 'enableOnline',
      desc: 'تحميل قائمة المنتجات',
      args: [],
    );

  /// `تشغيل التطبيق بدون إنترنت.`
  String get enableOnlineMassage => Intl.message(
      'تشغيل التطبيق بدون إنترنت.',
      name: 'enableOnlineMassage',
      desc: 'رسالة عند تشغيل التطبيق بدون إنترنت',
      args: [],
    );

  /// `حذف السجلات`
  String get clearLogs => Intl.message(
      'حذف السجلات',
      name: 'clearLogs',
      desc: 'حذف السجلات',
      args: [],
    );

  /// `مسح سجلات المنتجات في التطبيق.`
  String get clearLogsMassage => Intl.message(
      'مسح سجلات المنتجات في التطبيق.',
      name: 'clearLogsMassage',
      desc: 'مسح سجلات المنتجات في التطبيق',
      args: [],
    );

  /// `الأسئلة الشائعة`
  String get howToUse => Intl.message(
      'الأسئلة الشائعة',
      name: 'howToUse',
      desc: 'الأسئلة الشائعة',
      args: [],
    );

  /// `تعرف على طريقة استخدام التطبيق.`
  String get howToUseMassage => Intl.message(
      'تعرف على طريقة استخدام التطبيق.',
      name: 'howToUseMassage',
      desc: 'طريقة استخدام التطبيق',
      args: [],
    );

  /// `الإبلاغ عن منتج`
  String get reportProduct => Intl.message(
      'الإبلاغ عن منتج',
      name: 'reportProduct',
      desc: 'الإبلاغ عن منتج',
      args: [],
    );

  /// `ساعدنا في تحسين التطبيق.`
  String get reportProductMassage => Intl.message(
      'ساعدنا في تحسين التطبيق.',
      name: 'reportProductMassage',
      desc: 'مساعدة في تحسين التطبيق',
      args: [],
    );

  /// `تجريبي`
  String get test => Intl.message('تجريبي', name: 'test', desc: 'اختبار', args: []);

  /// `تفاصيل المنتج`
  String get sheetTitleProductInfo => Intl.message(
      'تفاصيل المنتج',
      name: 'sheetTitleProductInfo',
      desc: 'عنوان تفاصيل المنتج',
      args: [],
    );

  /// `المطور`
  String get developer => Intl.message(
      'المطور',
      name: 'developer',
      desc: 'اسم المطور',
      args: [],
    );

  /// `Mostafa Mahmoud`
  String get mostafaMahmoud => Intl.message(
      'Mostafa Mahmoud',
      name: 'mostafaMahmoud',
      desc: 'اسم المطور بالكامل',
      args: [],
    );

  /// `ReadMe`
  String get readMe => Intl.message(
      'ReadMe',
      name: 'readMe',
      desc: 'زر قراءة مستند المشروع',
      args: [],
    );

  /// `رابط إلى مستودع التطبيق على جيت هاب.`
  String get readMeMassage => Intl.message(
      'رابط إلى مستودع التطبيق على جيت هاب.',
      name: 'readMeMassage',
      desc: 'رابط إلى مستودع التطبيق على جيت هاب',
      args: [],
    );

  /// `آخر التحديثات`
  String get letastUpdate => Intl.message(
      'آخر التحديثات',
      name: 'letastUpdate',
      desc: 'آخر التحديثات',
      args: [],
    );

  /// `اطلع على التحديثات وسجل التغييرات.`
  String get letestUpdateMassage => Intl.message(
      'اطلع على التحديثات وسجل التغييرات.',
      name: 'letestUpdateMassage',
      desc: 'تفاصيل آخر تحديث',
      args: [],
    );

  /// `تذكرة على جيت هاب`
  String get githubTiket => Intl.message(
      'تذكرة على جيت هاب',
      name: 'githubTiket',
      desc: 'إنشاء تذكرة على جيت هاب',
      args: [],
    );

  /// `الإبلاغ عن خطأ أو اقتراح ميزة جديدة.`
  String get githubTiketMassage => Intl.message(
      'الإبلاغ عن خطأ أو اقتراح ميزة جديدة.',
      name: 'githubTiketMassage',
      desc: 'الإبلاغ عن خطأ أو اقتراح ميزة جديدة',
      args: [],
    );

  /// `قناة تلغرام`
  String get telegramChannel => Intl.message(
      'قناة تلغرام',
      name: 'telegramChannel',
      desc: 'قناة تلغرام',
      args: [],
    );

  /// `رابط إلى قناة تلغرام.`
  String get telegramChannelMassage => Intl.message(
      'رابط إلى قناة تلغرام.',
      name: 'telegramChannelMassage',
      desc: 'رابط إلى قناة تلغرام',
      args: [],
    );

  /// `معلومات عن التطبيق`
  String get about => Intl.message(
      'معلومات عن التطبيق',
      name: 'about',
      desc: 'صفحة معلومات عن التطبيق',
      args: [],
    );

  /// `حول تطبيق تضامن.`
  String get aboutTadamon => Intl.message(
      'حول تطبيق تضامن.',
      name: 'aboutTadamon',
      desc: 'حول تطبيق تضامن',
      args: [],
    );

  /// `رسالة من المطور`
  String get contactDev => Intl.message(
      'رسالة من المطور',
      name: 'contactDev',
      desc: 'زر التواصل مع المطور',
      args: [],
    );

  /// `لا توجد رسالة حالياً.`
  String get devMassage => Intl.message(
      'لا توجد رسالة حالياً.',
      name: 'devMassage',
      desc: 'رسالة المطور',
      args: [],
    );

  /// `شكراً لاستخدام تطبيق تضامن.`
  String get devThx => Intl.message(
      'شكراً لاستخدام تطبيق تضامن.',
      name: 'devThx',
      desc: 'شكر من المطور',
      args: [],
    );

  /// `ادعم المطور.`
  String get devDonate => Intl.message(
      'ادعم المطور.',
      name: 'devDonate',
      desc: 'التبرع للمطور',
      args: [],
    );

  /// `تابعني على مواقع التواصل الاجتماعي.`
  String get contactDevMassage => Intl.message(
      'تابعني على مواقع التواصل الاجتماعي.',
      name: 'contactDevMassage',
      desc: 'طرق التواصل مع المطور',
      args: [],
    );

  /// `إغلاق`
  String get close => Intl.message('إغلاق', name: 'close', desc: 'زر الإغلاق', args: []);
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales => const <Locale>[Locale.fromSubtags(languageCode: 'ar')];

  @override
  bool isSupported(final Locale locale) => _isSupported(locale);
  @override
  Future<S> load(final Locale locale) => S.load(locale);
  @override
  bool shouldReload(final AppLocalizationDelegate old) => false;

  bool _isSupported(final Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
