import 'package:crosswords/core/data/level/model/level.dart';
import 'package:crosswords/core/data/level/repositories/level_repository.dart';
import 'package:crosswords/core/data/level/usecase/generate_level.dart';
import 'package:crosswords/core/inital_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'level_view_model.dart';

class LevelPresenter extends Cubit<LevelViewModel> {
  final GetLevelsRepository _getLevelsRepository;
  final SaveLevelsRepository _saveLevelsRepository;
  final GenerateLevel _generateLevel;
  final DeleteAllLevelsRepository _deleteAllLevelsRepository;
  
  LevelPresenter({
    required GetLevelsRepository getLevelsRepository,
    required SaveLevelsRepository saveLevelsRepository,
    required GenerateLevel generateLevel,
    required DeleteAllLevelsRepository deleteAllLevelsRepository,
  }) : _getLevelsRepository = getLevelsRepository, _saveLevelsRepository = saveLevelsRepository, _generateLevel = generateLevel, _deleteAllLevelsRepository = deleteAllLevelsRepository, super(const LevelViewModel.initial());

  void loadLevels() async {
    emit(LevelViewModel.loading(levels: state.levels));

    final (failure, result) = await _getLevelsRepository.getLevels();
    if(failure != null) {
      emit(LevelViewModel.emptyLevels(failure: failure));
      return;
    }

    emit(LevelViewModel.success(levels: result));
  }

  void deleteAllLevels() async {
    emit(LevelViewModel.loading(levels: state.levels));

    final failure = await _deleteAllLevelsRepository.deleteAllLevels();
    if(failure != null) {
      emit(LevelViewModel.emptyLevels(failure: failure));
      return;
    }

    emit(LevelViewModel.success(levels: state.levels));
  }

  void generateLevels() async {
    emit(LevelViewModel.loading(levels: state.levels));

    final levels = <Level>[];
    
    for (int i=1; i <= amountLevels; i++) {
      final words = _generateLevel();
      final level = Level(id: i, rating: 0, words: words);
      levels.add(level);
    }

    final failure = await _saveLevelsRepository.saveLevels(levels);
    if(failure != null) {
      emit(LevelViewModel.failure(failure: failure));
      return;
    }

    emit(const LevelViewModel.generated());
  }
}
