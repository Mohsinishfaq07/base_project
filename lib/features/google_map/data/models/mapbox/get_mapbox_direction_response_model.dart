class GetMapboxDirectionResponseModel {
  List<Routes>? routes;
  List<Waypoints>? waypoints;
  String? code;
  String? uuid;

  GetMapboxDirectionResponseModel(
      {this.routes, this.waypoints, this.code, this.uuid});

  GetMapboxDirectionResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(Routes.fromJson(v));
      });
    }
    if (json['waypoints'] != null) {
      waypoints = <Waypoints>[];
      json['waypoints'].forEach((v) {
        waypoints!.add(Waypoints.fromJson(v));
      });
    }
    code = json['code'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (routes != null) {
      data['routes'] = routes!.map((v) => v.toJson()).toList();
    }
    if (waypoints != null) {
      data['waypoints'] = waypoints!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['uuid'] = uuid;
    return data;
  }
}

class Routes {
  bool? countryCrossed;
  double? weightTypical;
  double? durationTypical;
  String? weightName;
  double? weight;
  double? duration;
  double? distance;
  List<Legs>? legs;
  String? geometry;

  Routes(
      {this.countryCrossed,
      this.weightTypical,
      this.durationTypical,
      this.weightName,
      this.weight,
      this.duration,
      this.distance,
      this.legs,
      this.geometry});

  Routes.fromJson(Map<String, dynamic> json) {
    countryCrossed = json['country_crossed'];
    weightTypical = (json['weight_typical'] ?? 0).toDouble();
    durationTypical = (json['duration_typical'] ?? 0).toDouble();
    weightName = json['weight_name'];
    weight = (json['weight'] ?? 0).toDouble();
    duration = (json['duration'] ?? 0).toDouble();
    distance = (json['distance'] ?? 0).toDouble();
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add(Legs.fromJson(v));
      });
    }
    geometry = json['geometry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_crossed'] = countryCrossed;
    data['weight_typical'] = weightTypical;
    data['duration_typical'] = durationTypical;
    data['weight_name'] = weightName;
    data['weight'] = weight;
    data['duration'] = duration;
    data['distance'] = distance;
    if (legs != null) {
      data['legs'] = legs!.map((v) => v.toJson()).toList();
    }
    data['geometry'] = geometry;
    return data;
  }
}

class Legs {
  double? weightTypical;
  double? durationTypical;
  double? weight;
  double? duration;
  List<Steps>? steps;
  double? distance;
  String? summary;

  Legs({
    this.weightTypical,
    this.durationTypical,
    this.weight,
    this.duration,
    this.steps,
    this.distance,
    this.summary,
  });

  Legs.fromJson(Map<String, dynamic> json) {
    weightTypical = (json['weight_typical'] ?? 0).toDouble();
    durationTypical = (json['duration_typical'] ?? 0).toDouble();
    weight = (json['weight'] ?? 0).toDouble();
    duration = (json['duration'] ?? 0).toDouble();
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
    distance = (json['distance'] ?? 0).toDouble();
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weight_typical'] = weightTypical;
    data['duration_typical'] = durationTypical;
    data['weight'] = weight;
    data['duration'] = duration;
    if (steps != null) {
      data['steps'] = steps!.map((v) => v.toJson()).toList();
    }
    data['distance'] = distance;
    data['summary'] = summary;
    return data;
  }
}

class Steps {
  Maneuver? maneuver;
  String? name;
  double? weightTypical;
  double? durationTypical;
  double? duration;
  double? distance;
  String? drivingSide;
  double? weight;
  String? mode;
  String? geometry;
  String? destinations;
  String? ref;
  String? rotaryName;

  Steps(
      {this.maneuver,
      this.name,
      this.weightTypical,
      this.durationTypical,
      this.duration,
      this.distance,
      this.drivingSide,
      this.weight,
      this.mode,
      this.geometry,
      this.destinations,
      this.ref,
      this.rotaryName});

  Steps.fromJson(Map<String, dynamic> json) {
    maneuver =
        json['maneuver'] != null ? Maneuver.fromJson(json['maneuver']) : null;
    name = json['name'];
    weightTypical = (json['weight_typical'] ?? 0).toDouble();
    durationTypical = (json['duration_typical'] ?? 0).toDouble();
    duration = (json['duration'] ?? 0).toDouble();
    distance = (json['distance'] ?? 0).toDouble();
    drivingSide = json['driving_side'];
    weight = (json['weight'] ?? 0).toDouble();
    mode = json['mode'];
    geometry = json['geometry'];
    destinations = json['destinations'];
    ref = json['ref'];
    rotaryName = json['rotary_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (maneuver != null) {
      data['maneuver'] = maneuver!.toJson();
    }
    data['name'] = name;
    data['weight_typical'] = weightTypical;
    data['duration_typical'] = durationTypical;
    data['duration'] = duration;
    data['distance'] = distance;
    data['driving_side'] = drivingSide;
    data['weight'] = weight;
    data['mode'] = mode;
    data['geometry'] = geometry;
    data['destinations'] = destinations;
    data['ref'] = ref;
    data['rotary_name'] = rotaryName;
    return data;
  }
}

class Maneuver {
  String? type;
  String? instruction;
  int? bearingAfter;
  int? bearingBefore;
  List<double>? location;
  String? modifier;

  Maneuver({
    this.type,
    this.instruction,
    this.bearingAfter,
    this.bearingBefore,
    this.location,
    this.modifier,
  });

  Maneuver.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    instruction = json['instruction'];
    bearingAfter = json['bearing_after'];
    bearingBefore = json['bearing_before'];
    location = json['location'].cast<double>();
    modifier = json['modifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['instruction'] = instruction;
    data['bearing_after'] = bearingAfter;
    data['bearing_before'] = bearingBefore;
    data['location'] = location;
    data['modifier'] = modifier;
    return data;
  }
}

class Waypoints {
  double? distance;
  String? name;
  List<double>? location;

  Waypoints({this.distance, this.name, this.location});

  Waypoints.fromJson(Map<String, dynamic> json) {
    distance = (json['distance'] ?? 0).toDouble();
    name = json['name'];
    location = json['location'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['distance'] = distance;
    data['name'] = name;
    data['location'] = location;
    return data;
  }
}
