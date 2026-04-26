import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../add_property_viewmodel.dart';

class MapSection extends StatefulWidget {
  const MapSection({super.key});

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  GoogleMapController? mapController;
  Marker? marker;

  static const LatLng initialPosition = LatLng(30.0444, 31.2357); // Cairo

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddPropertyViewModel>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Location (Optional)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: initialPosition,
                  zoom: 12,
                ),
                onMapCreated: (controller) {
                  mapController = controller;
                },
                markers: marker != null ? {marker!} : {},
                onTap: (LatLng position) {
                  setState(() {
                    marker = Marker(
                      markerId: const MarkerId("selected"),
                      position: position,
                    );
                  });

                  vm.setLocation(position.latitude, position.longitude);
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          if (vm.latitude != null)
            Text(
              "Selected: ${vm.latitude}, ${vm.longitude}",
              style: const TextStyle(color: Colors.black54),
            ),
        ],
      ),
    );
  }
}