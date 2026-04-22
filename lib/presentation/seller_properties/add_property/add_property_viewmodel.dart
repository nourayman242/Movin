import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movin/domain/entities/property_entity.dart';

enum PropertyType { apartment, villa, office, townhouse, penthouse }

enum ListingType { rent, sale }

class AddPropertyViewModel extends ChangeNotifier {
  // Selected property type
  PropertyType? selectedType;

  ListingType? selectedListingType;
  AddPropertyViewModel() {
    selectedListingType = ListingType.sale; // default
  }
  bool isAuction = false;

  DateTime? auctionStart;
  DateTime? auctionEnd;

  final startingBidController = TextEditingController();
  final auctionDescriptionController = TextEditingController();
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

  // BASIC INFO
  String get location => locationController.text.trim();
  String get description => descriptionController.text.trim();
  int get price => int.parse(priceController.text.trim());
  String get size => '${areaController.text.trim()} sqm';

  // TYPE
  String get type => selectedType!.name;
  String get listingType => selectedListingType!.name;

  // DETAILS
  int? get bedrooms => int.tryParse(bedroomsController.text.trim());
  int? get bathrooms => int.tryParse(bathroomsController.text.trim());

  double? latitude;
  double? longitude;
  void setLocation(double lat, double lng) {
    latitude = lat;
    longitude = lng;
    notifyListeners();
  }

  // Setters that call notifyListeners()
  void selectListingType(ListingType? t) {
    selectedListingType = t;
    notifyListeners();
  }

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

  bool get isAuctionValid {
    if (!isAuction) return true;

    return auctionStart != null &&
        auctionEnd != null &&
        startingBidController.text.trim().isNotEmpty &&
        auctionDescriptionController.text.trim().isNotEmpty;
  }

  void setAuction(bool value) {
    isAuction = value;
    notifyListeners();
  }

  void setAuctionStart(DateTime date) {
    auctionStart = date;
    notifyListeners();
  }

  void setAuctionEnd(DateTime date) {
    auctionEnd = date;
    notifyListeners();
  }

  Map<String, dynamic> get details {
    if (selectedType == null) return {};

    switch (selectedType!) {
      case PropertyType.apartment:
      case PropertyType.townhouse:
        return {
          "bedrooms": bedroomsController.text.trim(),
          "bathrooms": bathroomsController.text.trim(),
          "floor": floorController.text.trim(),
          "elevator": elevator,
        };

      case PropertyType.villa:
        return {
          "bedrooms": bedroomsController.text.trim(),
          "bathrooms": bathroomsController.text.trim(),
          "land_area": landAreaController.text.trim(),
          "floors": numOfFloorController.text.trim(),
          "garden": garden,
          "parking": parking,
        };

      case PropertyType.office:
        return {
          "work_rooms": workroomsController.text.trim(),
          "meeting_rooms": meetingroomsController.text.trim(),
          "parking": officParkingController.text.trim(),
          "size": officeSizeController.text.trim(),
        };

      case PropertyType.penthouse:
        return {
          "bedrooms": bedroomsController.text.trim(),
          "bathrooms": bathroomsController.text.trim(),
          "terrace": terraceController.text.trim(),
        };
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

  //bool get isFormValid => isTypeSelected && isBasicValid && isTypeSpecificValid;
  bool get isFormValid =>
      selectedType != null &&
      selectedListingType != null &&
      isBasicValid &&
      isTypeSpecificValid &&
      isAuctionValid;

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
    isAuction = false;
    auctionStart = null;
    auctionEnd = null;
    startingBidController.clear();
    auctionDescriptionController.clear();
    latitude = null;
    longitude = null;
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
    startingBidController.dispose();
    auctionDescriptionController.dispose();
    super.dispose();
  }

  PropertyEntity toEntity({required List<String> imageUrls}) {
    return PropertyEntity(
      location: locationController.text.trim(),
      description: descriptionController.text.trim(),
      price: int.parse(priceController.text.trim()),
      listingType: listingType,
      type: selectedType!.name,
      size: '${areaController.text.trim()} sqm',
      images: imageUrls,
      details: details,
      id: '',
      status: '',
      isAuction: false,
    );
  }
}
