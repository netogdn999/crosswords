import 'package:crosswords/core/data/level/model/position.dart';

import '../data/level/model/word.dart';

extension ContainsValue on List<Map<int, Object>> {
  bool containsValue(int value) {
    bool result = false;
    for (Map<int, Object> element in this) {
      result = element.containsValue(value);
      if (result) {
        return result;
      }
    }
    return result;
  }
}

extension Constains on List<Word> {
  bool containsWord(String value) {
    for (Word word in this) {
      if(word.word == value) {
        return true;
      }
    }
    return false;
  }

  bool conflictWord(Word value) {
    const result = false;
    for (Word word in this) {
      if(word.isConflict(value)) {
        return true;
      }
    }
    return result;
  }

  Char? getCharByPosition(Position position) {
    for (Word word in this) {
      final char = word.chars.getCharByPosition(position);
      if (char != null) {
        return char;
      }
    }
    return null;
  }
}

extension ContainsPosition on List<Char> {
  Char? getCharByPosition(Position position) {
    for (Char char in this) {
      if (char.position == position) {
        return char;
      }
    }
    return null;
  }
}