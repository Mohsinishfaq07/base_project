import 'package:sb_myreports/core/router/models/page_keys.dart';
import 'package:sb_myreports/core/router/models/page_paths.dart';

import '../pages.dart';

class PageConfigs {
  static PageConfiguration splashPageConfig = const PageConfiguration(
      key: PageKeys.splashPageKey,
      path: PagePaths.splashPagePath,
      uiPage: Pages.splashPage);

  static PageConfiguration jokePageConfig = const PageConfiguration(
      key: PageKeys.jokePageKey,
      path: PagePaths.jokePagePath,
      uiPage: Pages.jokePage);

  static PageConfiguration jokeListPageConfig = const PageConfiguration(
      key: PageKeys.jokeListPageKey,
      path: PagePaths.jokesListPagePath,
      uiPage: Pages.jokesListPage);
  static PageConfiguration googleMapPageConfig = const PageConfiguration(
      key: PageKeys.googleMapPageKey,
      path: PagePaths.googleMapPagePath,
      uiPage: Pages.googleMapPage);
}
