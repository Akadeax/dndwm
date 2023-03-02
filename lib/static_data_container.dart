import 'package:dndwm/player_class.dart';
import 'package:dndwm/race.dart';
import 'package:dndwm/role.dart';

class StaticDataContainer {
  List<Race>? races;
  List<PlayerClass>? classes;
  List<Role>? roles;

  StaticDataContainer({this.races, this.classes, this.roles});

  StaticDataContainer.fromJson(Map<String, dynamic> json) {
    if (json['races'] != null) {
      races = <Race>[];
      json['races'].forEach((v) {
        races!.add(Race.fromJson(v));
      });
    }
    if (json['classes'] != null) {
      classes = <PlayerClass>[];
      json['classes'].forEach((v) {
        classes!.add(PlayerClass.fromJson(v));
      });
    }
    if (json['roles'] != null) {
      roles = <Role>[];
      json['roles'].forEach((v) {
        roles!.add(Role.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (races != null) {
      data['races'] = races!.map((v) => v.toJson()).toList();
    }
    if (classes != null) {
      data['classes'] = classes!.map((v) => v.toJson()).toList();
    }
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
