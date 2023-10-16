import 'package:crosswords/core/failure/failure.dart';

import '../model/level.dart';

abstract class GetLevelsRepository {
  Future<(Failure?, List<Level>)> getLevels();
}

abstract class SaveLevelsRepository {
  Future<Failure?> saveLevels(List<Level> levels);
}

abstract class DeleteAllLevelsRepository {
  Future<Failure?> deleteAllLevels();
}