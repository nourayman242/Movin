import 'package:flutter/material.dart';

class ScoreColorMapper {
  static const Color green  = Color(0xFF3B6D11);
  static const Color orange = Color(0xFFBA7517);
  static const Color red    = Color(0xFFA32D2D);

  static Color getColor(double score) {
    if (score >= 70) return green;
    if (score >= 40) return orange;
    return red;
  }

  static String getLabel(double score) {
    if (score >= 70) return 'Nearby';
    if (score >= 40) return 'Moderate';
    return 'Far';
  }
}