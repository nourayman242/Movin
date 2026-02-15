import 'package:movin/presentation/seller_properties/add_property/add_property_viewmodel.dart';

import '../entities/property_entity.dart';
import '../../data/models/property_model.dart';

abstract class PropertyRepository {
  Future<List<PropertyModel>> getAll();
  Future<void> create(AddPropertyViewModel vm, String token);
  Future<void> update(String id, PropertyEntity property);
  Future<void> delete(String id);
}
