import 'dart:core';

class PlayerClass {
  String? name;
  String? description;
  List<int>? bonus;
  String? feature;

  PlayerClass({this.name, this.description, this.bonus, this.feature});

  PlayerClass.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    bonus = json['bonus'].cast<int>();
    feature = json['feature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['bonus'] = bonus;
    data['feature'] = feature;
    return data;
  }
}