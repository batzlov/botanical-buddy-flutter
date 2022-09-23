class PlantType {
  int id;
  String? nameLat;
  String? nameGer;
  String? descGer;
  String? familyName;
  String? temDesc;
  String? lightDesc;
  String? moistureDesc;
  String? earthDesc;
  String? breedDesc;
  String? fertilizeDesc;

  PlantType({
    required this.id,
    this.nameLat,
    this.nameGer,
    this.descGer,
    this.familyName,
    this.temDesc,
    this.lightDesc,
    this.moistureDesc,
    this.earthDesc,
    this.breedDesc,
    this.fertilizeDesc,
  });

  factory PlantType.fromJson(Map<String, dynamic> json) {
    return PlantType(
      id: json['id'],
      nameLat: json['nameLat'],
      nameGer: json['nameGer'],
      descGer: json['descGer'],
      familyName: json['familyName'],
      temDesc: json['tempDesc'],
      lightDesc: json['lightDesc'],
      moistureDesc: json['moistureDesc'],
      earthDesc: json['earthDesc'],
      breedDesc: json['breedDesc'],
      fertilizeDesc: json['fertilizeDesc']
    );
  }
}