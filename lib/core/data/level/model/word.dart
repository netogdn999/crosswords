import 'dart:math';

import 'package:crosswords/core/inital_params.dart';

import 'position.dart';

class Word {
  List<Char> chars = [];
  final bool isVertical;
  final String word;
  Position position;

  Word({required this.position, required this.word, this.isVertical = false, List<Char>? chars}) {
    if(chars == null) {
      int cordX = position.x;
      int cordY = position.y;
      final random = Random(DateTime.now().millisecond);
      final List<int> positionInvisible = [];
      while (positionInvisible.length != (word.length * 0.3).ceil()) {
        final randomPosition = random.nextInt(word.length);
        if(!positionInvisible.contains(randomPosition)) {
          positionInvisible.add(randomPosition);
        }
      }
      int color = wordsColor[random.nextInt(wordsColor.length)];
      bool isVisible = false;
      for (var char in word.runes) {
        final letra = Char(position: Position(cordX, cordY), value: String.fromCharCode(char), isVisible: isVisible, color: color);
        this.chars.add(letra);
        if (isVertical) {
          cordY ++;
          isVisible = positionInvisible.contains(cordY);
          continue;
        }
        isVisible = positionInvisible.contains(cordX);
        cordX ++;
      }
      return;
    }

    this.chars.addAll(chars);
  }

  bool updateChar(Char newChar) {
    for (int i=0; i<chars.length; i++) {
      if(chars[i].position == newChar.position) {
        chars[i] = newChar.copyWith(value: newChar.value, isVisible: newChar.isVisible);
        return true;
      }
    }
    return false;
  }

  void deslocByWordReference(Char referenceChar) {
    final indexChar = chars.indexWhere((element) => element.value == referenceChar.value);
    final char = chars[indexChar];
    int x = referenceChar.position.x - char.position.x;
    int y = referenceChar.position.y - char.position.y;
    for (var element in chars) {
      element.position = element.position + Position(x, y);
    }
    position = chars.first.position;
  }

  void shiftByPosition(Position referPosition) {
    for (var element in chars) {
      element.position = element.position - referPosition;
    }
    position = chars.first.position;
  }

  bool isConflict(Word value) {
    int count = 0;
    for(Char element in chars) {
      for(Char e2 in value.chars) {
        if(element.position == e2.position && element.value != e2.value) {
          count++;
        }
        if(count > 0) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  String toString() => "$chars";


  Map<String, dynamic> toJson() => {
    'chars': chars.map((char) => char.toJson()).toList(),
    'isVertical': isVertical,
    'word': word,
    'position': position.tojson(),
  };

  factory Word.fromJson(Map<String, dynamic> map) {
    final charsJson = map['chars'] as List<dynamic>;
    return Word(
      chars: charsJson.map((json) => Char.fromJson(json)).toList(),
      isVertical: map['isVertical'],
      word: map['word'],
      position: Position.fromJson(map['position']),
    );
  }
}

class Char {
  final String value;
  final int color;
  Position position;
  bool isVisible;

  Char({required this.position, required this.value, required this.isVisible, required this.color});

  @override
  String toString() => "$value -> $position";

  Map<String, dynamic> toJson() => {
    'position': position.tojson(),
    'value': value,
    'isVisible': isVisible,
    'color': color,
  };

  factory Char.fromJson(Map<String, dynamic> map) {
    return Char(
      position: Position.fromJson(map['position']),
      value: map['value'],
      isVisible: map['isVisible'],
      color: map['color'],
    );
  }


  Char copyWith({
    String? value,
    int? color,
    Position? position,
    bool? isVisible,
  }) {
    return Char(
      value: value ?? this.value,
      color: color ?? this.color,
      position: position ?? this.position,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
