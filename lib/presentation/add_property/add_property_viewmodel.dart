
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum PropertyType { apartment, villa, office, townhouse, penthouse }

class AddPropertyViewModel extends ChangeNotifier {
  // Selected property type
  PropertyType? selectedType;

  // Text controllers (shared across sections)
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final areaController = TextEditingController();

  // Details
  final bedroomsController = TextEditingController();
  final bathroomsController = TextEditingController();
  final floorController = TextEditingController();

  bool elevator = false;
  //villa
  final landAreaController = TextEditingController();
  final numOfFloorController = TextEditingController();
  bool garden = false;
  bool parking = false;

  // Office 
  final officeSizeController = TextEditingController();
  final workroomsController = TextEditingController();
  final meetingroomsController = TextEditingController();
  final officParkingController = TextEditingController();
// penthouse specific
  final terraceController = TextEditingController();

  // Description
  final descriptionController = TextEditingController();

  // Images (XFile objects returned by image_picker)
  List<XFile> images = [];

  // Setters that call notifyListeners()
  void selectType(PropertyType? t) {
    selectedType = t;
    notifyListeners();
  }

  void setElevator(bool v) {
    elevator = v;
    notifyListeners();
  }

  void setGarden(bool v) {
    garden = v;
    notifyListeners();
  }

  void setParking(bool v) {
    parking = v;
    notifyListeners();
  }

  void setImages(List<XFile> imgs) {
    images = imgs;
    notifyListeners();
  }

  void addImage(XFile file) {
    images.add(file);
    if (images.length > 12) images = images.sublist(0, 12);
    notifyListeners();
  }

  void removeImageAt(int index) {
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
      notifyListeners();
    }
  }


  bool get isTypeSelected => selectedType != null;

  bool get isBasicValid =>
      priceController.text.trim().isNotEmpty &&
      locationController.text.trim().isNotEmpty &&
      areaController.text.trim().isNotEmpty &&
      descriptionController.text.trim().isNotEmpty &&
      images.isNotEmpty;

  bool get isTypeSpecificValid {
    if (!isTypeSelected) return false;
    final t = selectedType!;
    if (t == PropertyType.office) {
      return officeSizeController.text.trim().isNotEmpty &&
          workroomsController.text.trim().isNotEmpty &&
          meetingroomsController.text.trim().isNotEmpty &&
          officParkingController.text.trim().isNotEmpty;
    }
    if (t == PropertyType.penthouse) {
      return terraceController.text.trim().isNotEmpty &&
          bedroomsController.text.trim().isNotEmpty &&
          bathroomsController.text.trim().isNotEmpty;
    }
    if (t == PropertyType.villa) {
      return landAreaController.text.trim().isNotEmpty &&
          bedroomsController.text.trim().isNotEmpty &&
          bathroomsController.text.trim().isNotEmpty &&
          numOfFloorController.text.trim().isNotEmpty;
    }

    // residential (apartment, townhouse)
    return bedroomsController.text.trim().isNotEmpty &&
        bathroomsController.text.trim().isNotEmpty;
  }

  bool get isFormValid => isTypeSelected && isBasicValid && isTypeSpecificValid;

  // Reset form
  void reset() {
    selectedType = null;
    priceController.clear();
    locationController.clear();
    areaController.clear();
    bedroomsController.clear();
    bathroomsController.clear();
    floorController.clear();
    elevator = false;
    garden = false;
    parking = false;
    landAreaController.clear();
    numOfFloorController.clear();
    officeSizeController.clear();
    workroomsController.clear();
    meetingroomsController.clear();
    officParkingController.clear();
    terraceController.clear();
    descriptionController.clear();
    images = [];
    notifyListeners();
  }

  @override
  void dispose() {
    priceController.dispose();
    locationController.dispose();
    areaController.dispose();
    bedroomsController.dispose();
    bathroomsController.dispose();
    floorController.dispose();
    landAreaController.dispose();
    numOfFloorController.dispose();
    officeSizeController.dispose();
    workroomsController.dispose();
    meetingroomsController.dispose();
    officParkingController.dispose();
    terraceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
