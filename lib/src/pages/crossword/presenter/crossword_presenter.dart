import 'package:crosswords/core/data/level/model/level.dart';
import 'package:crosswords/core/data/level/model/word.dart';
import 'package:crosswords/core/data/level/repositories/level_repository.dart';
import 'package:crosswords/core/data/level/usecase/increase_pontuation.dart';
import 'package:crosswords/core/data/level/usecase/update_level.dart';
import 'package:crosswords/core/failure/failure.dart';
import 'package:crosswords/src/pages/crossword/presenter/crossword_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrosswordPresenter extends Cubit<CrosswordViewModel> {
  final GetLevelsRepository _getLevelsRepository;
  final UpdateLevel _updateLevel;
  final IncreasePontuation _increasePontuation;

  CrosswordPresenter({
    required GetLevelsRepository getLevelsRepository,
    required UpdateLevel updateLevel,
    required IncreasePontuation increasePontuation,
  })
   : _getLevelsRepository = getLevelsRepository, _updateLevel = updateLevel, _increasePontuation = increasePontuation, super(CrosswordViewModel.inital());

  void loadLevel(int id) async {
    emit(CrosswordViewModel.loading(level: state.level, width: state.width, height: state.height));

    final (failure, result) = await _getLevelsRepository.getLevels();

    if (failure != null) {
      emit(CrosswordViewModel.failure(level: state.level, failure: failure, width: state.width, height: state.height));
      return;
    }

    late Level level;

    for (var element in result) {
      if(element.id == id) {
        level = element;
        break;
      }
    }

    int maxX = 0;
    int maxY = 0;
    for (var element in level.words) {
      final position = element.chars.last.position;
      if(position.x > maxX) {
        maxX = position.x;
      }
      if(position.y > maxY) {
        maxY = position.y;
      }
    }

    emit(CrosswordViewModel.success(level: level, width: maxX, height: maxY));
  }

  Future<void> updateLevel(Char char) async {

    if(state.level == null) {
      emit(CrosswordViewModel.failure(
        level: state.level,
        failure: const Failure(message: 'Um level deve ser selecionado'),
        width: state.width,
        height: state.height,
      ));
    }

    final (failure, level) = await _updateLevel(state.level!, char);

    if(failure != null) {
      emit(CrosswordViewModel.failure(
        level: state.level,
        failure: failure,
        width: state.width,
        height: state.height,
      ));
      return;
    }
    
    emit(CrosswordViewModel.success(level: level, width: state.width, height: state.height));
  }

  Future<void> increasePontuation() async {

    if(state.level == null) {
      emit(CrosswordViewModel.failure(
        level: state.level,
        failure: const Failure(message: 'Um level deve ser selecionado'),
        width: state.width,
        height: state.height,
      ));
    }

    final (failure, level) = await _increasePontuation(state.level!);

    if(failure != null) {
      emit(CrosswordViewModel.failure(
        level: state.level,
        failure: failure,
        width: state.width,
        height: state.height,
      ));
      return;
    }
    
    emit(CrosswordViewModel.success(level: level, width: state.width, height: state.height));
  }
}