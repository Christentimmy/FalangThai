import 'dart:ui';

import 'package:falangthai/app/data/models/chat_list_model.dart';
import 'package:falangthai/app/modules/auth/views/login_screen.dart';
import 'package:falangthai/app/modules/auth/views/otp_screen.dart';
import 'package:falangthai/app/modules/auth/views/signup_screen.dart';
import 'package:falangthai/app/modules/chat/views/audio_call_screen.dart';
import 'package:falangthai/app/modules/chat/views/chat_list_screen.dart';
import 'package:falangthai/app/modules/chat/views/message_screen.dart';
import 'package:falangthai/app/modules/chat/views/video_call_screen.dart';
import 'package:falangthai/app/modules/favorites/views/favorite_screen.dart';
import 'package:falangthai/app/modules/favorites/views/matches_screen.dart';
import 'package:falangthai/app/modules/home/views/home_screen.dart';
import 'package:falangthai/app/modules/language/views/language_selection_screen.dart';
import 'package:falangthai/app/modules/location/views/location_request_screen.dart';
import 'package:falangthai/app/modules/notification/views/notification_screen.dart';
import 'package:falangthai/app/modules/profile/views/edit_hobbies_screen.dart';
import 'package:falangthai/app/modules/profile/views/gender_screen.dart';
import 'package:falangthai/app/modules/profile/views/hobby_screen.dart';
import 'package:falangthai/app/modules/profile/views/profile_screen.dart';
import 'package:falangthai/app/modules/profile/views/profile_upload.dart';
import 'package:falangthai/app/modules/profile/views/relationship_preference.dart';
import 'package:falangthai/app/modules/settings/views/invite_stat_screen.dart';
import 'package:falangthai/app/modules/settings/views/redeem_code_screen.dart';
import 'package:falangthai/app/modules/settings/views/settings_screen.dart';
import 'package:falangthai/app/modules/splash/splash_screen.dart';
import 'package:falangthai/app/modules/subscription/views/subscription_screen.dart';
import 'package:falangthai/app/modules/swipe/views/match_screen.dart';
import 'package:falangthai/app/modules/swipe/views/swipe_profile_screen.dart';
import 'package:falangthai/app/modules/welcome/views/welcome_screen.dart';
import 'package:falangthai/app/modules/withdraw/views/edit_bank_transfer_screen.dart';
import 'package:falangthai/app/modules/withdraw/views/edit_paypal_screen.dart';
import 'package:falangthai/app/modules/withdraw/views/edit_stripe_screen.dart';
import 'package:falangthai/app/modules/withdraw/views/payment_method_screen.dart';
import 'package:falangthai/app/modules/withdraw/views/transaction_history_screen.dart';
import 'package:falangthai/app/modules/withdraw/views/wallet_screen.dart';
import 'package:falangthai/app/modules/withdraw/views/withdraw_screen.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/bottom_navigation_widget.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.welcome, page: () => WelcomeScreen()),
    GetPage(name: AppRoutes.language, page: () => LanguageSelectionScreen()),
    GetPage(name: AppRoutes.signup, page: () => SignupScreen()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.gender, page: () {
      final arguments = Get.arguments ?? {};
      final nextScreen = arguments['nextScreen'] as VoidCallback?;
      return GenderScreen(nextScreen: nextScreen);
    }),
    GetPage(
      name: AppRoutes.profileUpload,
      page: () {
        final arguments = Get.arguments ?? {};
        final nextScreen = arguments['nextScreen'] as VoidCallback?;
        return ProfileUploadScreen(nextScreen: nextScreen);
      },
    ),
    GetPage(
      name: AppRoutes.hobby,
      page: () {
        final arguments = Get.arguments ?? {};
        final nextScreen = arguments['nextScreen'] as VoidCallback?;
        return HobbiesSelectionScreen(nextScreen: nextScreen);
      },
    ),
    GetPage(
      name: AppRoutes.relationshipPreference,
      page: () {
        final arguments = Get.arguments ?? {};
        final nextScreen = arguments['nextScreen'] as VoidCallback?;
        return RelationshipPreferenceScreen(nextScreen: nextScreen);
      },
    ),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    GetPage(name: AppRoutes.favorite, page: () => FavoriteScreen()),
    GetPage(name: AppRoutes.matches, page: () => MatchesScreen()),
    GetPage(name: AppRoutes.chatList, page: () => ChatListScreen()),
    GetPage(name: AppRoutes.message, page: () {
      final arguments = Get.arguments ?? {};
      final chatHead = arguments['chatHead'];
      if (chatHead == null) {
        throw Exception("Chat head is required");
      }
      return MessageScreen(chatHead: chatHead as ChatListModel);
    }),
    GetPage(name: AppRoutes.audioCall, page: () => AudioCallScreen()),
    GetPage(name: AppRoutes.videoCall, page: () => VideoCallScreen()),
    GetPage(name: AppRoutes.settings, page: () => SettingsScreen()),
    GetPage(name: AppRoutes.notification, page: () => NotificationScreen()),
    GetPage(name: AppRoutes.subscription, page: () => SubscriptionScreen()),
    GetPage(
      name: AppRoutes.bottomNavigation,
      page: () => BottomNavigationWidget(),
    ),
    GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () {
        final arguments = Get.arguments ?? {};
        final email = arguments['email'] as String;
        if (email.isEmpty) {
          throw Exception("Email is required");
        }
        final onVerifiedCallBack =
            arguments['onVerifiedCallBack'] as VoidCallback?;
        final showEditDetails = arguments['showEditDetails'] ?? true;
        return OtpScreen(
          email: email,
          onVerifiedCallBack: onVerifiedCallBack,
          showEditDetails: showEditDetails,
        );
      },
    ),
    GetPage(
      name: AppRoutes.locationRequest,
      page: () {
        final arguments = Get.arguments ?? {};
        final nextScreen = arguments['nextScreen'] as VoidCallback?;
        return LocationRequestScreen(nextScreen: nextScreen);
      },
    ),
    GetPage(
      name: AppRoutes.swipeProfile,
      page: () {
        final arguments = Get.arguments ?? {};
        final userId = arguments['userId'] as String;
        if (userId.isEmpty) {
          throw Exception("User ID is required");
        }
        return SwipeProfileScreen(userId: userId);
      },
    ),
    GetPage(
      name: AppRoutes.match,
      page: () {
        final arguments = Get.arguments ?? {};
        final targetUserId = arguments['targetUserId'] as String;
        if (targetUserId.isEmpty) {
          throw Exception("User ID is required");
        }
        return MatchScreen(targetUserId: targetUserId);
      },
    ),
    GetPage(
      name: AppRoutes.editHobbies,
      page: () => EditHobbiesScreen(),
    ),
    GetPage(
      name: AppRoutes.redeemCode,
      page: () => RedeemCodeScreen(),
    ),
    GetPage(
      name: AppRoutes.inviteStat,
      page: () => InviteStatScreen(),
    ),
    GetPage(
      name: AppRoutes.walletScreen,
      page: () => WalletScreen(),
    ),
    GetPage(
      name: AppRoutes.withdrawScreen,
      page: () => WithdrawScreen(),
    ),
    GetPage(
      name: AppRoutes.paymentMethodScreen,
      page: () => PaymentMethodScreen(),
    ),
    GetPage(
      name: AppRoutes.editBankTransferScreen,
      page: () => EditBankTransferScreen(),
    ),
    GetPage(
      name: AppRoutes.editStripeScreen,
      page: () => EditStripeScreen(),
    ),
    GetPage(
      name: AppRoutes.editPayPalScreen,
      page: () => EditPayPalScreen(),
    ),
    GetPage(
      name: AppRoutes.transactionHistoryScreen,
      page: () => TransactionHistoryScreen(),
    ),
  ];
}
