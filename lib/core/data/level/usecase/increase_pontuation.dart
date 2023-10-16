import 'package:crosswords/core/data/level/model/level.dart';
import 'package:crosswords/core/data/level/repositories/level_repository.dart';
import 'package:crosswords/core/failure/failure.dart';

class IncreasePontuation {
  final GetLevelsRepository _getLevelsRepository;
  final SaveLevelsRepository _saveLevelsRepository;

  const IncreasePontuation({required GetLevelsRepository getLevelsRepository, required SaveLevelsRepository saveLevelsRepository}) : _saveLevelsRepository = saveLevelsRepository, _getLevelsRepository = getLevelsRepository;

  Future<(Failure?, Level?)> call(Level level) async {
    var (failure, levels) = await _getLevelsRepository.getLevels();
    if(failure != null) {
      return (failure, null);
    }

    late Level result = level;

    for (int i=0; i<levels.length; i++) {
      if(levels[i].id == level.id) {
        level = levels[i];
        levels[i].increasePontuation(1);
      }
    }

    failure = await _saveLevelsRepository.saveLevels(levels);
    if(failure != null) {
      return (failure, null);
    }

    return (null, result);
  }
}