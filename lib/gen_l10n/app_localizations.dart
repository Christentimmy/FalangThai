import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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
    Locale('en'),
    Locale('fr'),
    Locale('th'),
  ];

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'welcome Back'**
  String get welcomeBack;

  /// No description provided for @loginText1.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your journey'**
  String get loginText1;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountTitle;

  /// No description provided for @createAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join our community and start connecting'**
  String get createAccountSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @iAgreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get iAgreeTo;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @verificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verificationTitle;

  /// No description provided for @otpHeadingPrefix.
  ///
  /// In en, this message translates to:
  /// **'Enter your '**
  String get otpHeadingPrefix;

  /// No description provided for @otpHeadingOtp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otpHeadingOtp;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'A verification code has been sent to'**
  String get otpSentTo;

  /// No description provided for @wrongDetails.
  ///
  /// In en, this message translates to:
  /// **'Wrong details?'**
  String get wrongDetails;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **' Change'**
  String get change;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? '**
  String get didntReceiveCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @genderTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your gender?'**
  String get genderTitle;

  /// No description provided for @genderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help us personalize your experience\nby selecting your gender'**
  String get genderSubtitle;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @preferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get preferNotToSay;

  /// No description provided for @locationRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Location Request'**
  String get locationRequestTitle;

  /// No description provided for @locationRequestBody.
  ///
  /// In en, this message translates to:
  /// **'To help you find meaningful connections nearby, we need access to your location. Our dating algorithm uses your location to:\n\n• Show you potential matches in your area\n• Calculate accurate distance between you and other users\n• Provide better match suggestions based on proximity\n• Enable location-based features and events\n\nYour location data is always kept private and encoded.'**
  String get locationRequestBody;

  /// No description provided for @allowLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow Location'**
  String get allowLocation;

  /// No description provided for @addYourPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Add your photo'**
  String get addYourPhotoTitle;

  /// No description provided for @addYourPhotoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show the world your beautiful smile!\nThis helps others recognize you'**
  String get addYourPhotoSubtitle;

  /// No description provided for @dateOfBirthPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirthPlaceholder;

  /// No description provided for @bioPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bioPlaceholder;

  /// No description provided for @whatAreYourHobbies.
  ///
  /// In en, this message translates to:
  /// **'What are your hobbies?'**
  String get whatAreYourHobbies;

  /// No description provided for @hobbiesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help others discover what makes you unique!\nSelect activities you love and enjoy'**
  String get hobbiesSubtitle;

  /// No description provided for @hobbiesSelectionCounter.
  ///
  /// In en, this message translates to:
  /// **'{count} hobbies selected'**
  String hobbiesSelectionCounter(Object count);

  /// No description provided for @reading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get reading;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @cooking.
  ///
  /// In en, this message translates to:
  /// **'Cooking'**
  String get cooking;

  /// No description provided for @travel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get travel;

  /// No description provided for @photography.
  ///
  /// In en, this message translates to:
  /// **'Photography'**
  String get photography;

  /// No description provided for @sports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get sports;

  /// No description provided for @gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get gaming;

  /// No description provided for @art.
  ///
  /// In en, this message translates to:
  /// **'Art'**
  String get art;

  /// No description provided for @fitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get fitness;

  /// No description provided for @movies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movies;

  /// No description provided for @dancing.
  ///
  /// In en, this message translates to:
  /// **'Dancing'**
  String get dancing;

  /// No description provided for @gardening.
  ///
  /// In en, this message translates to:
  /// **'Gardening'**
  String get gardening;

  /// No description provided for @writing.
  ///
  /// In en, this message translates to:
  /// **'Writing'**
  String get writing;

  /// No description provided for @tech.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get tech;

  /// No description provided for @fashion.
  ///
  /// In en, this message translates to:
  /// **'Fashion'**
  String get fashion;

  /// No description provided for @volunteering.
  ///
  /// In en, this message translates to:
  /// **'Volunteering'**
  String get volunteering;

  /// No description provided for @selectAtLeast3Hobbies.
  ///
  /// In en, this message translates to:
  /// **'Select at least 3 hobbies'**
  String get selectAtLeast3Hobbies;

  /// No description provided for @selectMoreHobbies.
  ///
  /// In en, this message translates to:
  /// **'Select {count} more hobbies'**
  String selectMoreHobbies(Object count);

  /// No description provided for @hobbiesSelected.
  ///
  /// In en, this message translates to:
  /// **'{count}/8 hobbies selected'**
  String hobbiesSelected(Object count);

  /// No description provided for @maximumSelection.
  ///
  /// In en, this message translates to:
  /// **'Maximum Selection'**
  String get maximumSelection;

  /// No description provided for @youCanSelectUpTo8HobbiesOnly.
  ///
  /// In en, this message translates to:
  /// **'You can select up to 8 hobbies only'**
  String get youCanSelectUpTo8HobbiesOnly;

  /// No description provided for @editHobbies.
  ///
  /// In en, this message translates to:
  /// **'Edit Hobbies'**
  String get editHobbies;

  /// No description provided for @relationshipTitle.
  ///
  /// In en, this message translates to:
  /// **'Who interests you?'**
  String get relationshipTitle;

  /// No description provided for @relationshipSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select preferences that apply to help us\nfind your perfect matches'**
  String get relationshipSubtitle;

  /// No description provided for @prefMen.
  ///
  /// In en, this message translates to:
  /// **'Men'**
  String get prefMen;

  /// No description provided for @prefWomen.
  ///
  /// In en, this message translates to:
  /// **'Women'**
  String get prefWomen;

  /// No description provided for @prefNonBinary.
  ///
  /// In en, this message translates to:
  /// **'Non-binary'**
  String get prefNonBinary;

  /// No description provided for @prefTransgender.
  ///
  /// In en, this message translates to:
  /// **'Transgender'**
  String get prefTransgender;

  /// No description provided for @prefEveryone.
  ///
  /// In en, this message translates to:
  /// **'Everyone'**
  String get prefEveryone;
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
      <String>['en', 'fr', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
