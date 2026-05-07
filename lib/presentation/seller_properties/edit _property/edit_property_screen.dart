import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/models/property_model.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';

class EditPropertyScreen extends StatefulWidget {
  final PropertyModel property;

  const EditPropertyScreen({super.key, required this.property});

  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController sizeController;
  late TextEditingController bedroomsController;
  late TextEditingController bathroomsController;

  late String selectedType;
  late String selectedStatus;

  late String selectedListingType;
  final ImagePicker picker = ImagePicker();

  late List<String> existingImages;

  List<XFile> newImages = [];

  @override
  void initState() {
    super.initState();

    final p = widget.property;

    titleController = TextEditingController(text: p.title);
    locationController = TextEditingController(text: p.location);
    descriptionController = TextEditingController(text: p.description);
    priceController = TextEditingController(text: p.price.toString());
    sizeController = TextEditingController(text: p.size.toString());
    bedroomsController = TextEditingController(
      text: p.details["bedrooms"]?.toString() ?? "",
    );

    bathroomsController = TextEditingController(
      text: p.details["bathrooms"]?.toString() ?? "",
    );

    selectedType = p.type.toLowerCase();
    selectedStatus = p.status;
    selectedListingType = p.listingType;
    existingImages = List.from(widget.property.images);
  }

  Future<void> _pickImages() async {
    final picked = await picker.pickMultiImage();

    if (picked.isNotEmpty) {
      setState(() {
        newImages.addAll(picked);
      });
    }
  }

  void _removeExistingImage(int index) {
    setState(() {
      existingImages.removeAt(index);
    });
  }

  void _removeNewImage(int index) {
    setState(() {
      newImages.removeAt(index);
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    sizeController.dispose();
    bedroomsController.dispose();
    bathroomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        title: const Text(
          "Edit Property",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryNavy,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Title"),
            _input(titleController),
            _label("Location"),
            _input(locationController),

            _label("Description"),
            _input(descriptionController, maxLines: 3),

            _label("Price (EGP)"),
            _input(priceController, keyboard: TextInputType.number),

            _label("Size"),
            _input(sizeController),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("Bedrooms"),
                      _input(
                        bedroomsController,
                        keyboard: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("Bathrooms"),
                      _input(
                        bathroomsController,
                        keyboard: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            _label("Property Type"),
            DropdownButtonFormField<String>(
              dropdownColor: AppColors.background,
              value: selectedType,
              items: const [
                DropdownMenuItem(value: "villa", child: Text("Villa")),
                DropdownMenuItem(value: "penthouse", child: Text("Penthouse")),
                DropdownMenuItem(value: "apartment", child: Text("Apartment")),
                DropdownMenuItem(value: "office", child: Text("Office")),
                DropdownMenuItem(value: "townhouse", child: Text("Townhouse")),
              ],
              onChanged: (v) => setState(() => selectedType = v!),
              decoration: _decoration(),
            ),

            _label("Listing Type"),
            DropdownButtonFormField<String>(
              value: selectedListingType,
              dropdownColor: AppColors.background,
              items: const [
                DropdownMenuItem(value: "rent", child: Text("Rent")),
                DropdownMenuItem(value: "sale", child: Text("Sale")),
              ],
              onChanged: (v) => setState(() => selectedListingType = v!),
              decoration: _decoration(),
            ),

            const SizedBox(height: 20),

            _label("Property Images"),
            Text(
              "You can add new images or remove existing ones.By Changes all existing ones .",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),

            SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                /// EXISTING IMAGES
                ...List.generate(existingImages.length, (index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          existingImages[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeExistingImage(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),

                /// NEW IMAGES
                ...List.generate(newImages.length, (index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(newImages[index].path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeNewImage(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),

                /// ADD BUTTON
                GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add_a_photo, size: 35),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _onSave,
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSave() async {
    final updatedEntity = PropertyEntity(
      id: widget.property.id,
      title: titleController.text.trim(),

      location: locationController.text.trim(),

      description: descriptionController.text.trim(),

      price: int.tryParse(priceController.text.trim()) ?? 0,

      listingType: selectedListingType,

      type: selectedType,

      size: int.tryParse(sizeController.text.trim()) ?? 0,

      //images: widget.property.images,
      images: existingImages,

      status: widget.property.status,

      details: {
        "bedrooms": bedroomsController.text.trim(),
        "bathrooms": bathroomsController.text.trim(),
      },

      isAuction: widget.property.isAuction,

      latitude: widget.property.latitude,
      longitude: widget.property.longitude,

      auction: widget.property.auction,

      sellerId: widget.property.sellerId,
      sellerName: widget.property.sellerName,
      sellerPhone: widget.property.sellerPhone,
      sellerLocation: widget.property.sellerLocation,

      views: widget.property.views,

      createdAt: widget.property.createdAt,
    );

    final cubit = context.read<PropertyCubit>();

    try {
      await cubit.updateProperty(id: widget.property.id, entity: updatedEntity, newImages: newImages);

      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Property updated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update property: $e')));
    }
  }


  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 16),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ),
  );

  Widget _input(
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboard,
      decoration: _decoration(),
    );
  }

  InputDecoration _decoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
