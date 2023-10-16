import 'package:crosswords/core/constants/strings.dart';
import 'package:crosswords/core/navigation/base_routes.dart';
import 'package:crosswords/core/navigation/navigation_route.dart';
import 'package:crosswords/injection.dart';
import 'package:crosswords/src/pages/crossword/crossword_page.dart';
import 'package:crosswords/src/pages/crossword/presenter/crossword_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrosswordRoutes implements NavigationRoute<RoutePath> {
  @override
  List<Page> routes({required route, params}) => [
        MaterialPage(
          key: ValueKey(AppStrings.namePages.crosswordPage),
          child: BlocProvider<CrosswordPresenter>(
            create: (_) => getIt<CrosswordPresenter>()..loadLevel(params['id']),
            child: CrosswordPage(
              title: AppStrings.namePages.crosswordPage,
              id: params['id'],
            ),
          ),
        )
      ];

  const CrosswordRoutes();
}
