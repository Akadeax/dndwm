class Role {
  String? name;
  int? ac;
  int? health;
  int? hitChanceBonus;
  int? strengthBonus;

  Role(
      {this.name,
        this.ac,
        this.health,
        this.hitChanceBonus,
        this.strengthBonus});

  Role.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ac = json['ac'];
    health = json['health'];
    hitChanceBonus = json['hitChanceBonus'];
    strengthBonus = json['strengthBonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['ac'] = ac;
    data['health'] = health;
    data['hitChanceBonus'] = hitChanceBonus;
    data['strengthBonus'] = strengthBonus;
    return data;
  }
}
