
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../add_property_viewmodel.dart';
import 'package:movin/app_theme.dart';

class ImagesSection extends StatefulWidget {
  const ImagesSection({super.key});

  @override
  State<ImagesSection> createState() => _ImagesSectionState();
}

class _ImagesSectionState extends State<ImagesSection> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMultiImages() async {
    try {
      final List<XFile>? picked = await _picker.pickMultiImage(
        imageQuality: 80,
      );
      if (picked != null && picked.isNotEmpty) {
        final vm = context.read<AddPropertyViewModel>();
        final combined = [...vm.images, ...picked];
        final limited = combined.length > 12
            ? combined.sublist(0, 12)
            : combined;
        vm.setImages(limited);
      }
    } catch (e) {
      debugPrint('Image pick error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPropertyViewModel>(
      builder: (context, vm, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Property Images *',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Upload high-quality photos of your property'),
              const SizedBox(height: 12),

              // Tap area to pick images
              GestureDetector(
                onTap: _pickMultiImages,
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: vm.images.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 28,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Add Photo',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            'Add Photo',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 12),

              if (vm.images.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: vm.images.length,
                    itemBuilder: (context, index) {
                      final x = vm.images[index];
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: FileImage(File(x.path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: GestureDetector(
                              onTap: () {
                                vm.removeImageAt(index);
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4),
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
                    },
                  ),
                ),
              const SizedBox(height: 8),
              const Text(
                'You can upload up to 12 images. First image will be the cover photo.',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
