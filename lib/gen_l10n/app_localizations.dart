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

  /// No description provided for @noMatchesFound.
  ///
  /// In en, this message translates to:
  /// **'No matches found'**
  String get noMatchesFound;

  /// No description provided for @noUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get noUsersFound;

  /// No description provided for @likesTitle.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get likesTitle;

  /// No description provided for @matchesTitle.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matchesTitle;

  /// No description provided for @noConversationsYet.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get noConversationsYet;

  /// No description provided for @startChattingWithYourMatches.
  ///
  /// In en, this message translates to:
  /// **'Start chatting with your matches!'**
  String get startChattingWithYourMatches;

  /// No description provided for @chatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chatsTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsSectionGeneral;

  /// No description provided for @settingsEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get settingsEditProfile;

  /// No description provided for @settingsWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get settingsWallet;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsInvite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get settingsInvite;

  /// No description provided for @settingsSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSecurity;

  /// No description provided for @settingsSectionSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSectionSupport;

  /// No description provided for @settingsSubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get settingsSubscription;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get settingsTermsAndConditions;

  /// No description provided for @settingsSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsSectionAccount;

  /// No description provided for @settingsReportProblem.
  ///
  /// In en, this message translates to:
  /// **'Report a problem'**
  String get settingsReportProblem;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogout;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileInterestsSection.
  ///
  /// In en, this message translates to:
  /// **'Interests'**
  String get profileInterestsSection;

  /// No description provided for @profilePhotosSection.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get profilePhotosSection;

  /// No description provided for @profilePreferencesSection.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get profilePreferencesSection;

  /// No description provided for @profileAgeRange.
  ///
  /// In en, this message translates to:
  /// **'Age Range'**
  String get profileAgeRange;

  /// No description provided for @profileDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get profileDistance;

  /// No description provided for @profileLookingFor.
  ///
  /// In en, this message translates to:
  /// **'Looking for'**
  String get profileLookingFor;

  /// No description provided for @profileInterestedIn.
  ///
  /// In en, this message translates to:
  /// **'Interested In'**
  String get profileInterestedIn;

  /// No description provided for @profileLikesStat.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get profileLikesStat;

  /// No description provided for @profileViewsStat.
  ///
  /// In en, this message translates to:
  /// **'Views'**
  String get profileViewsStat;

  /// No description provided for @profileMatchesStat.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get profileMatchesStat;

  /// No description provided for @profileBioPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself...'**
  String get profileBioPlaceholder;

  /// No description provided for @walletTitle.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletTitle;

  /// No description provided for @walletAvailableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get walletAvailableBalance;

  /// No description provided for @walletTotalEarned.
  ///
  /// In en, this message translates to:
  /// **'Total Earned'**
  String get walletTotalEarned;

  /// No description provided for @walletWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Withdrawn'**
  String get walletWithdrawn;

  /// No description provided for @walletWithdrawFunds.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Funds'**
  String get walletWithdrawFunds;

  /// No description provided for @walletWithdrawFundsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Transfer money to your account'**
  String get walletWithdrawFundsSubtitle;

  /// No description provided for @walletPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get walletPaymentMethods;

  /// No description provided for @walletPaymentMethodsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your payment accounts'**
  String get walletPaymentMethodsSubtitle;

  /// No description provided for @walletTransactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get walletTransactionHistory;

  /// No description provided for @walletTransactionHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all transactions'**
  String get walletTransactionHistorySubtitle;

  /// No description provided for @withdrawAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Amount'**
  String get withdrawAmountLabel;

  /// No description provided for @withdrawAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get withdrawAmountHint;

  /// No description provided for @withdrawMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Method'**
  String get withdrawMethodLabel;

  /// No description provided for @withdrawBankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get withdrawBankTransfer;

  /// No description provided for @withdrawBankAccountNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get withdrawBankAccountNotSet;

  /// No description provided for @withdrawNoPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'No payment methods available. Please add one first.'**
  String get withdrawNoPaymentMethods;

  /// No description provided for @withdrawProcessingInfo.
  ///
  /// In en, this message translates to:
  /// **'Withdrawals typically process within 3-5 business days'**
  String get withdrawProcessingInfo;

  /// No description provided for @withdrawAllLabel.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get withdrawAllLabel;

  /// No description provided for @withdrawErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get withdrawErrorTitle;

  /// No description provided for @withdrawErrorInvalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get withdrawErrorInvalidAmount;

  /// No description provided for @withdrawErrorInsufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance'**
  String get withdrawErrorInsufficientBalance;

  /// No description provided for @withdrawErrorNoMethod.
  ///
  /// In en, this message translates to:
  /// **'Please select a withdrawal method'**
  String get withdrawErrorNoMethod;

  /// No description provided for @withdrawConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Withdrawal'**
  String get withdrawConfirmTitle;

  /// No description provided for @withdrawConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Withdraw {amount} to your {method} account?'**
  String withdrawConfirmMessage(Object amount, Object method);

  /// No description provided for @withdrawCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get withdrawCancel;

  /// No description provided for @withdrawConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get withdrawConfirmButton;

  /// No description provided for @paymentConfigured.
  ///
  /// In en, this message translates to:
  /// **'Configured'**
  String get paymentConfigured;

  /// No description provided for @paymentNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get paymentNotConfigured;

  /// No description provided for @paymentStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get paymentStatusActive;

  /// No description provided for @paymentStatusSetup.
  ///
  /// In en, this message translates to:
  /// **'Setup'**
  String get paymentStatusSetup;

  /// No description provided for @paymentDetailsAccountHolder.
  ///
  /// In en, this message translates to:
  /// **'Account Holder'**
  String get paymentDetailsAccountHolder;

  /// No description provided for @paymentDetailsAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get paymentDetailsAccountNumber;

  /// No description provided for @paymentDetailsBankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get paymentDetailsBankName;

  /// No description provided for @paymentDetailsEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get paymentDetailsEmail;

  /// No description provided for @paymentEditDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Details'**
  String get paymentEditDetails;

  /// No description provided for @paymentAddMethod.
  ///
  /// In en, this message translates to:
  /// **'Add Method'**
  String get paymentAddMethod;

  /// No description provided for @bankTransferAccountHolderLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Holder Name'**
  String get bankTransferAccountHolderLabel;

  /// No description provided for @bankTransferAccountHolderHint.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get bankTransferAccountHolderHint;

  /// No description provided for @bankTransferAccountNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get bankTransferAccountNumberLabel;

  /// No description provided for @bankTransferAccountNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter account number'**
  String get bankTransferAccountNumberHint;

  /// No description provided for @bankTransferBankNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankTransferBankNameLabel;

  /// No description provided for @bankTransferBankNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter bank name'**
  String get bankTransferBankNameHint;

  /// No description provided for @bankTransferSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get bankTransferSaveChanges;

  /// No description provided for @paypalAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'PayPal Account'**
  String get paypalAccountTitle;

  /// No description provided for @paypalEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'PayPal Email'**
  String get paypalEmailLabel;

  /// No description provided for @paypalEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter PayPal email address'**
  String get paypalEmailHint;

  /// No description provided for @paypalInfoVerified.
  ///
  /// In en, this message translates to:
  /// **'Make sure this email is verified with your PayPal account'**
  String get paypalInfoVerified;

  /// No description provided for @paypalSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get paypalSaveChanges;

  /// No description provided for @transactionHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistoryTitle;

  /// No description provided for @transactionHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get transactionHistoryEmpty;

  /// No description provided for @transactionStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get transactionStatusCompleted;

  /// No description provided for @transactionStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get transactionStatusPending;

  /// No description provided for @transactionFilterRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get transactionFilterRecent;

  /// No description provided for @transactionFilterWithdrawals.
  ///
  /// In en, this message translates to:
  /// **'Withdrawals'**
  String get transactionFilterWithdrawals;

  /// No description provided for @transactionFilterCommissions.
  ///
  /// In en, this message translates to:
  /// **'Commissions'**
  String get transactionFilterCommissions;

  /// No description provided for @inviteStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Invitation Statistics'**
  String get inviteStatsTitle;

  /// No description provided for @inviteRecentInvites.
  ///
  /// In en, this message translates to:
  /// **'Recent Invites'**
  String get inviteRecentInvites;

  /// No description provided for @inviteTotalInvites.
  ///
  /// In en, this message translates to:
  /// **'{count} total'**
  String inviteTotalInvites(Object count);

  /// No description provided for @inviteEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No invites yet'**
  String get inviteEmptyTitle;

  /// No description provided for @inviteEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start inviting friends to earn rewards!'**
  String get inviteEmptySubtitle;

  /// No description provided for @inviteYourCode.
  ///
  /// In en, this message translates to:
  /// **'Your Code'**
  String get inviteYourCode;

  /// No description provided for @inviteTapToCopy.
  ///
  /// In en, this message translates to:
  /// **'Tap to copy'**
  String get inviteTapToCopy;

  /// No description provided for @inviteCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied to clipboard'**
  String get inviteCopied;

  /// No description provided for @inviteErrorNoCode.
  ///
  /// In en, this message translates to:
  /// **'No invite code available yet'**
  String get inviteErrorNoCode;
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
