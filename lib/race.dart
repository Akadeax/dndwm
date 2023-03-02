class Race {
  String? name;
  String? description;
  List<String>? features;

  Race({this.name, this.description, this.features});

  Race.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    features = json['features'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['features'] = features;
    return data;
  }
}
