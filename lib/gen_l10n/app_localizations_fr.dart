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

  @override
  String get createAccountTitle => 'Créer un compte';

  @override
  String get createAccountSubtitle =>
      'Rejoignez notre communauté et commencez à vous connecter';

  @override
  String get fullName => 'Nom complet';

  @override
  String get email => 'E-mail';

  @override
  String get iAgreeTo => 'J\'accepte les ';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get and => ' et ';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ? ';

  @override
  String get verificationTitle => 'Vérification';

  @override
  String get otpHeadingPrefix => 'Entrez votre ';

  @override
  String get otpHeadingOtp => 'code';

  @override
  String get otpSentTo => 'Un code de vérification a été envoyé à';

  @override
  String get wrongDetails => 'Mauvaises informations ?';

  @override
  String get change => ' Modifier';

  @override
  String get continueText => 'Continuer';

  @override
  String get didntReceiveCode => 'Vous n\'avez pas reçu le code ? ';

  @override
  String get resend => 'Renvoyer';

  @override
  String get skip => 'Passer';

  @override
  String get genderTitle => 'Quel est votre genre ?';

  @override
  String get genderSubtitle =>
      'Aidez-nous à personnaliser votre expérience\nen sélectionnant votre genre';

  @override
  String get male => 'Homme';

  @override
  String get female => 'Femme';

  @override
  String get others => 'Autre';

  @override
  String get preferNotToSay => 'Préfère ne pas le dire';

  @override
  String get locationRequestTitle => 'Demande de localisation';

  @override
  String get locationRequestBody =>
      'Pour vous aider à trouver des rencontres pertinentes à proximité, nous avons besoin d\'accéder à votre localisation. Notre algorithme de rencontre utilise votre position pour :\n\n• Vous montrer des profils potentiels dans votre zone\n• Calculer la distance exacte entre vous et les autres utilisateurs\n• Proposer de meilleures suggestions en fonction de la proximité\n• Activer les fonctionnalités et événements basés sur la localisation\n\nVos données de localisation restent toujours privées et protégées.';

  @override
  String get allowLocation => 'Autoriser la localisation';

  @override
  String get addYourPhotoTitle => 'Ajoutez votre photo';

  @override
  String get addYourPhotoSubtitle =>
      'Montrez votre plus beau sourire au monde !\nCela aide les autres à vous reconnaître';

  @override
  String get dateOfBirthPlaceholder => 'Date de naissance';

  @override
  String get bioPlaceholder => 'Bio';

  @override
  String get whatAreYourHobbies => 'Quels sont vos loisirs ?';

  @override
  String get hobbiesSubtitle =>
      'Aidez les autres à découvrir ce qui vous rend unique !\nSélectionnez les activités que vous aimez';

  @override
  String hobbiesSelectionCounter(Object count) {
    return '$count loisirs sélectionnés';
  }

  @override
  String get reading => 'Lecture';

  @override
  String get music => 'Musique';

  @override
  String get cooking => 'Cuisine';

  @override
  String get travel => 'Voyage';

  @override
  String get photography => 'Photographie';

  @override
  String get sports => 'Sports';

  @override
  String get gaming => 'Jeux vidéo';

  @override
  String get art => 'Art';

  @override
  String get fitness => 'Fitness';

  @override
  String get movies => 'Films';

  @override
  String get dancing => 'Danse';

  @override
  String get gardening => 'Jardinage';

  @override
  String get writing => 'Écriture';

  @override
  String get tech => 'Technologie';

  @override
  String get fashion => 'Mode';

  @override
  String get volunteering => 'Bénévolat';

  @override
  String get selectAtLeast3Hobbies => 'Sélectionnez au moins 3 loisirs';

  @override
  String selectMoreHobbies(Object count) {
    return 'Sélectionnez encore $count loisirs';
  }

  @override
  String hobbiesSelected(Object count) {
    return '$count/8 loisirs sélectionnés';
  }

  @override
  String get maximumSelection => 'Sélection maximale';

  @override
  String get youCanSelectUpTo8HobbiesOnly =>
      'Vous pouvez sélectionner jusqu\'à 8 loisirs seulement';

  @override
  String get editHobbies => 'Modifier les loisirs';

  @override
  String get relationshipTitle => 'Qui vous intéresse ?';

  @override
  String get relationshipSubtitle =>
      'Sélectionnez les préférences qui s\'appliquent pour nous aider\nà trouver vos correspondances idéales';

  @override
  String get prefMen => 'Hommes';

  @override
  String get prefWomen => 'Femmes';

  @override
  String get prefNonBinary => 'Non-binaire';

  @override
  String get prefTransgender => 'Transgenre';

  @override
  String get prefEveryone => 'Tout le monde';

  @override
  String get noMatchesFound => 'Aucune correspondance trouvée';

  @override
  String get noUsersFound => 'Aucun utilisateur trouvé';

  @override
  String get likesTitle => 'Mentions J\'aime';

  @override
  String get matchesTitle => 'Correspondances';
}
