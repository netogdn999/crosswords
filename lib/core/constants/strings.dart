abstract class AppStrings {
  static const NamePages namePages = NamePages();
  static const Dialog dialog = Dialog();
  static const Button button = Button();
}

class NamePages {
  String get homePage => "Níveis";
  String get crosswordPage => "Palavras cruzadas";

  const NamePages();
}

class Dialog {
  String get title => "Parabéns!";

  const Dialog();
}

class Button {
  String get resetButton => "Reiniciar níveis";

  const Button();
}