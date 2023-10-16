import 'dart:math';

import 'package:crosswords/core/data/level/model/position.dart';
import 'package:crosswords/core/data/level/model/word.dart';
import 'package:crosswords/core/extension/extension.dart';
import 'package:crosswords/core/inital_params.dart';

class GenerateLevel {
  final Map<String, Map<int, List<String>>> _wordsMap = {};
  final List<Word> _words = [];

  List<Word> call() {
    _wordsMap.clear();
    _words.clear();
    _mapWords();
    if(!_initBoard()) {
      return call();
    }
    _wordsNormalization();
    return List.from(_words);
  }

  void _mapWords() {
    for (var value in initialWords) {
      for (var element in value.runes.indexed) {
        final (index, charUniCode) = element;
        final char = String.fromCharCode(charUniCode);
        final charEntrie = _wordsMap[char];
        if (charEntrie != null) {
          if(!charEntrie.containsKey(index)) {
            _wordsMap[char]![index] = [value];
            continue;
          }
          _wordsMap[char]![index]?.add(value);
          continue;
        }
        _wordsMap[char] = {index: [value]};
      }
    }
  }

  bool _initBoard() {
    int attempts = 0;
    final random = Random(DateTime.now().millisecond);
    final randomIndex = random.nextInt(initialWords.length);
    final firstWord = initialWords.removeAt(randomIndex);
    _words.add(Word(position: const Position(0, 0), word: firstWord));
    int i=0;
    while(i < amountWords-1 || _wordsMap.isEmpty) {
      final lastWordChosen = _words[random.nextInt(_words.length)];
      final wordPosition = random.nextInt(lastWordChosen.word.length);
      final char = lastWordChosen.chars[wordPosition];

      final listWords = _wordsMap[char.value]?[wordPosition];
      if(listWords?.isEmpty ?? true) {
        _wordsMap[char.value]?.remove(wordPosition);
      }

      if(_wordsMap[char.value]?.isEmpty ?? false) {
        _wordsMap.remove(char.value);
      }

      final wordChosen = _wordsMap[char.value]?[wordPosition]?.removeLast();

      attempts++;

      if(attempts == 25) {
        return false;
      }

      if(wordChosen != null && !_words.containsWord(wordChosen)) {
        final word = Word(position: const Position(0, 0), word: wordChosen, isVertical: !lastWordChosen.isVertical);
        word.deslocByWordReference(char);
        if(!_words.conflictWord(word)) {
          _words.add(word);
          i++;
          attempts = 0;
        }
      }
    }
    return true;
  }

  void _wordsNormalization() {
    int minX = 0;
    int minY = 0;
    for (var element in _words) {
      final position = element.position;
      if(position.x < minX) {
        minX = position.x;
      }
      if(position.y < minY) {
        minY = position.y;
      }
    }
    final referPosition = Position(minX, minY);
    for (var element in _words) {
      element.shiftByPosition(referPosition);
    }
  }
}