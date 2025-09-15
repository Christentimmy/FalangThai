import 'package:falangthai/app/modules/auth/views/login_screen.dart';
import 'package:falangthai/app/modules/auth/views/signup_screen.dart';
import 'package:falangthai/app/modules/chat/views/audio_call_screen.dart';
import 'package:falangthai/app/modules/chat/views/chat_list_screen.dart';
import 'package:falangthai/app/modules/chat/views/message_screen.dart';
import 'package:falangthai/app/modules/chat/views/video_call_screen.dart';
import 'package:falangthai/app/modules/favorites/views/favorite_screen.dart';
import 'package:falangthai/app/modules/favorites/views/matches_screen.dart';
import 'package:falangthai/app/modules/home/views/home_screen.dart';
import 'package:falangthai/app/modules/language/views/language_selection_screen.dart';
import 'package:falangthai/app/modules/profile/views/gender_screen.dart';
import 'package:falangthai/app/modules/profile/views/hobby_screen.dart';
import 'package:falangthai/app/modules/profile/views/profile_upload.dart';
import 'package:falangthai/app/modules/profile/views/relationship_preference.dart';
import 'package:falangthai/app/modules/splash/splash_screen.dart';
import 'package:falangthai/app/modules/welcome/views/welcome_screen.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.welcome, page: () => WelcomeScreen()),
    GetPage(name: AppRoutes.language, page: () => LanguageSelectionScreen()),
    GetPage(name: AppRoutes.signup, page: () => SignupScreen()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.gender, page: () => GenderScreen()),
    GetPage(name: AppRoutes.profileUpload, page: () => ProfileUploadScreen()),
    GetPage(name: AppRoutes.hobby, page: () => HobbiesSelectionScreen()),
    GetPage(name: AppRoutes.relationshipPreference, page: () => RelationshipPreferenceScreen()),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    GetPage(name: AppRoutes.favorite, page: () => FavoriteScreen()),
    GetPage(name: AppRoutes.matches, page: () => MatchesScreen()),
    GetPage(name: AppRoutes.chatList, page: () => ChatListScreen()),
    GetPage(name: AppRoutes.message, page: () => MessageScreen()),
    GetPage(name: AppRoutes.audioCall, page: () => AudioCallScreen()),
    GetPage(name: AppRoutes.videoCall, page: () => VideoCallScreen()),
  ];
}
