import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Tadamon'**
  String get appName;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'O Allah, be gentle with our brothers, make their feet firm, grant them victory, and honor those who support them with Your grace, and humiliate those who let them down with Your power.'**
  String get appDescription;

  /// No description provided for @errorHandle.
  ///
  /// In en, this message translates to:
  /// **'Application Error'**
  String get errorHandle;

  /// No description provided for @noPage.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get noPage;

  /// No description provided for @noRoutes.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get noRoutes;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @logs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get logs;

  /// No description provided for @scanBarcode.
  ///
  /// In en, this message translates to:
  /// **'Scan Barcode'**
  String get scanBarcode;

  /// No description provided for @imageAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Image Analysis'**
  String get imageAnalysis;

  /// No description provided for @editText.
  ///
  /// In en, this message translates to:
  /// **'Edit Text'**
  String get editText;

  /// No description provided for @palatineMap.
  ///
  /// In en, this message translates to:
  /// **'Palestine Map'**
  String get palatineMap;

  /// No description provided for @donate.
  ///
  /// In en, this message translates to:
  /// **'Donate to Gaza'**
  String get donate;

  /// No description provided for @scanedProducts.
  ///
  /// In en, this message translates to:
  /// **'Reviewed Products'**
  String get scanedProducts;

  /// No description provided for @supportedProducts.
  ///
  /// In en, this message translates to:
  /// **'Supported Products'**
  String get supportedProducts;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'App Interface Color'**
  String get systemTheme;

  /// No description provided for @followSystemTheme.
  ///
  /// In en, this message translates to:
  /// **'Match System Theme'**
  String get followSystemTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightTheme;

  /// No description provided for @switchToDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch to Dark Mode'**
  String get switchToDarkTheme;

  /// No description provided for @switchToLightTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch to Light Mode'**
  String get switchToLightTheme;

  /// No description provided for @appOffLine.
  ///
  /// In en, this message translates to:
  /// **'Tadamon Offline'**
  String get appOffLine;

  /// No description provided for @appOffLineMassageDontRunning.
  ///
  /// In en, this message translates to:
  /// **'The application is not connected.'**
  String get appOffLineMassageDontRunning;

  /// No description provided for @appOnLineMassageRunning.
  ///
  /// In en, this message translates to:
  /// **'The application is running successfully.'**
  String get appOnLineMassageRunning;

  /// No description provided for @appOflineLoading.
  ///
  /// In en, this message translates to:
  /// **'Wait...'**
  String get appOflineLoading;

  /// No description provided for @enableOnline.
  ///
  /// In en, this message translates to:
  /// **'Load Product List'**
  String get enableOnline;

  /// No description provided for @enableOnlineMassage.
  ///
  /// In en, this message translates to:
  /// **'Running the application offline.'**
  String get enableOnlineMassage;

  /// No description provided for @clearLogs.
  ///
  /// In en, this message translates to:
  /// **'Clear Logs'**
  String get clearLogs;

  /// No description provided for @clearLogsMassage.
  ///
  /// In en, this message translates to:
  /// **'Clear product logs in the application.'**
  String get clearLogsMassage;

  /// No description provided for @howToUse.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get howToUse;

  /// No description provided for @howToUseMassage.
  ///
  /// In en, this message translates to:
  /// **'Learn how to use the application.'**
  String get howToUseMassage;

  /// No description provided for @reportProduct.
  ///
  /// In en, this message translates to:
  /// **'Report a Product'**
  String get reportProduct;

  /// No description provided for @reportProductMassage.
  ///
  /// In en, this message translates to:
  /// **'Help us improve the application.'**
  String get reportProductMassage;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// No description provided for @sheetTitleProductInfo.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get sheetTitleProductInfo;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @mostafaMahmoud.
  ///
  /// In en, this message translates to:
  /// **'Mostafa Mahmoud'**
  String get mostafaMahmoud;

  /// No description provided for @readMe.
  ///
  /// In en, this message translates to:
  /// **'ReadMe'**
  String get readMe;

  /// No description provided for @readMeMassage.
  ///
  /// In en, this message translates to:
  /// **'Link to the application repository on GitHub.'**
  String get readMeMassage;

  /// No description provided for @letastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Latest Updates'**
  String get letastUpdate;

  /// No description provided for @letestUpdateMassage.
  ///
  /// In en, this message translates to:
  /// **'Check for updates and changelog.'**
  String get letestUpdateMassage;

  /// No description provided for @githubTiket.
  ///
  /// In en, this message translates to:
  /// **'GitHub Ticket'**
  String get githubTiket;

  /// No description provided for @githubTiketMassage.
  ///
  /// In en, this message translates to:
  /// **'Report a bug or suggest a new feature.'**
  String get githubTiketMassage;

  /// No description provided for @telegramChannel.
  ///
  /// In en, this message translates to:
  /// **'Telegram Channel'**
  String get telegramChannel;

  /// No description provided for @telegramChannelMassage.
  ///
  /// In en, this message translates to:
  /// **'Link to the Telegram channel.'**
  String get telegramChannelMassage;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About the App'**
  String get about;

  /// No description provided for @aboutTadamon.
  ///
  /// In en, this message translates to:
  /// **'About Tadamon App.'**
  String get aboutTadamon;

  /// No description provided for @contactDev.
  ///
  /// In en, this message translates to:
  /// **'Message from the Developer'**
  String get contactDev;

  /// No description provided for @devMassage.
  ///
  /// In en, this message translates to:
  /// **'No message at the moment.'**
  String get devMassage;

  /// No description provided for @devThx.
  ///
  /// In en, this message translates to:
  /// **'Thank you for using the Tadamon app.'**
  String get devThx;

  /// No description provided for @devDonate.
  ///
  /// In en, this message translates to:
  /// **'Support the developer.'**
  String get devDonate;

  /// No description provided for @contactDevMassage.
  ///
  /// In en, this message translates to:
  /// **'Follow me on social media.'**
  String get contactDevMassage;

  /// No description provided for @exportLogs.
  ///
  /// In en, this message translates to:
  /// **'Export Logs'**
  String get exportLogs;

  /// No description provided for @exportLogsSummary.
  ///
  /// In en, this message translates to:
  /// **'This will export all your scanned product logs.'**
  String get exportLogsSummary;

  /// No description provided for @exportAsPdf.
  ///
  /// In en, this message translates to:
  /// **'Export as PDF'**
  String get exportAsPdf;

  /// No description provided for @exportAsCsv.
  ///
  /// In en, this message translates to:
  /// **'Export as CSV'**
  String get exportAsCsv;

  /// No description provided for @exportAsJson.
  ///
  /// In en, this message translates to:
  /// **'Export as JSON'**
  String get exportAsJson;

  /// No description provided for @pdfSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Export logs as a PDF file.'**
  String get pdfSubtitle;

  /// No description provided for @csvSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Export logs as a CSV file.'**
  String get csvSubtitle;

  /// No description provided for @jsonSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Export logs as a JSON file.'**
  String get jsonSubtitle;

  /// No description provided for @dataPreview.
  ///
  /// In en, this message translates to:
  /// **'Data Preview'**
  String get dataPreview;

  /// No description provided for @totalLogs.
  ///
  /// In en, this message translates to:
  /// **'Total Logs'**
  String get totalLogs;

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
