// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get loading => 'ဖွင့်နေသည်…';

  @override
  String get retry => 'ထပ်ကြိုးစားပါ';

  @override
  String get errorGeneric => 'တစ်ခုခု မှားယွင်းသွားပါသည်။';

  @override
  String get errorNoConnection =>
      'အင်တာနက် ချိတ်ဆက်မှု မရှိပါ။ သိမ်းထားသော အချက်အလက်ကို ပြသနေသည်။';

  @override
  String get emptyGeneric => 'ပြသရန် မရှိသေးပါ။';

  @override
  String get back => 'နောက်သို့';

  @override
  String get continueLabel => 'ဆက်လုပ်မည်';

  @override
  String get onboardingTitle => 'စိတ်ကြိုက် အဝိုင်းလေးများ';

  @override
  String get getStarted => 'စတင်လိုက်ရအောင်';

  @override
  String get alreadyHaveAccount => 'အကောင့်ရှိပြီးသားလား?';

  @override
  String get logIn => 'ဝင်ရောက်မည်';

  @override
  String get continueWithGoogle => 'Google ဖြင့် ဆက်လုပ်မည်';

  @override
  String get continueWithApple => 'Apple ဖြင့် ဆက်လုပ်မည်';

  @override
  String get continueWithFacebook => 'Facebook ဖြင့် ဆက်လုပ်မည်';

  @override
  String termsNotice(String terms, String privacy) {
    return 'ဆက်လုပ်ခြင်းဖြင့် ကျွန်ုပ်တို့၏ $terms နှင့် $privacy ကို ဖတ်ရှုပြီး သဘောတူကြောင်း အသိအမှတ်ပြုပါသည်။';
  }

  @override
  String get termsOfUse => 'အသုံးပြုမှု စည်းမျဉ်းများ';

  @override
  String get privacyPolicy => 'ကိုယ်ရေးအချက်အလက် မူဝါဒ';

  @override
  String registrationStep(int step, int total) {
    return 'အဆင့် $step / $total';
  }

  @override
  String get phoneTitle => 'သင့်ဖုန်းနံပါတ် ထည့်ပါ';

  @override
  String get phoneHint => '09xxxxxxxxx';

  @override
  String get phoneFieldLabel => 'ဖုန်းနံပါတ်';

  @override
  String get otpTitle => 'သင့်နံပါတ်ကို အတည်ပြုပါ';

  @override
  String otpSentTo(String phone) {
    return '$phone သို့ ဂဏန်း ၆ လုံး OTP ပို့ထားပါသည်';
  }

  @override
  String get otpFieldLabel => 'ဂဏန်း ၆ လုံး ကုဒ်';

  @override
  String get otpNotReceived => 'ကုဒ် မရရှိသေးဘူးလား?';

  @override
  String otpResendIn(String time) {
    return '$time မိနစ်အတွင်း ပြန်ပို့ပါမည်';
  }

  @override
  String get otpResendNow => 'ကုဒ် ပြန်ပို့မည်';

  @override
  String get nameTitle => 'သင့်အမည် ဘာလဲ?';

  @override
  String get firstNameHint => 'အမည် (ရှေ့)';

  @override
  String get lastNameHint => 'အမည် (နောက်)';

  @override
  String get birthDateTitle => 'သင့်မွေးနေ့ ဘယ်နေ့လဲ?';

  @override
  String get monthHint => 'လ';

  @override
  String get dayHint => 'ရက်';

  @override
  String get yearHint => 'နှစ်';

  @override
  String get phoneErrorEmpty => 'သင့်ဖုန်းနံပါတ် ထည့်ပါ။';

  @override
  String get phoneErrorInvalid =>
      'မှန်ကန်သော မြန်မာ ဖုန်းနံပါတ် ထည့်ပါ၊ ဥပမာ 09 254 135 592။';

  @override
  String phoneNotRegistered(String register) {
    return 'ဤနံပါတ်ဖြင့် စာရင်း မသွင်းရသေးပါ။ $register';
  }

  @override
  String get phoneRegisterLink => 'အကောင့် ဖွင့်မည်';

  @override
  String otpWrongCode(int attemptsLeft) {
    String _temp0 = intl.Intl.pluralLogic(
      attemptsLeft,
      locale: localeName,
      other: 'ကုဒ် မှားနေပါသည်။ $attemptsLeft ကြိမ် ကျန်ပါသေးသည်။',
    );
    return '$_temp0';
  }

  @override
  String get otpLocked =>
      'ကုဒ် မှားသည်မှာ များလွန်းပါသည်။ ကုဒ်အသစ် တောင်းပြီး ထပ်ကြိုးစားပါ။';

  @override
  String get otpVerifying => 'ကုဒ် စစ်ဆေးနေသည်…';

  @override
  String get nameErrorRequired => 'သင့်အမည် ထည့်ပါ။';

  @override
  String nameErrorTooLong(int max) {
    return 'စာလုံး $max လုံးထက် မပိုရပါ။';
  }

  @override
  String get nameErrorInvalid => 'စာလုံးနှင့် ကွက်လပ်သာ သုံးပါ။';

  @override
  String get birthDateErrorInvalid => 'မှန်ကန်သော ရက်စွဲ ထည့်ပါ။';

  @override
  String get birthDateErrorFuture => 'မွေးနေ့သည် အနာဂတ် ရက်စွဲ မဖြစ်ရပါ။';

  @override
  String birthDateErrorTooYoung(int age) {
    return 'အသက် အနည်းဆုံး $age နှစ် ပြည့်ရပါမည်။';
  }

  @override
  String get welcomeTitle => 'J\'donuts ကမ္ဘာမှ ကြိုဆိုပါသည်';

  @override
  String get letsExplore => 'စူးစမ်းကြည့်ရအောင်';

  @override
  String get navHome => 'ပင်မ';

  @override
  String get navRewards => 'ဆုလာဘ်များ';

  @override
  String get navMenu => 'မီနူး';

  @override
  String get navWallet => 'ပိုက်ဆံအိတ်';

  @override
  String get navSettings => 'ဆက်တင်များ';

  @override
  String get tierBronze => 'ကြေး';

  @override
  String get tierSilver => 'ငွေ';

  @override
  String get tierGold => 'ရွှေ';

  @override
  String memberTier(String tier) {
    return '$tier အဖွဲ့ဝင်';
  }

  @override
  String pointsToNextTier(int points, String tier) {
    final intl.NumberFormat pointsNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String pointsString = pointsNumberFormat.format(points);

    return '$tier အဖွဲ့ဝင်ဖြစ်ရန် ပွိုင့် $pointsString ကျန်ပါသေးသည်';
  }

  @override
  String get notifications => 'အသိပေးချက်များ';

  @override
  String unreadNotifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'မဖတ်ရသေးသော အသိပေးချက် $count ခု',
    );
    return '$_temp0';
  }

  @override
  String get seeAll => 'အားလုံးကြည့်မည်';

  @override
  String get seasonalSpecials => 'ရာသီအထူး';

  @override
  String get popular => 'လူကြိုက်များ 🔥';

  @override
  String get orderAgain => 'ထပ်မှာမည်';

  @override
  String discountOff(int percent) {
    return '$percent% လျှော့';
  }

  @override
  String nearbyShopsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'သင့်အနီးတွင် J\'Donut ဆိုင် $count ဆိုင် ရှိပါသည်။ 😋',
    );
    return '$_temp0';
  }

  @override
  String get exploreNow => 'ယခု ရှာဖွေမည်';

  @override
  String get orderOnline => 'အွန်လိုင်း မှာယူမည်';

  @override
  String get comingSoon => 'ဒီဇိုင်း မကြာမီ လာပါမည်';

  @override
  String get productNew => 'အသစ်';

  @override
  String priceMmk(String price) {
    return '$price ကျပ်';
  }

  @override
  String get whatsThis => 'ဒါဘာလဲ?';

  @override
  String get decreaseQuantity => 'အရေအတွက် လျှော့မည်';

  @override
  String get increaseQuantity => 'အရေအတွက် တိုးမည်';

  @override
  String get productNotFound => 'ဤဒိုးနတ်ကို ရှာမတွေ့ပါ။';

  @override
  String get addToCart => 'ခြင်းထဲထည့်မည်';

  @override
  String get editProfile => 'ပရိုဖိုင် ပြင်မည်';

  @override
  String get settingsAccount => 'အကောင့်';

  @override
  String get myAddresses => 'ကျွန်ုပ်၏ လိပ်စာများ';

  @override
  String get paymentMethods => 'ငွေပေးချေမှု နည်းလမ်းများ';

  @override
  String get orderHistory => 'မှာယူမှု မှတ်တမ်း';

  @override
  String get settingsPreferences => 'စိတ်ကြိုက် ရွေးချယ်မှုများ';

  @override
  String get language => 'ဘာသာစကား';

  @override
  String get chooseLanguage => 'ဘာသာစကား ရွေးပါ';

  @override
  String get orderUpdates => 'မှာယူမှု အခြေအနေ';

  @override
  String get promotions => 'ပရိုမိုးရှင်းများ';

  @override
  String get settingsSupport => 'အကူအညီ';

  @override
  String get helpCenter => 'အကူအညီ စင်တာ';

  @override
  String get aboutApp => 'J\'Donuts အကြောင်း';

  @override
  String appVersion(String version) {
    return 'ဗားရှင်း $version';
  }

  @override
  String get logOut => 'ထွက်မည်';

  @override
  String get logOutConfirmTitle => 'ထွက်မှာ သေချာလား?';

  @override
  String get logOutConfirmMessage =>
      'ပြန်ဝင်ရန် သင့်ဖုန်းနံပါတ်ကို ထပ်မံ အတည်ပြုရပါမည်။';

  @override
  String get cancel => 'မလုပ်တော့ပါ';

  @override
  String get featureComingSoon => 'မကြာမီ လာပါမည်';

  @override
  String get rewardsTitle => 'ဆုလာဘ်များ';

  @override
  String get eatMoreEarnMore => 'များများစား များများရ';

  @override
  String get gift => 'လက်ဆောင်';
}
