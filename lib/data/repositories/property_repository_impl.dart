// import 'package:movin/data/models/property_request_dto.dart';

// import '../../domain/repositories/property_repository.dart';
// import '../api_services/property_services.dart';
// import '../models/property_model.dart';


// class PropertyRepositoryImpl implements PropertyRepository {
//   final PropertyServices services;

//   PropertyRepositoryImpl(this.services);

//   @override
//   Future<PropertyModel> createProperty(PropertyRequest request) {
//     return services.createProperty(request);
//   }

//   @override
//   Future<List<PropertyModel>> getAllProperties() {
//     return services.getAllProperties();
//   }

//   @override
//   Future<PropertyModel> updateProperty(
//     String id,
//     Map<String, dynamic> data,
//   ) {
//     return services.updateProperty(id, data);
//   }

//   @override
//   Future<void> deleteProperty(String id) {
//     return services.deleteProperty(id);
//   }
// }

// import 'package:movin/data/api_services/property_services.dart';

// import '../../domain/entities/property_entity.dart';
// import '../../domain/repositories/property_repository.dart';


// class PropertyRepositoryImpl implements PropertyRepository {
//   final PropertyService service;
//   PropertyRepositoryImpl(this.service);

//   @override
//   Future<void> create(PropertyEntity property) {
//     return service.createProperty(property.toJson() as PropertyEntity);
//   }

//   @override
//   Future<void> update(String id, PropertyEntity property) {
//     return service.updateProperty(id, property.toJson());
//   }

//   @override
//   Future<void> delete(String id) {
//     return service.deleteProperty(id);
//   }
// }
import 'package:movin/data/api_services/property_services.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/data/models/property_model.dart';

import 'package:movin/domain/repositories/property_repository.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyService service;
  PropertyRepositoryImpl(this.service);

  @override
  Future<List<PropertyModel>> getAll()async {
    return await service.getAllSellerProperties();
    //  final models = await service.getAllSellerProperties();

    // return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> create(PropertyEntity property) {
    return service.createProperty(property);
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
