// import 'package:movin/data/models/property_request_dto.dart';

// import '../../data/models/property_model.dart';


// abstract class PropertyRepository {
//   Future<PropertyModel> createProperty(PropertyRequest request);
//   Future<List<PropertyModel>> getAllProperties();
//   Future<PropertyModel> updateProperty(String id, Map<String, dynamic> data);
//   Future<void> deleteProperty(String id);
// }
import '../entities/property_entity.dart';

abstract class PropertyRepository {
  Future<void> create(PropertyEntity property);
  Future<void> update(String id, PropertyEntity property);
  Future<void> delete(String id);
}
