import 'package:flutter/material.dart';

abstract class AppColors {
  static const LevelsColors levels = LevelsColors();
  static const AppBarColors appBar = AppBarColors();
  static const CrosswordColors crossword = CrosswordColors();
  static const DialogsColors dialog = DialogsColors();
}

class LevelsColors {
  final background = Colors.white;
  final border = Colors.blueGrey;

  const LevelsColors();
}

class AppBarColors {
  final background = Colors.transparent;
  final foreground = Colors.white;

  const AppBarColors();
}

class CrosswordColors {
  final wrong = Colors.red;
  final backgroundBlank = Colors.white;
  final border = Colors.black;

  const CrosswordColors();
}

class DialogsColors {
  final background = Colors.transparent;
  final contentBackground = Colors.white;
  final shadow = Colors.transparent;
  final surface = Colors.transparent;

  const DialogsColors();
}