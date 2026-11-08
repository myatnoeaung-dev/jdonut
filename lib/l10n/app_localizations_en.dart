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
  String get phoneHint => '9xxxxxxxxx';

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
  String get welcomeTitle => 'Welcome to the world of J\'donuts';

  @override
  String get letsExplore => 'Let\'s explore';

  @override
  String get navHome => 'Home';

  @override
  String get navRewards => 'Rewards';

  @override
  String get homeGreeting => 'Hi, donut lover';

  @override
  String get homeMemberTier => 'Member';

  @override
  String get seasonalSpecials => 'Seasonal specials';

  @override
  String get popular => 'Popular';

  @override
  String get orderAgain => 'Order again';

  @override
  String get nearbyShops => 'Nearby shops';

  @override
  String get comingSoon => 'Design coming soon';

  @override
  String get productTitle => 'Product';

  @override
  String productCode(String code) {
    return 'Product code: $code';
  }

  @override
  String get addToCart => 'Add to cart';

  @override
  String get rewardsTitle => 'Rewards';

  @override
  String get eatMoreEarnMore => 'Eat more earn more';

  @override
  String get gift => 'Gift';
}
