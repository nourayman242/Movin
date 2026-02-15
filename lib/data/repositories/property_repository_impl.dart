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
    //  final models = await service.getAllSellerProperties();

    // return models.map((m) => m.toEntity()).toList();
  }

  @override
  // Future<void> create(PropertyEntity property) {
  //   return service.createProperty(property);
  // }
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
}
