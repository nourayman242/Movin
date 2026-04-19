import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/domain/entities/area_score.dart';
import 'package:movin/domain/utils/score_color_mapper.dart';


class AreaMarkerLayer {
  /// Call this once; it's async because BitmapDescriptor requires painting.
  static Future<Set<Marker>> buildMarkers(
    List<AreaScore> areas, {
    void Function(AreaScore)? onTap,
  }) async {
    final Set<Marker> markers = {};

    for (int i = 0; i < areas.length; i++) {
      final area = areas[i];
      final color = ScoreColorMapper.getColor(area.score);
      final icon = await _buildPinIcon(area.listingCount, color);

      markers.add(
        Marker(
          markerId: MarkerId('area_$i'),
          position: area.center,
          icon: icon,
          anchor: const Offset(0.5, 1.0), // pin tip at coordinate
          infoWindow: InfoWindow(
            title: area.name,
            snippet:
                '${area.listingCount} listings · ${ScoreColorMapper.getLabel(area.score)}',
          ),
          onTap: onTap != null ? () => onTap(area) : null,
        ),
      );
    }

    return markers;
  }

  /// Paints a rounded-rect bubble with listing count + a small dot tail.
  static Future<BitmapDescriptor> _buildPinIcon(
    int count,
    Color color,
  ) async {
    const double w = 90, h = 40, tail = 7;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final bubblePaint = Paint()..color = color;
    final rrect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(0, 0, w, h),
      const Radius.circular(20),
    );
    canvas.drawRRect(rrect, bubblePaint);

    // Small triangle tail at bottom-center
    final tailPath = Path()
      ..moveTo(w / 2 - 6, h)
      ..lineTo(w / 2 + 6, h)
      ..lineTo(w / 2, h + tail)
      ..close();
    canvas.drawPath(tailPath, bubblePaint);

    // Listing count text
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