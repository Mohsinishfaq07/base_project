import '../globals/globals.dart';

List<String> mapTilesList = [
  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  'https://api.mapbox.com/styles/v1/mapbox/satellite-v9/tiles/{z}/{x}/{y}?access_token=$mapboxApiToken',
  'https://api.mapbox.com/styles/v1/devaisprojects/clbumfbd2002614mj3horj763/tiles/512/{z}/{x}/{y}?access_token=$mapboxApiToken&zoomwheel=true&fresh=true#17.31/33.618452/73.167914/0/82&pitch=75',
  // "https://api.mapbox.com/styles/v1/devaisprojects/clbumfbd2002614mj3horj763?title=view&access_token=pk.eyJ1IjoiZGV2YWlzcHJvamVjdHMiLCJhIjoiY2xicDFvaTJ5MDBjdzN1cXQxM2dyeHp6aiJ9.JOYTjGshZEnAHRrCMAi4Rg&zoomwheel=true&fresh=true#17.31/33.618452/73.167914/0/82"
  // "http://tile.opencyclemap.org/landscape/{z}/{x}/{y}.png",
  "http://services.arcgisonline.com/arcgis/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}",
  "http://basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
  "",
];
