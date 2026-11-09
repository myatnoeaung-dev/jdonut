import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
  ];

  /// App name shown in the task switcher and app bar
  ///
  /// In en, this message translates to:
  /// **'J\'Donuts'**
  String get appTitle;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorGeneric;

  /// No description provided for @errorNoConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Showing saved data.'**
  String get errorNoConnection;

  /// No description provided for @emptyGeneric.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet.'**
  String get emptyGeneric;

  /// No description provided for @offlineBanner.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Showing saved data.'**
  String get offlineBanner;

  /// No description provided for @refreshFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t refresh. Showing saved data.'**
  String get refreshFailed;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @homeEmpty.
  ///
  /// In en, this message translates to:
  /// **'No donuts to show yet.'**
  String get homeEmpty;

  /// No description provided for @loyaltyPoints.
  ///
  /// In en, this message translates to:
  /// **'{points} points'**
  String loyaltyPoints(int points);

  /// No description provided for @topTierReached.
  ///
  /// In en, this message translates to:
  /// **'You\'re at the top tier'**
  String get topTierReached;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Primary button on each registration step
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Round food for every mood'**
  String get onboardingTitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started'**
  String get getStarted;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @continueWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get continueWithFacebook;

  /// Legal notice under the main button; {terms} and {privacy} are tappable links
  ///
  /// In en, this message translates to:
  /// **'By continuing, you acknowledge that you have read and agree to our {terms} and {privacy}.'**
  String termsNotice(String terms, String privacy);

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Screen-reader label for the progress ring
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String registrationStep(int step, int total);

  /// No description provided for @phoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneTitle;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'09xxxxxxxxx'**
  String get phoneHint;

  /// No description provided for @phoneFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneFieldLabel;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get otpTitle;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent 6 digit OTP to {phone}'**
  String otpSentTo(String phone);

  /// No description provided for @otpFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'6 digit code'**
  String get otpFieldLabel;

  /// No description provided for @otpNotReceived.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get otpNotReceived;

  /// Countdown before the code can be resent; {time} is m:ss
  ///
  /// In en, this message translates to:
  /// **'resend in {time} min'**
  String otpResendIn(String time);

  /// No description provided for @otpResendNow.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get otpResendNow;

  /// No description provided for @nameTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your name?'**
  String get nameTitle;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstNameHint;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameHint;

  /// No description provided for @birthDateTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your date of birth?'**
  String get birthDateTitle;

  /// No description provided for @monthHint.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get monthHint;

  /// No description provided for @dayHint.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get dayHint;

  /// No description provided for @yearHint.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get yearHint;

  /// No description provided for @phoneErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number.'**
  String get phoneErrorEmpty;

  /// No description provided for @phoneErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Myanmar mobile number, e.g. 09 254 135 592.'**
  String get phoneErrorInvalid;

  /// Log in with an unknown number; {register} is a tappable link
  ///
  /// In en, this message translates to:
  /// **'This number isn\'t registered yet. {register}'**
  String phoneNotRegistered(String register);

  /// No description provided for @phoneRegisterLink.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get phoneRegisterLink;

  /// No description provided for @otpWrongCode.
  ///
  /// In en, this message translates to:
  /// **'{attemptsLeft, plural, =1{Wrong code. 1 try left.} other{Wrong code. {attemptsLeft} tries left.}}'**
  String otpWrongCode(int attemptsLeft);

  /// No description provided for @otpLocked.
  ///
  /// In en, this message translates to:
  /// **'Too many wrong codes. Request a new code to try again.'**
  String get otpLocked;

  /// No description provided for @otpVerifying.
  ///
  /// In en, this message translates to:
  /// **'Checking code…'**
  String get otpVerifying;

  /// No description provided for @nameErrorRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name.'**
  String get nameErrorRequired;

  /// No description provided for @nameErrorTooLong.
  ///
  /// In en, this message translates to:
  /// **'Use {max} characters or fewer.'**
  String nameErrorTooLong(int max);

  /// No description provided for @nameErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use letters and spaces only.'**
  String get nameErrorInvalid;

  /// No description provided for @birthDateErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a real date.'**
  String get birthDateErrorInvalid;

  /// No description provided for @birthDateErrorFuture.
  ///
  /// In en, this message translates to:
  /// **'Your date of birth can\'t be in the future.'**
  String get birthDateErrorFuture;

  /// No description provided for @birthDateErrorTooYoung.
  ///
  /// In en, this message translates to:
  /// **'You must be at least {age} years old.'**
  String birthDateErrorTooYoung(int age);

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the world of J\'donuts'**
  String get welcomeTitle;

  /// No description provided for @letsExplore.
  ///
  /// In en, this message translates to:
  /// **'Let\'s explore'**
  String get letsExplore;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navRewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get navRewards;

  /// No description provided for @navMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navMenu;

  /// No description provided for @navWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get navWallet;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @tierBronze.
  ///
  /// In en, this message translates to:
  /// **'Bronze'**
  String get tierBronze;

  /// No description provided for @tierSilver.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get tierSilver;

  /// No description provided for @tierGold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get tierGold;

  /// No description provided for @tierPlatinum.
  ///
  /// In en, this message translates to:
  /// **'Platinum'**
  String get tierPlatinum;

  /// Member tier under the name on Home, e.g. Bronze member
  ///
  /// In en, this message translates to:
  /// **'{tier} member'**
  String memberTier(String tier);

  /// No description provided for @pointsToNextTier.
  ///
  /// In en, this message translates to:
  /// **'{points} points left to become {tier} Member'**
  String pointsToNextTier(int points, String tier);

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @unreadNotifications.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 unread notification} other{{count} unread notifications}}'**
  String unreadNotifications(int count);

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @seasonalSpecials.
  ///
  /// In en, this message translates to:
  /// **'Seasonal specials'**
  String get seasonalSpecials;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular 🔥'**
  String get popular;

  /// No description provided for @orderAgain.
  ///
  /// In en, this message translates to:
  /// **'Order again'**
  String get orderAgain;

  /// No description provided for @discountOff.
  ///
  /// In en, this message translates to:
  /// **'{percent}% off'**
  String discountOff(int percent);

  /// No description provided for @nearbyShopsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{There is 1 J\'Donut shop near you. 😋} other{There are {count} J\'Donut shops near you. 😋}}'**
  String nearbyShopsCount(int count);

  /// No description provided for @exploreNow.
  ///
  /// In en, this message translates to:
  /// **'Explore now'**
  String get exploreNow;

  /// No description provided for @orderOnline.
  ///
  /// In en, this message translates to:
  /// **'Order Online'**
  String get orderOnline;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Design coming soon'**
  String get comingSoon;

  /// No description provided for @productNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get productNew;

  /// Price in Myanmar kyat; {price} is already formatted with grouping
  ///
  /// In en, this message translates to:
  /// **'{price} MMK'**
  String priceMmk(String price);

  /// No description provided for @whatsThis.
  ///
  /// In en, this message translates to:
  /// **'What\'s this?'**
  String get whatsThis;

  /// No description provided for @decreaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Decrease quantity'**
  String get decreaseQuantity;

  /// No description provided for @increaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Increase quantity'**
  String get increaseQuantity;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find this donut.'**
  String get productNotFound;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccount;

  /// No description provided for @myAddresses.
  ///
  /// In en, this message translates to:
  /// **'My addresses'**
  String get myAddresses;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get paymentMethods;

  /// No description provided for @orderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get orderHistory;

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsPreferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @orderUpdates.
  ///
  /// In en, this message translates to:
  /// **'Order updates'**
  String get orderUpdates;

  /// No description provided for @promotions.
  ///
  /// In en, this message translates to:
  /// **'Offers & promotions'**
  String get promotions;

  /// No description provided for @settingsSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSupport;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help center'**
  String get helpCenter;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About J\'Donuts'**
  String get aboutApp;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersion(String version);

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @logOutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logOutConfirmTitle;

  /// No description provided for @logOutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ll need to verify your phone number to log in again.'**
  String get logOutConfirmMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @featureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get featureComingSoon;

  /// No description provided for @rewardsTitle.
  ///
  /// In en, this message translates to:
  /// **'J\' Donuts Rewards'**
  String get rewardsTitle;

  /// No description provided for @eatMoreEarnMore.
  ///
  /// In en, this message translates to:
  /// **'Eat more earn more'**
  String get eatMoreEarnMore;

  /// No description provided for @gift.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get gift;

  /// No description provided for @rewardsReady.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewardsReady;

  /// No description provided for @rewardsReadyCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 reward ready to claim} other{{count} rewards ready to claim}}'**
  String rewardsReadyCount(int count);

  /// No description provided for @tierCurrent.
  ///
  /// In en, this message translates to:
  /// **'You\'re here now'**
  String get tierCurrent;

  /// No description provided for @tierUpcoming.
  ///
  /// In en, this message translates to:
  /// **'You\'ll be here soon'**
  String get tierUpcoming;

  /// No description provided for @tierUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get tierUnlocked;

  /// No description provided for @tierPointsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{points} pts remaining to become {tier}'**
  String tierPointsRemaining(int points, String tier);

  /// No description provided for @totalPoints.
  ///
  /// In en, this message translates to:
  /// **'Total points'**
  String get totalPoints;

  /// No description provided for @pointsValue.
  ///
  /// In en, this message translates to:
  /// **'{points}'**
  String pointsValue(int points);

  /// No description provided for @challengeProgress.
  ///
  /// In en, this message translates to:
  /// **'{progress}/{goal}'**
  String challengeProgress(int progress, int goal);

  /// No description provided for @challengeReward.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String challengeReward(int points);

  /// No description provided for @earn.
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get earn;

  /// No description provided for @rewardsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No challenges right now. Check back soon!'**
  String get rewardsEmpty;
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
      <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
