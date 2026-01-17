class BacSections {
  static const String science = "Sciences Expérimentales";
  static const String math = "Mathématiques";
  static const String tech = "Technique";
  static const String economy = "Économie et Gestion";
  static const String info = "Sciences de l'Informatique";
  static const String letters = "Lettres";

  static const List<String> all = [
    science,
    math,
    tech,
    economy,
    info,
    letters,
  ];

  static String getShortName(String fullName) {
    switch (fullName) {
      case science:
        return "Sciences";
      case math:
        return "Math";
      case tech:
        return "Tech";
      case economy:
        return "Éco";
      case info:
        return "Info";
      case letters:
        return "Lettres";
      default:
        return fullName;
    }
  }
}