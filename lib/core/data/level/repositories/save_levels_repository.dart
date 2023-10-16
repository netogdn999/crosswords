import 'dart:convert';

import 'package:crosswords/core/data/level/model/level.dart';
import 'package:crosswords/core/data/level/repositories/level_repository.dart';
import 'package:crosswords/core/failure/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLevelsRepositoryImpl implements SaveLevelsRepository {
  final SharedPreferences _sharedPreferences;
  final String levelsKey = "all_levels";

  const SaveLevelsRepositoryImpl({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  @override
  Future<Failure?> saveLevels(List<Level> levels) async {
    try {
      final jsonLevels = levels.map((level) => level.tojson()).toList();
      final response = await _sharedPreferences.setString(levelsKey, jsonEncode(jsonLevels));
      if (!response) {
        return const Failure(message: "falha ao salvar levels");
      }
      return null;
    } catch (ex) {
      return Failure(message: ex.toString());
    }
  }

}