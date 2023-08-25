class AppUrl {
  // static const String baseUrl = 'https://qa-appapi.appinsnap.com/api/v1/';
  static const String baseUrl = 'https://api.chucknorris.io/';
  static const String randomJokeUrl = 'jokes/random';
  static const String queryJokesUrl = 'jokes/search';
  //// Google api
  static const String googleApisBaseUrl = 'https://maps.googleapis.com/maps/';
  static const String queryPlaceUrl =
      'api/place/textsearch/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&inputtype=textquery';
  static const String googleDirectionApiUrl = "api/directions/json?";
  //// Mapbox api
  static const String mapboxApiBaseUrl = "https://api.mapbox.com/";
  static const String mapboxDirectionApiUrl = "directions/v5/mapbox/";
  static const String mapboxDirectionApiEndUrl =
      "?alternatives=true&geometries=polyline&language=en&overview=simplified&steps=true";
}
