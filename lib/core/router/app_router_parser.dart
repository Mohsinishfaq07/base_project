import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'models/page_config.dart';
import 'models/page_paths.dart';
import 'pages.dart';

class appRouterParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return SynchronousFuture(PageConfigs.splashPageConfig);
    }

    final path = '/' + uri.pathSegments[0];

    switch (path) {
      case PagePaths.splashPagePath:
        return SynchronousFuture(PageConfigs.splashPageConfig);
      default:
        return SynchronousFuture(PageConfigs.splashPageConfig);
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.splashPage:
        return const RouteInformation(location: PagePaths.splashPagePath);

      case Pages.jokePage:
        return const RouteInformation(location: PagePaths.jokePagePath);

      case Pages.jokesListPage:
        return const RouteInformation(location: PagePaths.jokesListPagePath);

      case Pages.googleMapPage:
        return const RouteInformation(location: PagePaths.googleMapPagePath);
    }
  }
}
