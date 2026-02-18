import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController sizeController;
  late TextEditingController bedroomsController;
  late TextEditingController bathroomsController;

  late String selectedType;
  late String selectedStatus;

  @override
  void initState() {
    super.initState();

    final p = widget.property;

    locationController = TextEditingController(text: p.location);
    descriptionController = TextEditingController(text: p.description);
    priceController = TextEditingController(text: p.price.toString());
    sizeController = TextEditingController(text: p.size);
    bedroomsController = TextEditingController(text: p.bedrooms.toString());
    bathroomsController = TextEditingController(text: p.bathrooms.toString());

    
    selectedType = p.type.toLowerCase();
    selectedStatus = p.status;

  }

  @override
  void dispose() {
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
              ],
              onChanged: (v) => setState(() => selectedType = v!),
              decoration: _decoration(),
            ),

            _label("Status"),
            DropdownButtonFormField<String>(
              dropdownColor: AppColors.background,
              value: selectedStatus,
              items: const [
                DropdownMenuItem(value: "active", child: Text("Active")),
                DropdownMenuItem(value: "pending", child: Text("Pending")),
                DropdownMenuItem(value: "sold", child: Text("Sold")),
              ],
              onChanged: (v) => setState(() => selectedStatus = v!),
              decoration: _decoration(),
            ),

            const SizedBox(height: 20),

            _label("Current Images"),
            _imagesPreview(widget.property.images),

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

  // ============================
  // Helpers
  // ============================

  // void _onSave() {
  //   final updatedEntity = PropertyEntity(
  //     location: locationController.text,
  //     description: descriptionController.text,
  //     price: int.parse(priceController.text),
  //     type: selectedType,
  //     size: sizeController.text,
  //     bedrooms: int.tryParse(bedroomsController.text),
  //     bathrooms: int.tryParse(bathroomsController.text),
  //     availableFrom: widget.property.availableFrom,
  //     images: widget.property.images,
  //     paymentMethod: widget.property.paymentMethod,
  //   );

  //   context.read<PropertyCubit>().updateProperty(
  //     id: widget.property.id,
  //     entity: updatedEntity,
  //   );

  //   Navigator.pop(context);
  // }
  void _onSave() async {
    final updatedEntity = PropertyEntity(
      location: locationController.text,
      description: descriptionController.text,
      price: int.parse(priceController.text),
      type: selectedType,
      size: sizeController.text,
      bedrooms: int.tryParse(bedroomsController.text),
      bathrooms: int.tryParse(bathroomsController.text),
      availableFrom: widget.property.availableFrom,
      images: widget.property.images,
      paymentMethod: widget.property.paymentMethod,
    );

    final cubit = context.read<PropertyCubit>();

    try {
      // 1. Call backend to update
      await cubit.updateProperty(id: widget.property.id, entity: updatedEntity);

      // 2. Refresh the listing after update
      await cubit.getAllSellerProperties();

      // 3. Navigate back to listing screen
      if (mounted) Navigator.pop(context);

      // Optional: show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Property updated successfully!')),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update property: $e')));
    }
  }

  Widget _imagesPreview(List<String> images) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final imageUrl = images[i];
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/placeholder.webp',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                );
              },
            ),
          );
        },
      ),
    );
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


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movin/app_theme.dart';
// import 'package:movin/data/models/property_model.dart';
// import 'package:movin/domain/entities/property_entity.dart';
// import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';

// class EditPropertyScreen extends StatefulWidget {
//   final PropertyModel property;

//   const EditPropertyScreen({
//     super.key,
//     required this.property,
//   });

//   @override
//   State<EditPropertyScreen> createState() => _EditPropertyScreenState();
// }

// class _EditPropertyScreenState extends State<EditPropertyScreen> {
//   late TextEditingController locationController;
//   late TextEditingController descriptionController;
//   late TextEditingController priceController;
//   late TextEditingController sizeController;
//   late TextEditingController bedroomsController;
//   late TextEditingController bathroomsController;

//   late String selectedType;
//   late String selectedStatus;

//   @override
//   void initState() {
//     super.initState();

//     final p = widget.property;

//     locationController = TextEditingController(text: p.location);
//     descriptionController = TextEditingController(text: p.description);
//     priceController = TextEditingController(text: p.price.toString());
//     sizeController = TextEditingController(text: p.size);
//     bedroomsController = TextEditingController(text: p.bedrooms.toString());
//     bathroomsController = TextEditingController(text: p.bathrooms.toString());

