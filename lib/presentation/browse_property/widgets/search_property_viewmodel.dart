import 'package:flutter/material.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/domain/repositories/property_repository.dart';

class SearchPropertyViewModel extends ChangeNotifier {
  final PropertyRepository repository;

  SearchPropertyViewModel(this.repository);

  List<PropertyEntity> properties = [];
  bool isLoading = false;

  Future<void> search(String location) async {
    if (location.isEmpty) {
      properties = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      properties = await repository.searchProperties(location);
    } catch (e) {
      properties = [];
    }

    isLoading = false;
    notifyListeners();
  }
}