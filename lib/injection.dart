
import 'package:crosswords/core/data/level/repositories/delete_all_levels_repository.dart';
import 'package:crosswords/core/data/level/repositories/get_levels_repository.dart';
import 'package:crosswords/core/data/level/repositories/level_repository.dart';
import 'package:crosswords/core/data/level/repositories/save_levels_repository.dart';
import 'package:crosswords/core/data/level/usecase/generate_level.dart';
import 'package:crosswords/core/data/level/usecase/increase_pontuation.dart';
import 'package:crosswords/core/data/level/usecase/update_level.dart';
import 'package:crosswords/src/pages/crossword/presenter/crossword_presenter.dart';
import 'package:crosswords/src/pages/home/presenter/level_presenter.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> injection() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  injectionRepositories();
  injectionUseCase();
  injectionPresenters();
}

void injectionUseCase() {

  getIt.registerLazySingleton<GenerateLevel>(() => GenerateLevel());
  getIt.registerLazySingleton<UpdateLevel>(() => UpdateLevel(
    getLevelsRepository: getIt<GetLevelsRepository>(),
    saveLevelsRepository: getIt<SaveLevelsRepository>(),
  ));
  getIt.registerLazySingleton<IncreasePontuation>(() => IncreasePontuation(
    getLevelsRepository: getIt<GetLevelsRepository>(),
    saveLevelsRepository: getIt<SaveLevelsRepository>(),
  ));
}

void injectionRepositories () {

  getIt.registerLazySingleton<GetLevelsRepository>(() => GetLevelsRepositoryImpl(
    sharedPreferences: getIt<SharedPreferences>()
  ));

  getIt.registerLazySingleton<SaveLevelsRepository>(() => SaveLevelsRepositoryImpl(
    sharedPreferences: getIt<SharedPreferences>()
  ));

  getIt.registerLazySingleton<DeleteAllLevelsRepository>(() => DeleteAllLevelsRepositoryImpl(
    sharedPreferences: getIt<SharedPreferences>()
  ));
}

void injectionPresenters() {

  getIt.registerFactory<LevelPresenter>(() => LevelPresenter(
    getLevelsRepository: getIt<GetLevelsRepository>(),
    saveLevelsRepository: getIt<SaveLevelsRepository>(),
    generateLevel: getIt<GenerateLevel>(),
    deleteAllLevelsRepository: getIt<DeleteAllLevelsRepository>(),
  ));

  getIt.registerFactory<CrosswordPresenter>(() => CrosswordPresenter(
    getLevelsRepository: getIt<GetLevelsRepository>(),
    updateLevel: getIt<UpdateLevel>(),
    increasePontuation: getIt<IncreasePontuation>(),
  ));
}