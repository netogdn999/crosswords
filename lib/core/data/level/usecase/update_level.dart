import 'package:crosswords/core/data/level/model/level.dart';
import 'package:crosswords/core/data/level/model/word.dart';
import 'package:crosswords/core/data/level/repositories/level_repository.dart';
import 'package:crosswords/core/failure/failure.dart';

class UpdateLevel {
  final GetLevelsRepository _getLevelsRepository;
  final SaveLevelsRepository _saveLevelsRepository;

  const UpdateLevel({required GetLevelsRepository getLevelsRepository, required SaveLevelsRepository saveLevelsRepository}) : _saveLevelsRepository = saveLevelsRepository, _getLevelsRepository = getLevelsRepository;

  Future<(Failure?, Level?)> call(Level level, Char char) async {
    var (failure, levels) = await _getLevelsRepository.getLevels();
    if(failure != null) {
      return (failure, null);
    }

    late Level result = level;

    for (int i=0; i<levels.length; i++) {
      if(levels[i].id == level.id) {
        for (int j=0; j<levels[i].words.length; j++) {
          if(levels[i].words[j].updateChar(char)) {
            result = levels[i];
          }
        }
      }
    }

    failure = await _saveLevelsRepository.saveLevels(levels);
    if(failure != null) {
      return (failure, null);
    }

    return (null, result);
  }
}