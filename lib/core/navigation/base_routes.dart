import 'package:crosswords/src/pages/crossword/routes/crossword_routes.dart';
import 'package:crosswords/src/pages/home/routes/home_routes.dart';

import 'navigation_route.dart';

abstract class RoutePath {}

enum BaseRoutes implements RoutePath {
  home,
  crossword,
}

Map<BaseRoutes, NavigationRoute> defaultBuilderPages() => const {
  BaseRoutes.home: HomeRoutes(),
  BaseRoutes.crossword: CrosswordRoutes(),
};