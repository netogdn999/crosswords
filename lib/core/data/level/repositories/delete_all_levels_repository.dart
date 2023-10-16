
import 'package:crosswords/core/data/level/repositories/level_repository.dart';
import 'package:crosswords/core/failure/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAllLevelsRepositoryImpl implements DeleteAllLevelsRepository {
  final SharedPreferences _sharedPreferences;
  final String levelsKey = "all_levels";

  const DeleteAllLevelsRepositoryImpl({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  @override
  Future<Failure?> deleteAllLevels() async {
    try {
      if (_sharedPreferences.containsKey(levelsKey)){
        final response = await _sharedPreferences.remove(levelsKey);
        if (!response) {
          return const Failure(message: "erro ao delete levels");
        }
      }
      
      return null;
    } catch (ex) {
      return Failure(message: ex.toString());
    }
  }

}