// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get welcomeBack => 'ยินดีต้อนรับกลับ';

  @override
  String get loginText1 => 'เข้าสู่ระบบเพื่อใช้งานต่อ';

  @override
  String get emailAddress => 'อีเมล';

  @override
  String get password => 'รหัสผ่าน';

  @override
  String get forgotPassword => 'ลืมรหัสผ่าน?';

  @override
  String get signIn => 'เข้าสู่ระบบ';

  @override
  String get orContinueWith => 'หรือต่อด้วย';

  @override
  String get google => 'Google';

  @override
  String get facebook => 'Facebook';

  @override
  String get dontHaveAccount => 'ยังไม่มีบัญชี?';

  @override
  String get signUp => 'สมัครสมาชิก';

  @override
  String get loading => 'กำลังโหลด...';
}
