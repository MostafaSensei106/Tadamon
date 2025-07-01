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

  static Future<S> load(Locale locale) {
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

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `تضامن`
  String get appName {
    return Intl.message(
      'تضامن',
      name: 'appName',
      desc: 'اسم التطبيق',
      args: [],
    );
  }

  /// `اللهم الطف بإخواننا، وثبّت أقدامهم، وانصرهم، وأعزّ بفضلك من نصرهم، وأذلّ بقدرتك من خذلهم.`
  String get appDescription {
    return Intl.message(
      'اللهم الطف بإخواننا، وثبّت أقدامهم، وانصرهم، وأعزّ بفضلك من نصرهم، وأذلّ بقدرتك من خذلهم.',
      name: 'appDescription',
      desc: 'وصف التطبيق',
      args: [],
    );
  }

  /// `خطأ في التطبيق`
  String get errorHandle {
    return Intl.message(
      'خطأ في التطبيق',
      name: 'errorHandle',
      desc: 'خطأ في  تطبيق  تضامن',
      args: [],
    );
  }

  /// `لم يتم العثور على الصفحة`
  String get noPage {
    return Intl.message(
      'لم يتم العثور على الصفحة',
      name: 'noPage',
      desc: 'لم يتم العثور على الصفحة',
      args: [],
    );
  }

  /// `لم يتم العثور على الصفحة`
  String get noRoutes {
    return Intl.message(
      'لم يتم العثور على الصفحة',
      name: 'noRoutes',
      desc: 'لم يتم العثور على الصفحة',
      args: [],
    );
  }

  /// ` الرجوع`
  String get back {
    return Intl.message(' الرجوع', name: 'back', desc: 'زر الرجوع', args: []);
  }

  /// `الرئيسية`
  String get home {
    return Intl.message(
      'الرئيسية',
      name: 'home',
      desc: 'العنوان الرئيسي في التطبيق',
      args: [],
    );
  }

  /// `بحث`
  String get search {
    return Intl.message('بحث', name: 'search', desc: 'زر البحث', args: []);
  }

  /// `السجلات`
  String get logs {
    return Intl.message(
      'السجلات',
      name: 'logs',
      desc: 'صفحة السجلات',
      args: [],
    );
  }

  /// `فحص الباركود`
  String get scanBarcode {
    return Intl.message(
      'فحص الباركود',
      name: 'scanBarcode',
      desc: 'زر فحص الباركود',
      args: [],
    );
  }

  /// `تحليل الصور`
  String get imageAnalysis {
    return Intl.message(
      'تحليل الصور',
      name: 'imageAnalysis',
      desc: 'تحليل الصور',
      args: [],
    );
  }

  /// `تعديل النص`
  String get editText {
    return Intl.message(
      'تعديل النص',
      name: 'editText',
      desc: 'تعديل النصوص',
      args: [],
    );
  }

  /// `خريطة فلسطين`
  String get palatineMap {
    return Intl.message(
      'خريطة فلسطين',
      name: 'palatineMap',
      desc: 'خريطة فلسطين',
      args: [],
    );
  }

  /// `تبرع لغزة`
  String get donate {
    return Intl.message(
      'تبرع لغزة',
      name: 'donate',
      desc: 'زر التبرع لغزة',
      args: [],
    );
  }

  /// `المنتجات التي تمت مراجعتها`
  String get scanedProducts {
    return Intl.message(
      'المنتجات التي تمت مراجعتها',
      name: 'scanedProducts',
      desc: 'عدد المنتجات التي تمت مراجعتها',
      args: [],
    );
  }

  /// `المنتجات التي تم دعمها`
  String get supportedProducts {
    return Intl.message(
      'المنتجات التي تم دعمها',
      name: 'supportedProducts',
      desc: 'عدد المنتجات التي تم دعمها',
      args: [],
    );
  }

  /// `لون واجهة التطبيق`
  String get systemTheme {
    return Intl.message(
      'لون واجهة التطبيق',
      name: 'systemTheme',
      desc: 'إعدادات لون الواجهة',
      args: [],
    );
  }

  /// `مطابقة لون النظام`
  String get followSystemTheme {
    return Intl.message(
      'مطابقة لون النظام',
      name: 'followSystemTheme',
      desc: 'مطابقة لون التطبيق مع النظام',
      args: [],
    );
  }

  /// `الوضع الداكن`
  String get darkTheme {
    return Intl.message(
      'الوضع الداكن',
      name: 'darkTheme',
      desc: 'الوضع الداكن',
      args: [],
    );
  }

  /// `الوضع الفاتح`
  String get lightTheme {
    return Intl.message(
      'الوضع الفاتح',
      name: 'lightTheme',
      desc: 'الوضع الفاتح',
      args: [],
    );
  }

  /// `التبديل إلى الوضع الداكن`
  String get switchToDarkTheme {
    return Intl.message(
      'التبديل إلى الوضع الداكن',
      name: 'switchToDarkTheme',
      desc: 'التبديل إلى الوضع الداكن',
      args: [],
    );
  }

  /// `التبديل إلى الوضع الفاتح`
  String get switchToLightTheme {
    return Intl.message(
      'التبديل إلى الوضع الفاتح',
      name: 'switchToLightTheme',
      desc: 'التبديل إلى الوضع الفاتح',
      args: [],
    );
  }

  /// `تضامن دون إنترنت`
  String get appOffLine {
    return Intl.message(
      'تضامن دون إنترنت',
      name: 'appOffLine',
      desc: 'حالة التطبيق عند عدم الاتصال بالإنترنت',
      args: [],
    );
  }

  /// `التطبيق غير متصل.`
  String get appOffLineMassageDontRunning {
    return Intl.message(
      'التطبيق غير متصل.',
      name: 'appOffLineMassageDontRunning',
      desc: 'رسالة عدم الاتصال بالإنترنت',
      args: [],
    );
  }

  /// `التطبيق يعمل بنجاح.`
  String get appOnLineMassageRunning {
    return Intl.message(
      'التطبيق يعمل بنجاح.',
      name: 'appOnLineMassageRunning',
      desc: 'رسالة نجاح تشغيل التطبيق',
      args: [],
    );
  }

  /// `انتظر ...`
  String get appOflineLoading {
    return Intl.message(
      'انتظر ...',
      name: 'appOflineLoading',
      desc: 'تحميل بيانات التطبيق دون اتصال',
      args: [],
    );
  }

  /// `تحميل قائمة المنتجات`
  String get enableOnline {
    return Intl.message(
      'تحميل قائمة المنتجات',
      name: 'enableOnline',
      desc: 'تحميل قائمة المنتجات',
      args: [],
    );
  }

  /// `تشغيل التطبيق بدون إنترنت.`
  String get enableOnlineMassage {
    return Intl.message(
      'تشغيل التطبيق بدون إنترنت.',
      name: 'enableOnlineMassage',
      desc: 'رسالة عند تشغيل التطبيق بدون إنترنت',
      args: [],
    );
  }

  /// `حذف السجلات`
  String get clearLogs {
    return Intl.message(
      'حذف السجلات',
      name: 'clearLogs',
      desc: 'حذف السجلات',
      args: [],
    );
  }

  /// `مسح سجلات المنتجات في التطبيق.`
  String get clearLogsMassage {
    return Intl.message(
      'مسح سجلات المنتجات في التطبيق.',
      name: 'clearLogsMassage',
      desc: 'مسح سجلات المنتجات في التطبيق',
      args: [],
    );
  }

  /// `الأسئلة الشائعة`
  String get howToUse {
    return Intl.message(
      'الأسئلة الشائعة',
      name: 'howToUse',
      desc: 'الأسئلة الشائعة',
      args: [],
    );
  }

  /// `تعرف على طريقة استخدام التطبيق.`
  String get howToUseMassage {
    return Intl.message(
      'تعرف على طريقة استخدام التطبيق.',
      name: 'howToUseMassage',
      desc: 'طريقة استخدام التطبيق',
      args: [],
    );
  }

  /// `الإبلاغ عن منتج`
  String get reportProduct {
    return Intl.message(
      'الإبلاغ عن منتج',
      name: 'reportProduct',
      desc: 'الإبلاغ عن منتج',
      args: [],
    );
  }

  /// `ساعدنا في تحسين التطبيق.`
  String get reportProductMassage {
    return Intl.message(
      'ساعدنا في تحسين التطبيق.',
      name: 'reportProductMassage',
      desc: 'مساعدة في تحسين التطبيق',
      args: [],
    );
  }

  /// `تجريبي`
  String get test {
    return Intl.message('تجريبي', name: 'test', desc: 'اختبار', args: []);
  }

  /// `تفاصيل المنتج`
  String get sheetTitleProductInfo {
    return Intl.message(
      'تفاصيل المنتج',
      name: 'sheetTitleProductInfo',
      desc: 'عنوان تفاصيل المنتج',
      args: [],
    );
  }

  /// `المطور`
  String get developer {
    return Intl.message(
      'المطور',
      name: 'developer',
      desc: 'اسم المطور',
      args: [],
    );
  }

  /// `Mostafa Mahmoud`
  String get mostafaMahmoud {
    return Intl.message(
      'Mostafa Mahmoud',
      name: 'mostafaMahmoud',
      desc: 'اسم المطور بالكامل',
      args: [],
    );
  }

  /// `ReadMe`
  String get readMe {
    return Intl.message(
      'ReadMe',
      name: 'readMe',
      desc: 'زر قراءة مستند المشروع',
      args: [],
    );
  }

  /// `رابط إلى مستودع التطبيق على جيت هاب.`
  String get readMeMassage {
    return Intl.message(
      'رابط إلى مستودع التطبيق على جيت هاب.',
      name: 'readMeMassage',
      desc: 'رابط إلى مستودع التطبيق على جيت هاب',
      args: [],
    );
  }

  /// `آخر التحديثات`
  String get letastUpdate {
    return Intl.message(
      'آخر التحديثات',
      name: 'letastUpdate',
      desc: 'آخر التحديثات',
      args: [],
    );
  }

  /// `اطلع على التحديثات وسجل التغييرات.`
  String get letestUpdateMassage {
    return Intl.message(
      'اطلع على التحديثات وسجل التغييرات.',
      name: 'letestUpdateMassage',
      desc: 'تفاصيل آخر تحديث',
      args: [],
    );
  }

  /// `تذكرة على جيت هاب`
  String get githubTiket {
    return Intl.message(
      'تذكرة على جيت هاب',
      name: 'githubTiket',
      desc: 'إنشاء تذكرة على جيت هاب',
      args: [],
    );
  }

  /// `الإبلاغ عن خطأ أو اقتراح ميزة جديدة.`
  String get githubTiketMassage {
    return Intl.message(
      'الإبلاغ عن خطأ أو اقتراح ميزة جديدة.',
      name: 'githubTiketMassage',
      desc: 'الإبلاغ عن خطأ أو اقتراح ميزة جديدة',
      args: [],
    );
  }

  /// `قناة تلغرام`
  String get telegramChannel {
    return Intl.message(
      'قناة تلغرام',
      name: 'telegramChannel',
      desc: 'قناة تلغرام',
      args: [],
    );
  }

  /// `رابط إلى قناة تلغرام.`
  String get telegramChannelMassage {
    return Intl.message(
      'رابط إلى قناة تلغرام.',
      name: 'telegramChannelMassage',
      desc: 'رابط إلى قناة تلغرام',
      args: [],
    );
  }

  /// `معلومات عن التطبيق`
  String get about {
    return Intl.message(
      'معلومات عن التطبيق',
      name: 'about',
      desc: 'صفحة معلومات عن التطبيق',
      args: [],
    );
  }

  /// `حول تطبيق تضامن.`
  String get aboutTadamon {
    return Intl.message(
      'حول تطبيق تضامن.',
      name: 'aboutTadamon',
      desc: 'حول تطبيق تضامن',
      args: [],
    );
  }

  /// `رسالة من المطور`
  String get contactDev {
    return Intl.message(
      'رسالة من المطور',
      name: 'contactDev',
      desc: 'زر التواصل مع المطور',
      args: [],
    );
  }

  /// `لا توجد رسالة حالياً.`
  String get devMassage {
    return Intl.message(
      'لا توجد رسالة حالياً.',
      name: 'devMassage',
      desc: 'رسالة المطور',
      args: [],
    );
  }

  /// `شكراً لاستخدام تطبيق تضامن.`
  String get devThx {
    return Intl.message(
      'شكراً لاستخدام تطبيق تضامن.',
      name: 'devThx',
      desc: 'شكر من المطور',
      args: [],
    );
  }

  /// `ادعم المطور.`
  String get devDonate {
    return Intl.message(
      'ادعم المطور.',
      name: 'devDonate',
      desc: 'التبرع للمطور',
      args: [],
    );
  }

  /// `تابعني على مواقع التواصل الاجتماعي.`
  String get contactDevMassage {
    return Intl.message(
      'تابعني على مواقع التواصل الاجتماعي.',
      name: 'contactDevMassage',
      desc: 'طرق التواصل مع المطور',
      args: [],
    );
  }

  /// `إغلاق`
  String get close {
    return Intl.message('إغلاق', name: 'close', desc: 'زر الإغلاق', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'ar')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
