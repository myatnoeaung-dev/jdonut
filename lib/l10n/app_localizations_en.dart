// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get loading => 'Loading…';

  @override
  String get retry => 'Try again';

  @override
  String get errorGeneric => 'Something went wrong.';

  @override
  String get errorNoConnection => 'No internet connection. Showing saved data.';

  @override
  String get emptyGeneric => 'Nothing here yet.';

  @override
  String get back => 'Back';

  @override
  String get continueLabel => 'Continue';

  @override
  String get onboardingTitle => 'Round food for every mood';

  @override
  String get getStarted => 'Let\'s get started';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get logIn => 'Log in';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get continueWithFacebook => 'Continue with Facebook';

  @override
  String termsNotice(String terms, String privacy) {
    return 'By continuing, you acknowledge that you have read and agree to our $terms and $privacy.';
  }

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String registrationStep(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get phoneTitle => 'Enter your phone number';

  @override
  String get phoneHint => '09xxxxxxxxx';

  @override
  String get phoneFieldLabel => 'Phone number';

  @override
  String get otpTitle => 'Verify your number';

  @override
  String otpSentTo(String phone) {
    return 'We\'ve sent 6 digit OTP to $phone';
  }

  @override
  String get otpFieldLabel => '6 digit code';

  @override
  String get otpNotReceived => 'Didn\'t receive the code?';

  @override
  String otpResendIn(String time) {
    return 'resend in $time min';
  }

  @override
  String get otpResendNow => 'Resend code';

  @override
  String get nameTitle => 'What\'s your name?';

  @override
  String get firstNameHint => 'First Name';

  @override
  String get lastNameHint => 'Last Name';

  @override
  String get birthDateTitle => 'What\'s your date of birth?';

  @override
  String get monthHint => 'Month';

  @override
  String get dayHint => 'Day';

  @override
  String get yearHint => 'Year';

  @override
  String get phoneErrorEmpty => 'Enter your phone number.';

  @override
  String get phoneErrorInvalid =>
      'Enter a valid Myanmar mobile number, e.g. 09 254 135 592.';

  @override
  String phoneNotRegistered(String register) {
    return 'This number isn\'t registered yet. $register';
  }

  @override
  String get phoneRegisterLink => 'Create an account';

  @override
  String otpWrongCode(int attemptsLeft) {
    String _temp0 = intl.Intl.pluralLogic(
      attemptsLeft,
      locale: localeName,
      other: 'Wrong code. $attemptsLeft tries left.',
      one: 'Wrong code. 1 try left.',
    );
    return '$_temp0';
  }

  @override
  String get otpLocked =>
      'Too many wrong codes. Request a new code to try again.';

  @override
  String get otpVerifying => 'Checking code…';

  @override
  String get nameErrorRequired => 'Enter your first name.';

  @override
  String nameErrorTooLong(int max) {
    return 'Use $max characters or fewer.';
  }

  @override
  String get nameErrorInvalid => 'Use letters and spaces only.';

  @override
  String get birthDateErrorInvalid => 'Enter a real date.';

  @override
  String get birthDateErrorFuture =>
      'Your date of birth can\'t be in the future.';

  @override
  String birthDateErrorTooYoung(int age) {
    return 'You must be at least $age years old.';
  }

  @override
  String get welcomeTitle => 'Welcome to the world of J\'donuts';

  @override
  String get letsExplore => 'Let\'s explore';

  @override
  String get navHome => 'Home';

  @override
  String get navRewards => 'Rewards';

  @override
  String get navMenu => 'Menu';

  @override
  String get navWallet => 'Wallet';

  @override
  String get navSettings => 'Settings';

  @override
  String get tierBronze => 'Bronze';

  @override
  String get tierSilver => 'Silver';

  @override
  String get tierGold => 'Gold';

  @override
  String memberTier(String tier) {
    return '$tier member';
  }

  @override
  String pointsToNextTier(int points, String tier) {
    final intl.NumberFormat pointsNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String pointsString = pointsNumberFormat.format(points);

    return '$pointsString points left to become $tier Member';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String unreadNotifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unread notifications',
      one: '1 unread notification',
    );
    return '$_temp0';
  }

  @override
  String get seeAll => 'See all';

  @override
  String get seasonalSpecials => 'Seasonal specials';

  @override
  String get popular => 'Popular 🔥';

  @override
  String get orderAgain => 'Order again';

  @override
  String discountOff(int percent) {
    return '$percent% off';
  }

  @override
  String nearbyShopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'There are $count J\'Donut shops near you. 😋',
      one: 'There is 1 J\'Donut shop near you. 😋',
    );
    return '$_temp0';
  }

  @override
  String get exploreNow => 'Explore now';

  @override
  String get orderOnline => 'Order Online';

  @override
  String get comingSoon => 'Design coming soon';

  @override
  String get productNew => 'New';

  @override
  String priceMmk(String price) {
    return '$price MMK';
  }

  @override
  String get whatsThis => 'What\'s this?';

  @override
  String get decreaseQuantity => 'Decrease quantity';

  @override
  String get increaseQuantity => 'Increase quantity';

  @override
  String get productNotFound => 'We couldn\'t find this donut.';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get settingsAccount => 'Account';

  @override
  String get myAddresses => 'My addresses';

  @override
  String get paymentMethods => 'Payment methods';

  @override
  String get orderHistory => 'Order history';

  @override
  String get settingsPreferences => 'Preferences';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get orderUpdates => 'Order updates';

  @override
  String get promotions => 'Offers & promotions';

  @override
  String get settingsSupport => 'Support';

  @override
  String get helpCenter => 'Help center';

  @override
  String get aboutApp => 'About J\'Donuts';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String get logOut => 'Log out';

  @override
  String get logOutConfirmTitle => 'Log out?';

  @override
  String get logOutConfirmMessage =>
      'You\'ll need to verify your phone number to log in again.';

  @override
  String get cancel => 'Cancel';

  @override
  String get featureComingSoon => 'Coming soon';

  @override
  String get rewardsTitle => 'Rewards';

  @override
  String get eatMoreEarnMore => 'Eat more earn more';

  @override
  String get gift => 'Gift';
}
