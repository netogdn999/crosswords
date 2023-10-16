import 'dart:convert';

import 'package:crosswords/core/data/level/model/level.dart';
import 'package:crosswords/core/data/level/repositories/level_repository.dart';
import 'package:crosswords/core/failure/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLevelsRepositoryImpl implements GetLevelsRepository {
  final SharedPreferences _sharedPreferences;
  final String levelsKey = "all_levels";

  const GetLevelsRepositoryImpl({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;


  @override
  Future<(Failure?, List<Level>)> getLevels() async {
    try {
      final response = _sharedPreferences.getString(levelsKey);
      if (response == null) {
        return (const Failure(message: "nenhum level encontrado"), <Level>[]);
      }
      final responseJson = jsonDecode(response) as List<dynamic>;

      final result = responseJson.map((json) => Level.fromJson(json)).toList();
      return (null, result);
    } catch (ex) {
      return (Failure(message: ex.toString()), <Level>[]);
    }
  }

}