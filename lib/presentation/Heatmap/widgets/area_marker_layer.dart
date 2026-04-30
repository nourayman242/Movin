import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/domain/entities/area_score.dart';
import 'package:movin/domain/utils/score_color_mapper.dart';

class AreaMarkerLayer {

  static Future<Set<Marker>> buildMarkers(
    List<AreaScore> areas, {
    String? selectedAreaName,
    void Function(AreaScore)? onTap,
  }) async {
    final Set<Marker> markers = {};

    for (int i = 0; i < areas.length; i++) {
      final area = areas[i];
      final isSelected = area.name == selectedAreaName;
      final color = isSelected
          ? const Color(0xFF1A56DB)
          : ScoreColorMapper.getColor(area.score);
      final icon = await _buildPinIcon(
        area.listingCount,
        color,
        isSelected: isSelected,
      );

      markers.add(
        Marker(
          markerId: MarkerId('area_$i'),
          position: area.center,
          icon: icon,
          zIndex: isSelected ? 1 : 0,
          anchor: const Offset(0.5, 1.0),
          infoWindow: InfoWindow(
            title: isSelected ? '📍 ${area.name} (Your area)' : area.name,
            snippet:
                '${area.listingCount} listings · ${ScoreColorMapper.getLabel(area.score)}'
                '${area.distanceKm > 0 ? ' · ${area.distanceKm.toStringAsFixed(1)} km away' : ''}',
          ),
          onTap: onTap != null ? () => onTap(area) : null,
        ),
      );
    }

    return markers;
  }

  static Future<BitmapDescriptor> _buildPinIcon(
    int count,
    Color color, {
    bool isSelected = false,
  }) async {
    const double w = 90, h = 40, tail = 7;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final bubblePaint = Paint()..color = color;
    final rrect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(0, 0, w, h),
      const Radius.circular(20),
    );
    canvas.drawRRect(rrect, bubblePaint);

    // ✅ Draw white border when selected so it's visually distinct
    if (isSelected) {
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;
      canvas.drawRRect(rrect, borderPaint);
    }

    final tailPath = Path()
      ..moveTo(w / 2 - 6, h)
      ..lineTo(w / 2 + 6, h)
      ..lineTo(w / 2, h + tail)
      ..close();
    canvas.drawPath(tailPath, bubblePaint);

    final tp = TextPainter(
      text: TextSpan(
        text: '$count listings',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: w);

    tp.paint(
      canvas,
      Offset((w - tp.width) / 2, (h - tp.height) / 2),
    );

    final image = await recorder
        .endRecording()
        .toImage(w.toInt(), (h + tail).toInt());
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }
}