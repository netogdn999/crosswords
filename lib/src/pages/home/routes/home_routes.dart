import 'package:crosswords/core/constants/strings.dart';
import 'package:crosswords/core/navigation/base_routes.dart';
import 'package:crosswords/core/navigation/navigation_route.dart';
import 'package:crosswords/injection.dart';
import 'package:crosswords/src/pages/home/presenter/level_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_page.dart';

class HomeRoutes implements NavigationRoute<RoutePath> {
  @override
  List<Page> routes({required route, params}) => [
    MaterialPage(
      key: ValueKey(AppStrings.namePages.homePage),
      child: BlocProvider<LevelPresenter>(
        create: (_) => getIt<LevelPresenter>()
          // ..deleteAllLevels()
          ..loadLevels(),
        child: HomePage(
          title: AppStrings.namePages.homePage,
        ),
      ),
    ),
  ];

  const HomeRoutes();
}
