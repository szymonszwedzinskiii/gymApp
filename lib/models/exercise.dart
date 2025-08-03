// import 'package:flutter/material.dart';
import 'series.dart';

class Exercise {
  final String name;
  List<Series> series;
  
  Exercise({
    required this.name,
    List<Series>? series,
  }) : series = series ?? [];

    String formattedSeries() {
    if (series.isEmpty) return "Brak serii";
    return series.asMap().entries.map((entry) {
      int idx = entry.key + 1;
      final s = entry.value;
      return 'seria$idx - ${s.reps}; ${s.weight}kg';
    }).join(' | ');
  }
}
