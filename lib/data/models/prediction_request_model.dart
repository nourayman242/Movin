class PredictionRequestModel {
  final int sizeSqm;
  final int bedroomNum;
  final int bathroomsNumeric;
  final int isLand;
  final int isCash;
  final String mainArea;
  final String type;
  final String subArea;

  PredictionRequestModel({
    required this.sizeSqm,
    required this.bedroomNum,
    required this.bathroomsNumeric,
    required this.isLand,
    required this.isCash,
    required this.mainArea,
    required this.type,
    required this.subArea,
  });

  Map<String, dynamic> toJson() {
    return {
      "Size_sqm": sizeSqm,
      "Bedroom_Num": bedroomNum,
      "bathrooms_numeric": bathroomsNumeric,
      "is_land": isLand,
      "is_cash": isCash,
      "main_area": _capitalize(mainArea),
      "type": type,
      "sub_area": subArea.toLowerCase(),
    };
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;

    return value[0].toUpperCase() +
        value.substring(1).toLowerCase();
  }
}