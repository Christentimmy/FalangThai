// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get loginText1 => 'Connectez-vous pour continuer votre parcours';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get signIn => 'Se connecter';

  @override
  String get orContinueWith => 'Ou continuer avec';

  @override
  String get google => 'Google';

  @override
  String get facebook => 'Facebook';

  @override
  String get dontHaveAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get signUp => 'Inscription';

  @override
  String get loading => 'Chargement...';
}
