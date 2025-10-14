

String calculateAge(String? isoDate) {
  if (isoDate == null || isoDate.isEmpty) {
    return "0";
  }
  DateTime birthDate = DateTime.parse(isoDate);
  DateTime today = DateTime.now();

  int age = today.year - birthDate.year;

  // Adjust age if the birthday hasn't occurred yet this year
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age.toString();
}
