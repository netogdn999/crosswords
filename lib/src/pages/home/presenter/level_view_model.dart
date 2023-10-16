import 'package:crosswords/core/data/level/model/level.dart';
import 'package:crosswords/core/failure/failure.dart';

enum LevelStates {
  initial,
  loading,
  failure,
  success,
  generated,
  emptyLevels,
}

class LevelViewModel {
  final List<Level> levels;
  final Failure? failure;
  final LevelStates state;

  const LevelViewModel.initial()
    : levels = const <Level>[],
      failure = null,
      state = LevelStates.initial;

  const LevelViewModel.loading({required List<Level>? levels})
    : levels = levels ?? const <Level>[],
      failure = null,
      state = LevelStates.loading;

  const LevelViewModel.failure({List<Level>? levels, required this.failure})
    : levels = levels ?? const <Level>[],
      state = LevelStates.failure;

  const LevelViewModel.emptyLevels({List<Level>? levels, required this.failure})
    : levels = levels ?? const <Level>[],
      state = LevelStates.emptyLevels;

  const LevelViewModel.success({required this.levels})
    : failure = null,
      state = LevelStates.success;

  const LevelViewModel.generated()
    : levels = const <Level>[],
      failure = null,
      state = LevelStates.generated;
}