import 'package:flutter/material.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/domain/repositories/property_repository.dart';

class BrowseViewModel extends ChangeNotifier {
  final PropertyRepository repository;

  BrowseViewModel(this.repository);

  List<PropertyEntity> properties = [];
  bool isLoading = false;

  Future<void> load(String type) async {
    isLoading = true;
    notifyListeners();

    properties = await repository.getPropertiesByType(type);

    isLoading = false;
    notifyListeners();
  }
}