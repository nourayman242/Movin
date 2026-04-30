import 'package:movin/data/api_services/property_services.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/data/models/property_model.dart';

import 'package:movin/domain/repositories/property_repository.dart';
import 'package:movin/presentation/seller_properties/add_property/add_property_viewmodel.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyService service;
  PropertyRepositoryImpl(this.service);

  @override
  Future<List<PropertyModel>> getAll() async {
    return await service.getAllSellerProperties();
  }

  @override

  Future<void> create(AddPropertyViewModel vm, String token) {
    return service.createProperty(vm: vm, token: token);
  }

  @override
  Future<void> update(String id, PropertyEntity property) {
    return service.updateProperty(id, property);
  }

  @override
  Future<void> delete(String id) {
    return service.deleteProperty(id);
  }

  @override
  Future<List<PropertyEntity>> searchProperties(String location) async {
    final models = await service.searchProperties(location);

    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<PropertyEntity>> getRecentProperties() async {
    final models = await service.getRecentProperties();

    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<PropertyEntity>> getRecommendedProperties() async {
    final models = await service.getRecommendedProperties();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<PropertyEntity>> getPropertiesByType(String type) async {
    final models = await service.getPropertiesByType(type);
   return models.map((e) => e.toEntity()).toList();
  }
  @override
Future<void> createAuction({
  required String propertyId,
  required int startPrice,
  required String startTime,
  required String endTime,
}) async {
  await service.createAuction(
    propertyId: propertyId,
    startPrice: startPrice,
    startTime: startTime,
    endTime: endTime,
  );
}
@override
Future<PropertyEntity> getPropertyById(String id) async {
  final model = await service.getPropertyById(id);
  return model.toEntity();
}
}
