class PropertyMetadataModel {
  final List<String> propertyTypes;
  final Map<String, List<String>> areas;

  PropertyMetadataModel({
    required this.propertyTypes,
    required this.areas,
  });

  factory PropertyMetadataModel.fromJson(Map<String, dynamic> json) {
    return PropertyMetadataModel(
      propertyTypes: List<String>.from(json['property_types'] ?? []),

      areas: (json['areas'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(
          key,
          List<String>.from(value),
        ),
      ),
    );
  }
}