import 'package:crosswords/core/data/level/model/level.dart';
import 'package:crosswords/core/failure/failure.dart';

enum CrosswordState {
  initial,
  loading,
  failure,
  success,
}

class CrosswordViewModel {
  final Level? level;
  final int width;
  final int height;
  final Failure? failure;
  final CrosswordState state;

  CrosswordViewModel.inital({this.level, this.width = 0, this.height = 0})
    : failure = null,
      state = CrosswordState.initial;

  CrosswordViewModel.loading({required this.level, this.width = 0, this.height = 0})
    : failure = null,
      state = CrosswordState.loading;

  CrosswordViewModel.failure({required this.level, required this.failure, this.width = 0, this.height = 0})
    : state = CrosswordState.failure;

  CrosswordViewModel.success({required this.level, this.width = 0, this.height = 0})
    : failure = null,
      state = CrosswordState.success;
}