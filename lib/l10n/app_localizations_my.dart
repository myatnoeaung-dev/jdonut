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
  String get phoneHint => '9xxxxxxxxx';

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
  String get welcomeTitle => 'J\'donuts ကမ္ဘာမှ ကြိုဆိုပါသည်';

  @override
  String get letsExplore => 'စူးစမ်းကြည့်ရအောင်';

  @override
  String get navHome => 'ပင်မ';

  @override
  String get navRewards => 'ဆုလာဘ်များ';

  @override
  String get homeGreeting => 'မင်္ဂလာပါ ဒိုးနတ်ချစ်သူ';

  @override
  String get homeMemberTier => 'အဖွဲ့ဝင်';

  @override
  String get seasonalSpecials => 'ရာသီအထူး';

  @override
  String get popular => 'လူကြိုက်များ';

  @override
  String get orderAgain => 'ထပ်မှာမည်';

  @override
  String get nearbyShops => 'အနီးရှိ ဆိုင်များ';

  @override
  String get comingSoon => 'ဒီဇိုင်း မကြာမီ လာပါမည်';

  @override
  String get productTitle => 'ပစ္စည်း';

  @override
  String productCode(String code) {
    return 'ပစ္စည်းကုဒ်: $code';
  }

  @override
  String get addToCart => 'ခြင်းထဲထည့်မည်';

  @override
  String get rewardsTitle => 'ဆုလာဘ်များ';

  @override
  String get eatMoreEarnMore => 'များများစား များများရ';

  @override
  String get gift => 'လက်ဆောင်';
}
