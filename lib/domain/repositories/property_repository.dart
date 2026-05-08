import 'package:image_picker/image_picker.dart';
import 'package:movin/presentation/seller_properties/add_property/add_property_viewmodel.dart';

import '../entities/property_entity.dart';
import '../../data/models/property_model.dart';

abstract class PropertyRepository {
  Future<List<PropertyModel>> getAll();
  Future<void> create(AddPropertyViewModel vm, String token);
  Future<void> update(String id, PropertyEntity property, List<XFile> newImages);
  Future<void> delete(String id);
  Future<List<PropertyEntity>> searchProperties(String location);
  Future<List<PropertyEntity>> getRecentProperties();
  Future<List<PropertyEntity>> getRecommendedProperties();
  Future<List<PropertyEntity>> getPropertiesByType(String type);
  Future<void> createAuction({
    required String propertyId,
    required int startPrice,
    required String startTime,
    required String endTime,
  });
  Future<PropertyEntity> getPropertyById(String id);
  Future<List<PropertyEntity>> getMostViewedProperties();
  Future<List<PropertyEntity>> getViewHistory({int page, int limit});
  Future<void> clearViewHistory();
}