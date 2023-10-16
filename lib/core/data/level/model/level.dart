import 'package:crosswords/core/inital_params.dart';

import 'word.dart';

class Level {
  final int id;
  int rating;
  List<Word> words;
  int pontuationTotal = 0;
  int currentPontuation = 0;
  String get asset =>
    switch(rating) {
      1 => 'assets/levels/one_rating.svg',
      2 => 'assets/levels/two_rating.svg',
      3 => 'assets/levels/three_rating.svg',
      _ => 'assets/levels/zero_rating.svg'
    };
  String get message => phrases[id-1];

  Level({
    required this.id,
    required this.rating,
    required this.words,
    int? pontuationTotal,
    this.currentPontuation = 0,
  }) {
    this.pontuationTotal = pontuationTotal ?? initPontuation();
  }

  bool updateWord(Char char) {
    for (Word word in words) {
      if(word.updateChar(char)) {
        return true;
      }
    }
    return false;
  }

  int initPontuation() {
    final Map<dynamic, dynamic> positions = {};
    for (var element in words) {
      for (var char in element.chars) {
        if(!positions.containsKey(char.position)) {
          positions[char.position] = char.isVisible;
        }
      }
    }
    positions.removeWhere((key, value) => value);
    return positions.length;
  }

  void increasePontuation(int increase) {
    currentPontuation += increase;
    final oneStar = pontuationTotal / 3;
    final twoStar = 2 * pontuationTotal / 3;
    final threeStar = pontuationTotal;
    if(currentPontuation >= oneStar && currentPontuation < twoStar) {
      rating = 1;
    }
    if(currentPontuation >= twoStar && currentPontuation < threeStar) {
      rating = 2;
    }
    if(currentPontuation >= threeStar) {
      rating = 3;
    }
  }

  Map<String, dynamic> tojson() => {
    'id': id,
    'words': words.map((word) => word.toJson()).toList(),
    'rating': rating,
    'pontuationTotal': pontuationTotal,
    'currentPontuation': currentPontuation,
  };

  factory Level.fromJson(Map<String, dynamic> map) {
    final wordsList = map['words'] as List<dynamic>;
    return Level(
      id: map['id'],
      words: wordsList.map((json) => Word.fromJson(json)).toList(),
      rating: map['rating'],
      pontuationTotal: map['pontuationTotal'],
      currentPontuation: map['currentPontuation'],
    );
  }

  @override
  String toString() => 'Level(id: $id, words: $words, rating: $rating, pontuationTotal: $pontuationTotal, currentPontuation: $currentPontuation)';

  @override
  bool operator ==(covariant Level other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.rating == rating &&
      other.words == words &&
      other.pontuationTotal == pontuationTotal &&
      other.currentPontuation == currentPontuation;
  }

  @override
  int get hashCode => Object.hash(id, rating, words);

  Level copyWith({
    int? id,
    int? rating,
    List<Word>? words,
    int? pontuationTotal,
    int? currentPontuation,
  }) {
    return Level(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      words: words ?? this.words,
      pontuationTotal: pontuationTotal ?? this.pontuationTotal,
      currentPontuation: currentPontuation ?? this.currentPontuation,
    );
  }
}