//     selectedType = p.type;
//     selectedStatus = p.status;
//   }

//   @override
//   void dispose() {
//     locationController.dispose();
//     descriptionController.dispose();
//     priceController.dispose();
//     sizeController.dispose();
//     bedroomsController.dispose();
//     bathroomsController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Property"),
//         backgroundColor: AppColors.primaryNavy,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _label("Location"),
//             _input(locationController),

//             _label("Description"),
//             _input(descriptionController, maxLines: 3),

//             _label("Price (EGP)"),
//             _input(priceController, keyboard: TextInputType.number),

//             _label("Size"),
//             _input(sizeController),

//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _label("Bedrooms"),
//                       _input(
//                         bedroomsController,
//                         keyboard: TextInputType.number,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _label("Bathrooms"),
//                       _input(
//                         bathroomsController,
//                         keyboard: TextInputType.number,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             _label("Property Type"),
//             DropdownButtonFormField<String>(
//               value: selectedType,
//               items: const [
//                 DropdownMenuItem(value: "villa", child: Text("Villa")),
//                 DropdownMenuItem(value: "Penthouse", child: Text("Penthouse")),
//                 DropdownMenuItem(value: "Apartment", child: Text("Apartment")),
//               ],
//               onChanged: (v) => setState(() => selectedType = v!),
//               decoration: _decoration(),
//             ),

//             _label("Status"),
//             DropdownButtonFormField<String>(
//               value: selectedStatus,
//               items: const [
//                 DropdownMenuItem(value: "active", child: Text("Active")),
//                 DropdownMenuItem(value: "pending", child: Text("Pending")),
//                 DropdownMenuItem(value: "sold", child: Text("Sold")),
//               ],
//               onChanged: (v) => setState(() => selectedStatus = v!),
//               decoration: _decoration(),
//             ),

//             const SizedBox(height: 20),

//             _label("Current Images"),
//             _imagesPreview(widget.property.images),

//             const SizedBox(height: 30),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.gold,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 onPressed: _onSave,
//                 child: const Text(
//                   "Save Changes",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // =========================
//   // Save Changes Handler
//   // =========================
//   void _onSave() async {
//     final updatedEntity = PropertyEntity(
//       location: locationController.text,
//       description: descriptionController.text,
//       price: int.parse(priceController.text),
//       type: selectedType,
//       size: sizeController.text,
//       bedrooms: int.tryParse(bedroomsController.text),
//       bathrooms: int.tryParse(bathroomsController.text),
//       availableFrom: widget.property.availableFrom,
//       images: widget.property.images,
//       paymentMethod: widget.property.paymentMethod,
//     );

//     final cubit = context.read<PropertyCubit>();

//     try {
//       // 1. Update property in backend and refresh listing
//       await cubit.updateProperty(
//         id: widget.property.id,
//         entity: updatedEntity,
//       );

//       // 2. Pop back after refresh
//       if (mounted) Navigator.pop(context);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Property updated successfully!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update property: $e')),
//       );
//     }
//   }

//   // =========================
//   // Image Preview with safe network + placeholder
//   // =========================
//   Widget _imagesPreview(List<String> images) {
//     return SizedBox(
//       height: 90,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: images.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 10),
//         itemBuilder: (_, i) {
//           final imageUrl = images[i];

//           return ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.network(
//               imageUrl,
//               width: 90,
//               height: 90,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return Image.asset(
//                   'assets/images/placeholder.png',
//                   width: 90,
//                   height: 90,
//                   fit: BoxFit.cover,
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // =========================
//   // Helpers
//   // =========================
//   Widget _label(String text) => Padding(
//         padding: const EdgeInsets.only(bottom: 6, top: 16),
//         child: Text(
//           text,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//         ),
//       );

//   Widget _input(
//     TextEditingController controller, {
//     int maxLines = 1,
//     TextInputType keyboard = TextInputType.text,
//   }) {
//     return TextField(
//       controller: controller,
//       maxLines: maxLines,
//       keyboardType: keyboard,
//       decoration: _decoration(),
//     );
//   }

//   InputDecoration _decoration() {
//     return InputDecoration(
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
// }

